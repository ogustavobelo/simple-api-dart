class User {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
    this.updatedAt,
  });
}
