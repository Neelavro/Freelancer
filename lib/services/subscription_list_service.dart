import 'package:flutter/material.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/models/subscription_type_model.dart';

import '../data/network/network_api_services.dart';
import '../models/subscription_list_model.dart';
import '../view_models/subscription_store_view_model/subscription_store_view_model.dart';

class SubscriptionListService with ChangeNotifier {
  SubscriptionTypesModel? _subscriptionTypesModel;
  SubscriptionTypesModel get subscriptionTypesModel =>
      _subscriptionTypesModel ?? SubscriptionTypesModel();
  SubscriptionListModel? _subscriptionListModel;
  SubscriptionListModel get subscriptionListModel =>
      _subscriptionListModel ?? SubscriptionListModel();
  String token = "";
  String? nextPage;
  bool isLoading = false;
  bool nextPageLoading = false;
  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => _subscriptionListModel == null || token.isInvalid;

  fetchSubscriptionTypes() async {
    var url = AppUrls.subscriptionTypeListUrl;

    final responseData = await NetworkApiServices()
        .getApi(url, null, headers: acceptJsonAuthHeader);

    if (responseData != null) {
      _subscriptionTypesModel = SubscriptionTypesModel.fromJson(responseData);
      _subscriptionTypesModel?.subscriptionTypes
          ?.add(SubscriptionType(type: LocalKeys.all, validity: 0, id: "all"));
      return true;
    }
  }

  fetchSubscriptionList({bool refresh = false, filter = false}) async {
    var url = AppUrls.subscriptionListUrl;
    token = getToken;
    final ssm = SubscriptionStoreViewModel.instance;

    final data = {
      "type_id": ssm.subscriptionTypeNotifier.value?.id?.toString() ?? "all",
    };
    if (filter) {
      isLoading = true;
      notifyListeners();
    }

    final responseData = await NetworkApiServices().postApi(
        data, url, LocalKeys.subscription,
        headers: acceptJsonAuthHeader);

    try {
      if (responseData != null) {
        _subscriptionListModel = SubscriptionListModel.fromJson(responseData);
        nextPage = subscriptionListModel.subscriptionsData?.nextPageUrl;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    notifyListeners();
  }

  fetchNextPage() async {
    token = getToken;
    final ssm = SubscriptionStoreViewModel.instance;

    final data = {
      "type_id": ssm.subscriptionTypeNotifier.value?.id?.toString() ?? "all",
    };
    nextPageLoading = true;
    notifyListeners();

    final responseData = await NetworkApiServices().postApi(
        data, nextPage!, LocalKeys.subscription,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      final tempData = SubscriptionListModel.fromJson(responseData);
      tempData.subscriptionsData?.subscriptions?.forEach((element) {
        _subscriptionListModel?.subscriptionsData?.subscriptions?.add(element);
      });
      nextPage = tempData.subscriptionsData?.nextPageUrl;
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
