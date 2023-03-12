class UserProfileModel {
  final String uid;
  final String? email;
  final String? name;
  final String? bio;
  final String? link;

  UserProfileModel({
    required this.uid,
    this.email,
    this.name,
    this.bio,
    this.link,
  });
  factory UserProfileModel.empty() {
    return UserProfileModel(
      uid: "",
    );
  }
}
