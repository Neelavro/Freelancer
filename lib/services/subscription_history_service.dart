import 'package:flutter/material.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../data/network/network_api_services.dart';
import '../models/subscription_history_model.dart';

class SubscriptionHistoryService with ChangeNotifier {
  SubscriptionHistoryModel? _subscriptionHistoryModel;

  SubscriptionHistoryModel get subscriptionHistoryModel =>
      _subscriptionHistoryModel ?? SubscriptionHistoryModel();
  String token = "";
  String? nextPage;
  bool isLoading = false;
  bool nextPageLoading = false;
  bool nexLoadingFailed = false;

  bool get shouldAutoFetch =>
      _subscriptionHistoryModel == null || token.isInvalid;

  fetchSubscriptionHistory() async {
    var url = AppUrls.subscriptionHistoryUrl;
    token = getToken;

    final responseData = await NetworkApiServices().getApi(
        url, LocalKeys.subscriptionHistory,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      _subscriptionHistoryModel =
          SubscriptionHistoryModel.fromJson(responseData);
      nextPage = subscriptionHistoryModel.allSubscriptions?.nextPageUrl;
      debugPrint((_subscriptionHistoryModel?.allSubscriptions?.history?.length)
          .toString());
      notifyListeners();
      return true;
    }
  }

  fetchNextPage() async {
    token = getToken;
    nextPageLoading = true;
    notifyListeners();

    final responseData = await NetworkApiServices().getApi(
        nextPage!, LocalKeys.subscriptionHistory,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      final tempData = SubscriptionHistoryModel.fromJson(responseData);
      tempData.allSubscriptions?.history?.forEach((element) {
        _subscriptionHistoryModel?.allSubscriptions?.history?.add(element);
      });
      nextPage = tempData.allSubscriptions?.nextPageUrl;
    } else {
      nexLoadingFailed = true;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        nexLoadingFailed = false;
        notifyListeners();
      });
    }

    nextPageLoading = false;
    notifyListeners();
  }
}
