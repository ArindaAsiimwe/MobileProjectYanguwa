import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String message;
  User user;
  String token;

  UserModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
        "token": token,
      };
}

class User {
    String name;
    String email;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    User({
        required this.name,
        required this.email,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };

}
