import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();
const storage = admin.storage();
const db = admin.firestore();
const region = functions.region("asia-northeast3");
export const onLikeCreated = region.firestore.document("likes/{likeId}").onCreate(
    async (snapshot, context) => {
        const [videoId, _userId] = snapshot.id.split("_");
        await db.collection("videos").doc(videoId).update({
            likes: admin.firestore.FieldValue.increment(1),
        });

    },
);
export const onLikeDeleted = region.firestore.document("likes/{likeId}").onDelete(
    async (snapshot, context) => {
        const [videoId, _userId] = snapshot.id.split("_");
        await db.collection("videos").doc(videoId).update({
            likes: admin.firestore.FieldValue.increment(-1),
        });

    },
);
export const onVideoCreated = region.firestore
    .document("videos/{videoId}")
    .onCreate(async (snapshot, context) => {
        // snapshot.ref.update({ "hello": "from functions" });
        const spawn = require("child-process-promise").spawn;
        const video = snapshot.data();
        const thumbnailPath = `/tmp/${snapshot.id}.jpg`;
        await spawn("ffmpeg", [
            "-i",
            video.fileUrl,
            "-ss",
            "00:00:01.000",
            "-vframes",
            "1",
            "-vf",
            "scale=150:-1",
            thumbnailPath,
        ]);

        const [file, _] = await storage.bucket().upload(thumbnailPath, {
            destination: `thumbnails/${snapshot.id}.jpg`,
        });
        await file.makePublic();
        await snapshot.ref.update({ thumbnailUrl: file.publicUrl(), });
        await db.collection("profiles").doc(video.creatorUid).collection("videos").doc(snapshot.id).set({
            thumbnailUrl: file.publicUrl(),
            videoId: snapshot.id,
        });
    });