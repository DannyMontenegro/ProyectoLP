import 'dart:convert';
import 'package:pasantic_frontend/models/models.dart';

class Internship {
  Internship({
    this.id,
    required this.title,
    required this.description,
    required this.industry,
    this.isActive,
    this.isRecruiting,
    required this.internshipProcess,
    required this.dateFrom,
    required this.dateTo,
    required this.location,
    required this.workMode,
    required this.payment,
    required this.idEnterprise,
    this.createdAt,
    this.updatedAt,
    this.enterprise,
    required this.internshipStudents,
  });

  int? id;
  String title;
  String description;
  String industry;
  bool? isActive;
  bool? isRecruiting;
  String internshipProcess;
  DateTime dateFrom;
  DateTime dateTo;
  String location;
  String workMode;
  int payment;
  int idEnterprise;
  DateTime? createdAt;
  DateTime? updatedAt;
  Enterprise? enterprise;
  List<InternshipStudent> internshipStudents;

  factory Internship.fromJson(dynamic str) =>
      Internship.fromMap(str);

  String toJson() => json.encode(toMap());

  factory Internship.fromMap(dynamic json) => Internship(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        industry: json["industry"],
        isActive: json["isActive"],
        isRecruiting: json["isRecruiting"],
        internshipProcess: json["internshipProcess"],
        dateFrom: DateTime.parse(json["dateFrom"]),
        dateTo: DateTime.parse(json["dateTo"]),
        location: json["location"],
        workMode: json["workMode"],
        payment: json["payment"],
        idEnterprise: json["idEnterprise"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        enterprise: Enterprise.fromMap(json["Enterprise"]),
        internshipStudents: List<InternshipStudent>.from(
            json["InternshipStudents"]
                .map((x) => InternshipStudent.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "industry": industry,
        "isActive": isActive,
        "isRecruiting": isRecruiting,
        "internshipProcess": internshipProcess,
        "dateFrom":
            "${dateFrom.year.toString().padLeft(4, '0')}-${dateFrom.month.toString().padLeft(2, '0')}-${dateFrom.day.toString().padLeft(2, '0')}",
        "dateTo":
            "${dateTo.year.toString().padLeft(4, '0')}-${dateTo.month.toString().padLeft(2, '0')}-${dateTo.day.toString().padLeft(2, '0')}",
        "location": location,
        "workMode": workMode,
        "payment": payment,
        "idEnterprise": idEnterprise,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Enterprise": enterprise?.toMap(),
        "InternshipStudents":
            List<dynamic>.from(internshipStudents.map((x) => x.toMap())),
      };
}
