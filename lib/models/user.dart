// lib/models/user.dart
class User {
  final String id;
  final String name;
  final String email;
  double totalBalance;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.totalBalance = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      totalBalance: (json['totalBalance'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'totalBalance': totalBalance,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    double? totalBalance,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      totalBalance: totalBalance ?? this.totalBalance,
    );
  }
}