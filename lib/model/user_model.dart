class UserModel {
  final int id;
  final String name;
  final String username;
  // final String createdAt;
  // final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      // createdAt: json['created_at'] as String,
      // updatedAt: json['updated_at'] as String,
    );
  }
}
