import 'package:flutter/material.dart';

import '../../helper/constant_helper.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';
import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../models/withdraw_history_model.dart';

class WithdrawHistoryService with ChangeNotifier {
  WithdrawHistoryModel? _withdrawHistory;
  WithdrawHistoryModel get withdrawHistory =>
      _withdrawHistory ?? WithdrawHistoryModel();
  var token = "";
  bool loading = false;

  var nextPage;

  bool nextPageLoading = false;
  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => _withdrawHistory == null || token.isInvalid;

  fetchWithdrawHistory() async {
    token = getToken;
    final responseData = await NetworkApiServices().getApi(
        AppUrls.withdrawHistoryUrl, LocalKeys.withdrawHistory.capitalize,
        headers: commonAuthHeader);

    try {
      if (responseData != null) {
        _withdrawHistory = WithdrawHistoryModel.fromJson(responseData);
        nextPage = withdrawHistory.histories?.nextPageUrl;
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  fetchNextPage() async {
    token = getToken;
    if (nextPageLoading) return;
    nextPageLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices().getApi(
        nextPage, LocalKeys.withdrawHistory.capitalize,
        headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = WithdrawHistoryModel.fromJson(responseData);
      tempData.histories?.history?.forEach((element) {
        _withdrawHistory?.histories?.history?.add(element);
      });
      nextPage = tempData.histories?.nextPageUrl;
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
