import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../helper/local_keys.g.dart';
import '../models/order_details_model.dart';
import '../view_models/my_order_details_view_model/my_order_details_view_model.dart';

class OrderDetailsService with ChangeNotifier {
  OrderDetailsModel? _orderDetailsModel;
  OrderDetailsModel get orderDetailsModel =>
      _orderDetailsModel ?? OrderDetailsModel();

  String token = "";
  String id = "";

  bool shouldAutoFetch(id) => id.toString() != this.id || token.isInvalid;

  fetchOrderDetails({required orderId}) async {
    _orderDetailsModel = null;
    token = getToken;
    id = orderId.toString();
    final url = "${AppUrls.orderDetailsUrl}/${orderId.toString()}";
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.orderDetails, headers: commonAuthHeader);

    if (responseData != null) {
      _orderDetailsModel = OrderDetailsModel.fromJson(responseData);

      debugPrint("order details is $_orderDetailsModel".toString());
    } else {}
    notifyListeners();
  }

  tryAcceptOrder({required orderId}) async {
    var url = AppUrls.orderAcceptUrl;
    var data = {
      "order_id": orderId.toString(),
    };

    final responseData = await NetworkApiServices().postApi(
        data, url, LocalKeys.cancelOrder,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      try {
        _orderDetailsModel?.orderDetails?.status = "1";
        _orderDetailsModel?.orderDetails?.orderMileStones?.firstOrNull?.status =
            "1";
      } catch (e) {}
      notifyListeners();
      return true;
    }
  }

  tryCancelOrder({required orderId, required String action}) async {
    var url = AppUrls.orderCancelUrl;
    var data = {
      "order_id": orderId.toString(),
      "cancel_or_decline_order": action,
    };

    final responseData = await NetworkApiServices().postApi(
        data, url, LocalKeys.cancelOrder,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      _orderDetailsModel?.orderDetails?.status = action == "cancel" ? "4" : "5";
      notifyListeners();
      return true;
    }
  }

  trySubmitOrder(milestoneId,
      {required File? file, required String description}) async {
    final odm = MyOrderDetailsViewModel.instance;
    var url = AppUrls.submitWorkUrl;

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'order_id': id,
      'description': description,
      'order_milestone_id': milestoneId?.toString() ?? "",
    });
    debugPrint(url.toString());
    debugPrint(odm.selectedFile.value.toString());
    if (file == null) {
      LocalKeys.selectFile.showToast();
      return;
    }
    request.files
        .add(await http.MultipartFile.fromPath('attachment', file.path));
    request.headers.addAll(acceptJsonAuthHeader);

    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.submitWork);

    if (responseData != null) {
      LocalKeys.orderSubmittedSuccessfully.showToast();
      return true;
    }
  }
}
