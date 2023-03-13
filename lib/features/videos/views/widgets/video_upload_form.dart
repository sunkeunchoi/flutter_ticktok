import 'package:flutter/material.dart';

import '../../models/video_upload.dart';

class VideoUploadForm extends StatefulWidget {
  const VideoUploadForm({super.key});
  static Route<VideoUpload?> route() =>
      MaterialPageRoute(builder: (context) => const VideoUploadForm());
  @override
  State<VideoUploadForm> createState() => _VideoUploadFormState();
}

class _VideoUploadFormState extends State<VideoUploadForm> {
  late final TextEditingController _titleContoller =
      TextEditingController(text: "");
  late final TextEditingController _descriptionContoller =
      TextEditingController(text: "");
  void _onSubmit() {
    final data = VideoUpload(
      title: _titleContoller.text,
      description: _descriptionContoller.text,
    );
    Navigator.pop(
      context,
      data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video upload"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 24),
                const CloseButton(),
                const SizedBox(height: 24),
                TextField(
                  controller: _titleContoller,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _descriptionContoller,
                  maxLength: 250,
                  maxLines: null,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: _onSubmit,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Upload Video",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
