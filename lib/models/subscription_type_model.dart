import 'dart:convert';

import 'package:xilancer/helper/extension/string_extension.dart';

SubscriptionTypesModel subscriptionTypesModelFromJson(String str) =>
    SubscriptionTypesModel.fromJson(json.decode(str));

String subscriptionTypesModelToJson(SubscriptionTypesModel data) =>
    json.encode(data.toJson());

class SubscriptionTypesModel {
  List<SubscriptionType>? subscriptionTypes;

  SubscriptionTypesModel({
    this.subscriptionTypes,
  });

  factory SubscriptionTypesModel.fromJson(json) => SubscriptionTypesModel(
        subscriptionTypes: json["subscription_types"] == null
            ? []
            : List<SubscriptionType>.from(json["subscription_types"]!
                .map((x) => SubscriptionType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subscription_types": subscriptionTypes == null
            ? []
            : List<dynamic>.from(subscriptionTypes!.map((x) => x.toJson())),
      };
}

class SubscriptionType {
  dynamic id;
  String type;
  num validity;

  SubscriptionType({
    this.id,
    required this.type,
    required this.validity,
  });

  factory SubscriptionType.fromJson(Map<String, dynamic> json) =>
      SubscriptionType(
        id: json["id"],
        type: json["type"],
        validity: json["validity"].toString().tryToParse,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "validity": validity,
      };
}
