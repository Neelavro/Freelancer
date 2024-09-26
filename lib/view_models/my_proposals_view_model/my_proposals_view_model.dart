import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/my_proposals_service.dart';

class MyProposalsViewModel {
  ScrollController scrollController = ScrollController();

  MyProposalsViewModel._init();
  static MyProposalsViewModel? _instance;
  static MyProposalsViewModel get instance {
    _instance ??= MyProposalsViewModel._init();
    return _instance!;
  }

  MyProposalsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final mp = Provider.of<MyProposalsService>(context, listen: false);
      final nextPage = mp.nextPage;
      final nextPageLoading = mp.nextPageLoading;

      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          mp.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }
}
