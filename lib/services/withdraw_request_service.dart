import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/view_models/withdraw_requests_view_model/withdraw_requests_view_model.dart';

import '../data/network/network_api_services.dart';
import '../models/withdraw_settings_model.dart';

class WithdrawRequestService with ChangeNotifier {
  WithdrawSettingsModel? _withdrawSettings;
  WithdrawSettingsModel get withdrawSettingsModel =>
      _withdrawSettings ??
      WithdrawSettingsModel(
        userCurrentBalance: UserCurrentBalance(balance: 0),
        withdrawGateways: [],
      );

  String token = "";

  bool get shouldAutoFetch => _withdrawSettings == null || token.isInvalid;

  fetchWithdrawSettings() async {
    var url = AppUrls.withdrawSettingsUrl;
    token = getToken;

    final responseData = await NetworkApiServices().getApi(
      url,
      LocalKeys.withdrawMethod,
      headers: acceptJsonAuthHeader,
    );

    if (responseData != null) {
      _withdrawSettings = WithdrawSettingsModel.fromJson(responseData);
      return true;
    }
  }

  tryWithdrawRequest() async {
    var url = AppUrls.withdrawRequestUrl;
    try {
      final wrm = WithdrawRequestsViewModel.instance;
      final gatewayFields = wrm.selectedGateway.value!.field;
      final fieldValues = {};
      for (var i = 0; i < gatewayFields.length; i++) {
        fieldValues.putIfAbsent(
            gatewayFields[i].toLowerCase().replaceAll(" ", "_"),
            () => wrm.inputFieldControllers[i].text);
      }
      var data = {
        'gateway_id': wrm.selectedGateway.value!.id.toString(),
        'gateway_field': jsonEncode(fieldValues),
        'amount': wrm.amountController.text,
        'status': '1',
      };

      final responseData = await NetworkApiServices().postApi(
          data, url, LocalKeys.withdraw,
          headers: acceptJsonAuthHeader);

      if (responseData != null) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
