import 'package:flutter/material.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../data/network/network_api_services.dart';
import '../models/my_projects_model.dart';

class MyProjectsService with ChangeNotifier {
  MyProjectsModel? _myProjectsModel;

  bool nextPageLoading = false;
  bool nexLoadingFailed = false;

  MyProjectsModel get mProjectsModel => _myProjectsModel ?? MyProjectsModel();

  String token = '';
  String? nextPage;

  bool get shouldAutoFetch => _myProjectsModel == null || token.isInvalid;

  fetchMyProjects() async {
    var url = AppUrls.myProjectsUrl;
    token = getToken;

    final responseData = await NetworkApiServices().getApi(
      url,
      LocalKeys.myProjects,
      headers: acceptJsonAuthHeader,
    );

    if (responseData != null) {
      _myProjectsModel = MyProjectsModel.fromJson(responseData);
      nextPage = mProjectsModel.projectLists?.nextPageUrl;
      nextPageLoading = false;
      notifyListeners();
      return true;
    }
  }

  fetchNextPage() async {
    if (_myProjectsModel?.projectLists?.nextPageUrl == null) {
      return;
    }
    nextPageLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices().getApi(
      _myProjectsModel?.projectLists?.nextPageUrl,
      LocalKeys.next,
      headers: acceptJsonAuthHeader,
    );

    if (responseData != null) {
      final tempData = MyProjectsModel.fromJson(responseData);
      tempData.projectLists?.data?.forEach((element) {
        _myProjectsModel?.projectLists?.data?.add(element);
      });
      nextPage = tempData.projectLists?.nextPageUrl;
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

  void removeProject(id) {
    try {
      _myProjectsModel?.projectLists?.data
          ?.removeWhere((element) => element.id.toString() == id.toString());
      notifyListeners();
    } catch (e) {}
  }

  num projectAVGRating(id) {
    try {
      return _myProjectsModel?.projectLists?.data
              ?.firstWhere((element) => element.id.toString() == id.toString())
              .ratingsAvgRating ??
          0;
    } catch (e) {
      return 0;
    }
  }

  num projectRatingCount(id) {
    try {
      return _myProjectsModel?.projectLists?.data
              ?.firstWhere((element) => element.id.toString() == id.toString())
              .ratingsCount ??
          0;
    } catch (e) {
      return 0;
    }
  }

  num projectCompleteOrder(id) {
    try {
      return _myProjectsModel?.projectLists?.data
              ?.firstWhere((element) => element.id.toString() == id.toString())
              .completeOrdersCount ??
          0;
    } catch (e) {
      return 0;
    }
  }
}
