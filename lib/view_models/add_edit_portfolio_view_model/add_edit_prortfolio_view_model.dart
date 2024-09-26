import 'package:flutter/material.dart';

class AddEditPortfolioViewModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  AddEditPortfolioViewModel._init();
  static AddEditPortfolioViewModel? _instance;
  static AddEditPortfolioViewModel get instance {
    _instance ??= AddEditPortfolioViewModel._init();
    return _instance!;
  }

  AddEditPortfolioViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }
}
