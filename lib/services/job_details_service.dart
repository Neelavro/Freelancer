import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xilancer/helper/extension/string_extension.dart';

import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../helper/constant_helper.dart';
import '../helper/local_keys.g.dart';
import '../models/job_details_model.dart';

class JobDetailsService with ChangeNotifier {
  JobDetailsModel? _jobDetailsModel;
  JobDetailsModel get jobDetailsModel => _jobDetailsModel ?? JobDetailsModel();

  String token = "";

  bool shouldAutoFetch(id) =>
      _jobDetailsModel?.jobDetails?.id.toString() != id || token.isInvalid;

  fetchOrderDetails({required jobId, refresh = false}) async {
    if (!refresh) {
      _jobDetailsModel = null;
    }
    token = getToken;
    final url = "${AppUrls.jobDetailsUrl}/${jobId.toString()}";
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.jobDetails, headers: acceptJsonAuthHeader);

    if (responseData != null) {
      _jobDetailsModel = JobDetailsModel.fromJson(responseData);
    } else {}
    notifyListeners();
  }

  trySendingOffer(
    String clientId,
    String jobId,
    String amount,
    String duration,
    String revision,
    String coverLater,
    File? file,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $getToken'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.sendJobOffer));
    request.fields.addAll({
      'client_id': clientId,
      'job_id': jobId,
      'amount': amount,
      'duration': duration,
      'revision': revision,
      'cover_letter': coverLater,
    });
    debugPrint(revision + coverLater.toString());
    if (file != null) {
      LocalKeys.uploadingFileMightTakeSomeTime.showToast();
      request.files
          .add(await http.MultipartFile.fromPath('attachment', file.path));
    }
    request.headers.addAll(headers);
    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.sendOffer);
    if (responseData != null) {
      responseData["msg"] != null
          ? responseData["msg"].toString().capitalize.showToast()
          : LocalKeys.offerSentSuccessfully.showToast();
      return true;
    } else {}
  }

  void setAlreadyApplied() {
    _jobDetailsModel?.alreadyApplied = true;
    notifyListeners();
  }
}
