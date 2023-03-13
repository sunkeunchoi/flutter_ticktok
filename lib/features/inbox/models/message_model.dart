// ignore_for_file: public_member_api_docs, sort_constructors_first
class MessageModel {
  final String text;
  final String userId;

  MessageModel({
    required this.text,
    required this.userId,
  });

  MessageModel copyWith({
    String? text,
    String? userId,
  }) {
    return MessageModel(
      text: text ?? this.text,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'userId': userId,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] as String,
      userId: map['userId'] as String,
    );
  }
}
