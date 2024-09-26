import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/view_models/subscription_buy_view_model/subscription_buy_view_model.dart';

import '../customizations.dart';
import '../data/network/network_api_services.dart';
import '../helper/constant_helper.dart';
import 'profile_info_service.dart';

class SubscriptionBuyService with ChangeNotifier {
  dynamic id;
  num price = 0;

  trySubscriptionBuy() async {
    var url = AppUrls.subsBuyUrl;
    final sbm = SubscriptionBuyViewModel.instance;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'subscription_id': sbm.id.toString(),
      'selected_payment_gateway': sbm.selectedGateway.value?.name ?? "wallet",
    });
    if (sbm.selectedAttachment.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'manual_payment_image', sbm.selectedAttachment.value!.path));
    }
    request.headers.addAll(acceptJsonAuthHeader);
    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.buySubscription);

    if (responseData != null) {
      id = responseData["subscription_details"]?["id"];
      price = (responseData["subscription_details"]?["price"])
          .toString()
          .tryToParse;
      return true;
    }
  }

  updateDepositPayment(context) async {
    var url = AppUrls.updateSubsPaymentUrl;

    final pi = Provider.of<ProfileInfoService>(context, listen: false);
    var data = {
      "subscription_id": id.toString(),
      "status": "1",
      "secret_key": (pi.profileInfoModel.data?.email ?? "")
          .toHmac(secret: wPaymentUpdateEncryptionKey),
    };

    final responseData = await NetworkApiServices()
        .postApi(data, url, LocalKeys.payment, headers: acceptJsonAuthHeader);

    if (responseData != null) {
      LocalKeys.paymentSuccessful.showToast();
      return;
    }
  }
}
