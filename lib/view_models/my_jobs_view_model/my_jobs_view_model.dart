import 'package:flutter/material.dart';

class MyJobsViewModel {
  ScrollController scrollController = ScrollController();
  MyJobsViewModel._init();
  static MyJobsViewModel? _instance;
  static MyJobsViewModel get instance {
    _instance ??= MyJobsViewModel._init();
    return _instance!;
  }

  MyJobsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }
}
