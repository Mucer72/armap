class UserModel {
  final int id;
  final String email;
  final String username;
  final String password;
  final int area;

  UserModel({required this.id, required this.email, required this.username, required this.password, required this.area});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      area: json['area'],
    );
  }
}
