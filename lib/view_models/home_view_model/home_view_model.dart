import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/job_list_service.dart.dart';

class HomeViewModel {
  ScrollController scrollController = ScrollController();

  HomeViewModel._init();
  static HomeViewModel? _instance;
  static HomeViewModel get instance {
    _instance ??= HomeViewModel._init();
    return _instance!;
  }

  HomeViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final jlProvider = Provider.of<JobListService>(context, listen: false);
      final nextPage = jlProvider.nextPage;
      final nextPageLoading = jlProvider.nextPageLoading;

      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          jlProvider.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }
}
