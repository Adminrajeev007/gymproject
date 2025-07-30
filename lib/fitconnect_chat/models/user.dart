class User {
  final String id;
  final String username;
  final String name;
  final String? bio;
  final String? location;
  final DateTime createdAt;

  User({
    required this.id,
    required this.username,
    required this.name,
    this.bio,
    this.location,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      bio: json['bio'],
      location: json['location'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'bio': bio,
      'location': location,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}