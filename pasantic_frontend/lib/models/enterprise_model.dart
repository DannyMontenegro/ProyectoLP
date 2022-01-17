import 'dart:convert';

class Enterprise {
    Enterprise({
        this.id,
        required this.phoneNumber,
        required this.idUser,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String phoneNumber;
    int idUser;
    dynamic createdAt;
    dynamic updatedAt;

    factory Enterprise.fromJson(dynamic str) => Enterprise.fromMap(str);

    String toJson() => json.encode(toMap());

    factory Enterprise.fromMap(dynamic json) => Enterprise(
        id: json["id"],
        phoneNumber: json["phone_number"],
        idUser: json["idUser"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "phone_number": phoneNumber,
        "idUser": idUser,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
    };
}