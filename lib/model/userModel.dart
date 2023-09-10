class User {
  String fullName, email, password;

  User({required this.email, required this.fullName, required this.password});

  factory User.fromJson(Map<String, dynamic> fromJson) {
    return User(
        email: fromJson['email'],
        fullName: fromJson['fullName'],
        password: fromJson['password']);
  }
}
