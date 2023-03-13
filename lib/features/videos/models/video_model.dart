// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String creatorUid;
  final String creator;
  final int likes;
  final int comments;
  final int createdAt;

  VideoModel({
    required this.title,
    required this.description,
    required this.fileUrl,
    required this.thumbnailUrl,
    required this.creatorUid,
    required this.creator,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  VideoModel copyWith({
    String? title,
    String? description,
    String? fileUrl,
    String? thumbnailUrl,
    String? creatorUid,
    String? creator,
    int? likes,
    int? comments,
    int? createdAt,
  }) {
    return VideoModel(
      title: title ?? this.title,
      description: description ?? this.description,
      fileUrl: fileUrl ?? this.fileUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      creatorUid: creatorUid ?? this.creatorUid,
      creator: creator ?? this.creator,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory VideoModel.empty() {
    return VideoModel(
      title: "",
      description: "",
      fileUrl: "",
      thumbnailUrl: "",
      creatorUid: "",
      creator: "",
      likes: 0,
      comments: 0,
      createdAt: DateTime.now().microsecondsSinceEpoch,
    );
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'fileUrl': fileUrl,
      'thumbnailUrl': thumbnailUrl,
      'creatorUid': creatorUid,
      'creator': creator,
      'likes': likes,
      'comments': comments,
      'createdAt': createdAt,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      title: map['title'] as String,
      description: map['description'] as String,
      fileUrl: map['fileUrl'] as String,
      thumbnailUrl: map['thumbnailUrl'] as String,
      creatorUid: map['creatorUid'] as String,
      creator: map['creator'] as String,
      likes: map['likes'] as int,
      comments: map['comments'] as int,
      createdAt: map['createdAt'] as int,
    );
  }
}
