import 'dart:convert';

import 'package:xilancer/helper/extension/string_extension.dart';

import 'subscription_type_model.dart';

SubscriptionListModel subscriptionListModelFromJson(String str) =>
    SubscriptionListModel.fromJson(json.decode(str));

String subscriptionListModelToJson(SubscriptionListModel data) =>
    json.encode(data.toJson());

class SubscriptionListModel {
  SubscriptionsData? subscriptionsData;

  SubscriptionListModel({
    this.subscriptionsData,
  });

  factory SubscriptionListModel.fromJson(json) => SubscriptionListModel(
        subscriptionsData: json["subscriptions"] == null
            ? null
            : SubscriptionsData.fromJson(json["subscriptions"]),
      );

  Map<String, dynamic> toJson() => {
        "subscriptions": subscriptionsData?.toJson(),
      };
}

class SubscriptionsData {
  List<Subscription>? subscriptions;
  dynamic nextPageUrl;

  SubscriptionsData({
    this.subscriptions,
    this.nextPageUrl,
  });

  factory SubscriptionsData.fromJson(Map<String, dynamic> json) =>
      SubscriptionsData(
        subscriptions: json["data"] == null
            ? []
            : List<Subscription>.from(
                json["data"]!.map((x) => Subscription.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": subscriptions == null
            ? []
            : List<dynamic>.from(subscriptions!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class Subscription {
  dynamic id;
  dynamic subscriptionTypeId;
  String? title;
  String? logo;
  num price;
  num limit;
  SubscriptionType? subscriptionType;
  List<Feature>? features;

  Subscription({
    this.id,
    this.subscriptionTypeId,
    this.title,
    this.logo,
    required this.price,
    required this.limit,
    this.subscriptionType,
    this.features,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["id"],
        subscriptionTypeId: json["subscription_type_id"],
        title: json["title"],
        logo: json["logo"],
        price: json["price"].toString().tryToParse,
        limit: json["limit"].toString().tryToParse,
        subscriptionType: json["subscription_type"] == null
            ? null
            : SubscriptionType.fromJson(json["subscription_type"]),
        features: json["features"] == null
            ? []
            : List<Feature>.from(
                json["features"]!.map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subscription_type_id": subscriptionTypeId,
        "title": title,
        "logo": logo,
        "price": price,
        "limit": limit,
        "subscription_type": subscriptionType?.toJson(),
        "features": features == null
            ? []
            : List<dynamic>.from(features!.map((x) => x.toJson())),
      };
}

class Feature {
  dynamic id;
  dynamic subscriptionId;
  String? feature;
  bool status;

  Feature({
    this.id,
    this.subscriptionId,
    this.feature,
    required this.status,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        subscriptionId: json["subscription_id"],
        feature: json["feature"],
        status: json["status"].toString() == "on",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subscription_id": subscriptionId,
        "feature": feature,
      };
}
