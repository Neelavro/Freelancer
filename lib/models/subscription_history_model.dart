import 'dart:convert';

import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/models/subscription_type_model.dart';

SubscriptionHistoryModel subscriptionHistoryModelFromJson(String str) =>
    SubscriptionHistoryModel.fromJson(json.decode(str));

String subscriptionHistoryModelToJson(SubscriptionHistoryModel data) =>
    json.encode(data.toJson());

class SubscriptionHistoryModel {
  AllSubscriptions? allSubscriptions;
  String? totalLimit;

  SubscriptionHistoryModel({
    this.allSubscriptions,
    this.totalLimit,
  });

  factory SubscriptionHistoryModel.fromJson(json) => SubscriptionHistoryModel(
        allSubscriptions: json["all_subscriptions"] == null
            ? null
            : AllSubscriptions.fromJson(json["all_subscriptions"]),
        totalLimit: json["total_limit"],
      );

  Map<String, dynamic> toJson() => {
        "all_subscriptions": allSubscriptions?.toJson(),
        "total_limit": totalLimit,
      };
}

class AllSubscriptions {
  List<History>? history;
  dynamic nextPageUrl;

  AllSubscriptions({
    this.history,
    this.nextPageUrl,
  });

  factory AllSubscriptions.fromJson(Map<String, dynamic> json) =>
      AllSubscriptions(
        history: json["data"] == null
            ? []
            : List<History>.from(json["data"]!.map((x) => History.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "history": history == null
            ? []
            : List<dynamic>.from(history!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class History {
  dynamic id;
  dynamic userId;
  dynamic subscriptionId;
  num price;
  num limit;
  dynamic status;
  String? paymentStatus;
  String? paymentGateway;
  DateTime? expireDate;
  DateTime? createdAt;
  SubscriptionType? userSubscriptionTypeApi;

  History({
    this.id,
    this.userId,
    this.subscriptionId,
    required this.price,
    required this.limit,
    this.status,
    this.paymentStatus,
    this.paymentGateway,
    this.expireDate,
    this.createdAt,
    this.userSubscriptionTypeApi,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userId: json["user_id"],
        subscriptionId: json["subscription_id"],
        price: json["price"].toString().tryToParse,
        limit: json["limit"].toString().tryToParse,
        status: json["status"],
        paymentStatus: json["payment_status"],
        paymentGateway: json["payment_gateway"],
        expireDate: DateTime.tryParse(json["expire_date"].toString()),
        createdAt: DateTime.tryParse(json["created_at"].toString()),
        userSubscriptionTypeApi: json["user_subscription_type_api"] == null
            ? null
            : SubscriptionType.fromJson(json["user_subscription_type_api"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "subscription_id": subscriptionId,
        "price": price,
        "limit": limit,
        "status": status,
        "payment_status": paymentStatus,
        "payment_gateway": paymentGateway,
        "expire_date": expireDate?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "user_subscription_type_api": userSubscriptionTypeApi?.toJson(),
      };
}
