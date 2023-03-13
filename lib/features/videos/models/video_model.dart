class VideoModel {
  final String title;
  final String description;
  final String fileUrl;
  final String thumbnailUrl;
  final String createdBy;
  final int likes;
  final int comments;
  final int createdAt;

  VideoModel({
    required this.title,
    required this.fileUrl,
    required this.createdBy,
    required this.createdAt,
    required this.description,
    required this.thumbnailUrl,
    required this.likes,
    required this.comments,
  });
}
