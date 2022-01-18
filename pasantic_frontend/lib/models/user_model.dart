// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

import 'package:pasantic_frontend/models/models.dart';

class User {
    User({
        required this.status,
        required this.payload,
    });

    int status;
    Payload payload;

    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory User.fromMap(Map<String, dynamic> json) => User(
        status: json["status"],
        payload: Payload.fromMap(json["payload"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "payload": payload.toMap(),
    };
}

class Payload {
    Payload({
        required this.user,
    });

    UserClass user;

    factory Payload.fromJson(String str) => Payload.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        user: UserClass.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "user": user.toMap(),
    };
}

class UserClass {
    UserClass({
        required this.id,
        required this.email,
        required this.password,
        required this.name,
        required this.description,
        required this.role,
        this.createdAt,
        this.updatedAt,
        this.student,
        this.enterprise,
    });

    int id;
    String email;
    String password;
    String name;
    String description;
    String role;
    dynamic createdAt;
    dynamic updatedAt;
    dynamic? student;
    Enterprise? enterprise;

    factory UserClass.fromJson(String str) => UserClass.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserClass.fromMap(Map<String, dynamic> json) => UserClass(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        description: json["description"],
        role: json["role"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        student: json["Student"],
        enterprise: Enterprise.fromMap(json["Enterprise"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "description": description,
        "role": role,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "Student": student,
        "Enterprise": enterprise?.toMap(),
    };
}

