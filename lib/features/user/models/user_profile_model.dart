// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserProfileModel {
  final String uid;
  final String? email;
  final String? name;
  final String? bio;
  final String? link;
  final String? birthday;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    this.email,
    this.name,
    this.bio,
    this.link,
    this.birthday,
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
      'birthday': birthday,
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
      birthday: map['birthday'] != null ? map['birthday'] as String : null,
      hasAvatar: map['hasAvatar'] as bool,
    );
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? bio,
    String? link,
    String? birthday,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      link: link ?? this.link,
      birthday: birthday ?? this.birthday,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
