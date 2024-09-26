import 'dart:convert';

TicketListModel ticketListModelFromJson(String str) =>
    TicketListModel.fromJson(json.decode(str));

class TicketListModel {
  TicketListModel({
    required this.data,
    this.nextPageUrl,
  });

  List<Datum> data;
  dynamic nextPageUrl;

  factory TicketListModel.fromJson(Map json) => TicketListModel(
        data: List<Datum>.from(
            json["tickets"]["data"].map((x) => Datum.fromJson(x))),
        nextPageUrl: json["tickets"]["next_page_url"],
      );
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    this.via,
    this.operatingSystem,
    required this.userAgent,
    required this.description,
    required this.subject,
    required this.status,
    required this.priority,
    required this.departments,
    required this.userId,
    this.adminId,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String title;
  dynamic via;
  dynamic operatingSystem;
  dynamic userAgent;
  dynamic description;
  dynamic subject;
  dynamic status;
  dynamic priority;
  dynamic departments;
  dynamic userId;
  dynamic adminId;
  dynamic createdAt;
  dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        via: json["via"],
        operatingSystem: json["operating_system"],
        userAgent: json["user_agent"],
        description: json["description"],
        subject: json["subject"],
        status: json["status"],
        priority: json["priority"],
        departments: json["departments"],
        userId: json["user_id"],
        adminId: json["admin_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

DepartmentModel deparmentModelFromJson(String str) =>
    DepartmentModel.fromJson(json.decode(str));

String deparmentModelToJson(DepartmentModel data) => json.encode(data.toJson());

class DepartmentModel {
  DepartmentModel({
    required this.data,
  });

  List<Department> data;

  factory DepartmentModel.fromJson(Map json) => DepartmentModel(
        data: json["departments"] == null
            ? []
            : List<Department>.from(
                json["departments"].map((x) => Department.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Department {
  Department({
    required this.id,
    required this.name,
    required this.status,
  });

  dynamic id;
  String name;
  dynamic status;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
      };
}
