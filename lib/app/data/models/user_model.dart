class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String userId;
  final double balance;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.userId,
    this.balance = 0.0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      photoUrl: json['photo_url'],
      userId: json['user_id'] ?? '',
      balance: (json['balance'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo_url': photoUrl,
      'user_id': userId,
      'balance': balance,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    String? userId,
    double? balance,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      userId: userId ?? this.userId,
      balance: balance ?? this.balance,
    );
  }
}


