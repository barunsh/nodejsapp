class User {
  final String id;
  final String names;
  final int phone;
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
      id: json['id'] ?? '',
      names: json['names'] ?? '',
      phone: json['phone'] ?? 0,
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
