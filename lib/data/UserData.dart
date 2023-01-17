class UserData{
  bool success;
  bool verified;
  String token;
  String refreshToken;
  String username;
  String email;
  String id;
  int pk;
  String profileImage;

  UserData ({
    required this.success,
    required this.verified,
    required this.token,
    required this.refreshToken,
    required this.username,
    required this.email,
    required this.id,
    required this.pk,
    required this.profileImage,
  });
}

