import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/my_projects_service.dart';

class MyProjectsViewModel {
  ScrollController scrollController = ScrollController();

  MyProjectsViewModel._init();
  static MyProjectsViewModel? _instance;
  static MyProjectsViewModel get instance {
    _instance ??= MyProjectsViewModel._init();
    return _instance!;
  }

  MyProjectsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final mpProvider = Provider.of<MyProjectsService>(context, listen: false);
      final nextPage = mpProvider.nextPage;
      final nextPageLoading = mpProvider.nextPageLoading;

      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          mpProvider.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }
}
