import 'dart:convert';

import 'package:xilancer/helper/extension/string_extension.dart';

import 'category_model.dart';

ProjectDetailsModel projectDetailsModelFromJson(String str) =>
    ProjectDetailsModel.fromJson(json.decode(str));

String projectDetailsModelToJson(ProjectDetailsModel data) =>
    json.encode(data.toJson());

class ProjectDetailsModel {
  ProjectDetails? projectDetails;
  String? projectImagePath;

  ProjectDetailsModel({
    this.projectDetails,
    this.projectImagePath,
  });

  factory ProjectDetailsModel.fromJson(json) => ProjectDetailsModel(
        projectDetails: json["project_details"] == null
            ? null
            : ProjectDetails.fromJson(json["project_details"]),
        projectImagePath: json["project_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "project_details": projectDetails?.toJson(),
        "project_image_path": projectImagePath,
      };
}

class ProjectDetails {
  dynamic id;
  dynamic userId;
  dynamic categoryId;
  String? title;
  String? slug;
  String? description;
  String? image;
  String? basicTitle;
  String? standardTitle;
  String? premiumTitle;
  String? basicRevision;
  String? standardRevision;
  String? premiumRevision;
  String? basicDelivery;
  String? standardDelivery;
  String? premiumDelivery;
  num basicRegularCharge;
  num basicDiscountCharge;
  num standardRegularCharge;
  num standardDiscountCharge;
  num premiumRegularCharge;
  num premiumDiscountCharge;
  String projectOnOff;
  String projectApproveRequest;
  String status;
  String? isPro;
  DateTime? proExpireDate;
  bool offerPackagesAvailableOrNot;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category? projectCategory;
  List<SubCategory>? projectSubCategories;
  List<ProjectAttribute>? projectAttributes;
  num completeOrdersCount;
  num ratingsCount;
  num ratingsAvgRating;

  ProjectDetails({
    this.id,
    this.userId,
    this.categoryId,
    this.title,
    this.slug,
    this.description,
    this.image,
    this.basicTitle,
    this.standardTitle,
    this.premiumTitle,
    this.basicRevision,
    this.standardRevision,
    this.premiumRevision,
    this.basicDelivery,
    this.standardDelivery,
    this.premiumDelivery,
    required this.basicRegularCharge,
    required this.basicDiscountCharge,
    required this.standardRegularCharge,
    required this.standardDiscountCharge,
    required this.premiumRegularCharge,
    required this.premiumDiscountCharge,
    required this.projectOnOff,
    required this.projectApproveRequest,
    required this.completeOrdersCount,
    required this.ratingsCount,
    required this.ratingsAvgRating,
    required this.status,
    this.isPro,
    this.proExpireDate,
    required this.offerPackagesAvailableOrNot,
    this.createdAt,
    this.updatedAt,
    this.projectCategory,
    this.projectSubCategories,
    this.projectAttributes,
  });

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        basicTitle: json["basic_title"],
        standardTitle: json["standard_title"],
        premiumTitle: json["premium_title"],
        basicRevision: json["basic_revision"],
        standardRevision: json["standard_revision"],
        premiumRevision: json["premium_revision"],
        basicDelivery: json["basic_delivery"],
        standardDelivery: json["standard_delivery"],
        premiumDelivery: json["premium_delivery"],
        basicRegularCharge: json["basic_regular_charge"].toString().tryToParse,
        basicDiscountCharge:
            json["basic_discount_charge"].toString().tryToParse,
        standardRegularCharge:
            json["standard_regular_charge"].toString().tryToParse,
        standardDiscountCharge:
            json["standard_discount_charge"].toString().tryToParse,
        premiumRegularCharge:
            json["premium_regular_charge"].toString().tryToParse,
        premiumDiscountCharge:
            json["premium_discount_charge"].toString().tryToParse,
        projectOnOff: json["project_on_off"].toString(),
        projectApproveRequest: json["project_approve_request"].toString(),
        status: json["status"].toString(),
        isPro: json["is_pro"].toString(),
        completeOrdersCount:
            json["complete_orders_count"].toString().tryToParse,
        ratingsCount: json["ratings_count"].toString().tryToParse,
        ratingsAvgRating: json["ratings_avg_rating"].toString().tryToParse,
        proExpireDate: json["pro_expire_date"] == null
            ? null
            : DateTime.parse(json["pro_expire_date"]),
        offerPackagesAvailableOrNot:
            json["offer_packages_available_or_not"].toString() != "0",
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        projectCategory: json["project_category"] == null
            ? null
            : Category.fromJson(json["project_category"]),
        projectSubCategories: json["project_sub_categories"] == null
            ? []
            : List<SubCategory>.from(json["project_sub_categories"]!
                .map((x) => SubCategory.fromJson(x))),
        projectAttributes: json["project_attributes"] == null
            ? []
            : List<ProjectAttribute>.from(json["project_attributes"]!
                .map((x) => ProjectAttribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category_id": categoryId,
        "title": title,
        "slug": slug,
        "description": description,
        "image": image,
        "basic_title": basicTitle,
        "standard_title": standardTitle,
        "premium_title": premiumTitle,
        "basic_revision": basicRevision,
        "standard_revision": standardRevision,
        "premium_revision": premiumRevision,
        "basic_delivery": basicDelivery,
        "standard_delivery": standardDelivery,
        "premium_delivery": premiumDelivery,
        "basic_regular_charge": basicRegularCharge,
        "basic_discount_charge": basicDiscountCharge,
        "standard_regular_charge": standardRegularCharge,
        "standard_discount_charge": standardDiscountCharge,
        "premium_regular_charge": premiumRegularCharge,
        "premium_discount_charge": premiumDiscountCharge,
        "project_on_off": projectOnOff,
        "project_approve_request": projectApproveRequest,
        "status": status,
        "is_pro": isPro,
        "pro_expire_date": proExpireDate?.toIso8601String(),
        "offer_packages_available_or_not": offerPackagesAvailableOrNot,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "project_category": projectCategory?.toJson(),
        "project_sub_categories": projectSubCategories == null
            ? []
            : List<dynamic>.from(projectSubCategories!.map((x) => x.toJson())),
        "project_attributes": projectAttributes == null
            ? []
            : List<dynamic>.from(projectAttributes!.map((x) => x.toJson())),
      };
}

class ProjectAttribute {
  int? id;
  int? userId;
  int? createProjectId;
  String? type;
  String? checkNumericTitle;
  String? basicCheckNumeric;
  String? standardCheckNumeric;
  String? premiumCheckNumeric;

  ProjectAttribute({
    this.id,
    this.userId,
    this.createProjectId,
    this.type,
    this.checkNumericTitle,
    this.basicCheckNumeric,
    this.standardCheckNumeric,
    this.premiumCheckNumeric,
  });

  factory ProjectAttribute.fromJson(Map<String, dynamic> json) =>
      ProjectAttribute(
        id: json["id"],
        userId: json["user_id"],
        createProjectId: json["create_project_id"],
        type: json["type"],
        checkNumericTitle: json["check_numeric_title"],
        basicCheckNumeric: json["basic_check_numeric"],
        standardCheckNumeric: json["standard_check_numeric"],
        premiumCheckNumeric: json["premium_check_numeric"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "create_project_id": createProjectId,
        "type": type,
        "check_numeric_title": checkNumericTitle,
        "basic_check_numeric": basicCheckNumeric,
        "standard_check_numeric": standardCheckNumeric,
        "premium_check_numeric": premiumCheckNumeric,
      };
}

class ProjectCategory {
  int? id;
  String? category;

  ProjectCategory({
    this.id,
    this.category,
  });

  factory ProjectCategory.fromJson(Map<String, dynamic> json) =>
      ProjectCategory(
        id: json["id"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
      };
}

class ProjectSubCategory {
  int? id;
  String? subCategory;

  ProjectSubCategory({
    this.id,
    this.subCategory,
  });

  factory ProjectSubCategory.fromJson(Map<String, dynamic> json) =>
      ProjectSubCategory(
        id: json["id"],
        subCategory: json["sub_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_category": subCategory,
      };
}
