class User {
  final String id;
  final String names;
  final String phone;
  final String email;
  final String password;
  final String role;

  User({
    required this.id,
    required this.names,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      names: json['names'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
