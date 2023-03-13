// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  final String text;
  final String userId;
  final int createdAt;

  MessageModel({
    required this.text,
    required this.userId,
    required this.createdAt,
  });

  MessageModel copyWith({
    String? text,
    String? userId,
    int? createdAt,
  }) {
    return MessageModel(
      text: text ?? this.text,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'userId': userId,
      'createdAt': createdAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] as String,
      userId: map['userId'] as String,
      createdAt: map['createdAt'] as int,
    );
  }

  @override
  String toString() =>
      'MessageModel(text: $text, userId: $userId, createdAt: $createdAt)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.userId == userId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => text.hashCode ^ userId.hashCode ^ createdAt.hashCode;
}
