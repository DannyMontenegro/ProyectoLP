import 'dart:convert';
class InternshipStudent {
    InternshipStudent({
        this.id,
        required this.status,
        required this.idStudent,
        required this.idInternship,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String status;
    int idStudent;
    int idInternship;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory InternshipStudent.fromJson(dynamic str) => InternshipStudent.fromMap(str);

    String toJson() => json.encode(toMap());

    factory InternshipStudent.fromMap(dynamic json) => InternshipStudent(
        id: json["id"],
        status: json["status"],
        idStudent: json["idStudent"],
        idInternship: json["idInternship"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "idStudent": idStudent,
        "idInternship": idInternship,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
