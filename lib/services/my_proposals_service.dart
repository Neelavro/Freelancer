import 'package:flutter/material.dart';

import '../../helper/constant_helper.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';
import '../../models/my_proposals_model.dart';
import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';

class MyProposalsService with ChangeNotifier {
  MyProposalsModel? _myProposalsModel;
  MyProposalsModel get myProposalsModel =>
      _myProposalsModel ?? MyProposalsModel();
  List<Proposal>? proposalList;
  var token = "";

  var nextPage;

  bool nextPageLoading = false;

  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => proposalList == null || token.isInvalid;

  fetchOrderList() async {
    token = getToken;
    debugPrint("fetching dashboard info".toString());
    final url = AppUrls.myProposalsUrl;
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.myProposals, headers: commonAuthHeader);

    if (responseData != null) {
      _myProposalsModel = MyProposalsModel.fromJson(responseData);
      proposalList = myProposalsModel.myProposals?.data ?? [];
      nextPage = myProposalsModel.myProposals?.nextPageUrl;
    } else {
      proposalList ??= [];
    }
    notifyListeners();
  }

  fetchNextPage() async {
    token = getToken;
    if (nextPageLoading) return;
    nextPageLoading = true;
    final responseData = await NetworkApiServices()
        .getApi(nextPage, LocalKeys.myProposals, headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = MyProposalsModel.fromJson(responseData);
      tempData.myProposals?.data?.forEach((element) {
        proposalList?.add(element);
      });
      nextPage = tempData.myProposals?.nextPageUrl;
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
