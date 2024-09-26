import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/view_models/send_offer_view_model/send_offer_view_model.dart';

import '../data/network/network_api_services.dart';

class SendOfferService with ChangeNotifier {
  trySendingOffer({clientId}) async {
    var url = AppUrls.sendCustomOfferUrl;
    final som = SendOfferViewModel.instance;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'client_id': clientId.toString(),
      'offer_price': som.priceController.text,
    });

    if (!som.milestone.value) {
      request.fields.addAll({
        'pay_at_once': 'pay-at-once',
        'offer_description': som.descriptionController.text,
        'offer_deadline': som.selectedDDate.value ?? "",
        'offer_revision': som.revisionController.text,
      });
    } else {
      final milestones = som.milestones.value.map((element) {
        return {
          "milestone_title": element.name,
          "milestone_description": element.description,
          "milestone_price": element.price.toString(),
          "milestone_revision": element.revision.toInt().toString(),
          "milestone_deadline": element.dTime
        };
      }).toList();
      request.fields.addAll({
        'pay_by_milestone': 'pay-by-milestone',
        'milestones': jsonEncode(milestones)
      });
    }

    request.headers.addAll(acceptJsonAuthHeader);

    final responseData = await NetworkApiServices().postWithFileApi(
      request,
      url,
    );

    if (responseData != null) {
      return true;
    }
  }
}
