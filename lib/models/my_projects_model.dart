// To parse this JSON data, do
//
//     final myProjectsModel = myProjectsModelFromJson(jsonString);

import 'dart:convert';

import 'package:xilancer/helper/extension/string_extension.dart';

MyProjectsModel myProjectsModelFromJson(String str) =>
    MyProjectsModel.fromJson(json.decode(str));

String myProjectsModelToJson(MyProjectsModel data) =>
    json.encode(data.toJson());

class MyProjectsModel {
  ProjectLists? projectLists;
  String? projectImagePath;

  MyProjectsModel({
    this.projectLists,
    this.projectImagePath,
  });

  factory MyProjectsModel.fromJson(json) => MyProjectsModel(
        projectLists: json["project_lists"] == null
            ? null
            : ProjectLists.fromJson(json["project_lists"]),
        projectImagePath: json["project_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "project_lists": projectLists?.toJson(),
        "project_image_path": projectImagePath,
      };
}

class ProjectLists {
  int? currentPage;
  List<Project>? data;
  dynamic nextPageUrl;

  ProjectLists({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  factory ProjectLists.fromJson(Map<String, dynamic> json) => ProjectLists(
        data: json["data"] == null
            ? []
            : List<Project>.from(json["data"]!.map((x) => Project.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class Project {
  dynamic id;
  dynamic userId;
  String? title;
  String? image;
  String? basicDelivery;
  num basicRegularCharge;
  String? status;
  num completeOrdersCount;
  num ratingsCount;
  num ratingsAvgRating;

  num? basicDiscountCharge;

  Project({
    this.id,
    this.userId,
    this.title,
    this.image,
    this.basicDelivery,
    required this.basicRegularCharge,
    required this.status,
    required this.basicDiscountCharge,
    required this.completeOrdersCount,
    required this.ratingsCount,
    required this.ratingsAvgRating,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        image: json["image"],
        basicDelivery: json["basic_delivery"],
        basicRegularCharge: json["basic_regular_charge"].toString().tryToParse,
        basicDiscountCharge:
            json["basic_discount_charge"]?.toString().tryToParse,
        status: json["status"].toString(),
        completeOrdersCount:
            json["complete_orders_count"].toString().tryToParse,
        ratingsCount: json["ratings_count"].toString().tryToParse,
        ratingsAvgRating: json["ratings_avg_rating"].toString().tryToParse,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "image": image,
        "basic_regular_charge": basicRegularCharge,
        "status": status,
        "complete_orders_count": completeOrdersCount,
        "ratings_count": ratingsCount,
        "ratings_avg_rating": ratingsAvgRating,
      };
}
