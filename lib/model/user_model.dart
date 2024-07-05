class UserModel {
  String? name;
  String? userId;
  String? email;
  String? id;

  UserModel({
    this.email,
    this.name,
    this.userId,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      userId: json['userid'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'userid': userId,
      'id': id,
    };
  }
}
