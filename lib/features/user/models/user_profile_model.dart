// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfileModel {
  final String uid;
  final String? email;
  final String? name;
  final String? bio;
  final String? link;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    this.email,
    this.name,
    this.bio,
    this.link,
    this.hasAvatar = false,
  });
  factory UserProfileModel.empty() {
    return UserProfileModel(
      uid: "",
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'name': name,
      'bio': bio,
      'link': link,
      'hasAvatar': hasAvatar,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      uid: map['uid'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      bio: map['bio'] != null ? map['bio'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      hasAvatar: map['hasAvatar'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfileModel(uid: $uid, email: $email, name: $name, bio: $bio, link: $link, hasAvatar: $hasAvatar)';
  }

  @override
  bool operator ==(covariant UserProfileModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.bio == bio &&
        other.link == link &&
        other.hasAvatar == hasAvatar;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        email.hashCode ^
        name.hashCode ^
        bio.hashCode ^
        link.hashCode ^
        hasAvatar.hashCode;
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
