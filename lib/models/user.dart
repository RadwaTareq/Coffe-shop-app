class UserModel {
  String? username;
  String? email;
  String? uId;

  UserModel(this.uId, this.username, this.email);

  Map<String, String> toMap() {
    return {
      'username': username ?? '',
      'email': email ?? '',
    };
  }
}
