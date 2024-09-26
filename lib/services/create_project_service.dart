import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xilancer/data/network/network_api_services.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/view_models/create_project_view_model/create_project_view_model.dart';

class CreateProjectService with ChangeNotifier {
  tryCreatingProject() async {
    final cpm = CreateProjectViewModel.instance;

    final url = AppUrls.createProjectUrl;
    final request = http.MultipartRequest('POST', Uri.parse(url));
    final basicPackage = cpm.packages.value[0];
    final standardPackage = cpm.packages.value[1];
    final premiumPackage = cpm.packages.value[2];
    request.fields.addAll({
      'project_title': cpm.titleController.text,
      'slug': cpm.slugController.text,
      'category': cpm.selectedCategory.value!.id.toString(),
      'subcategory': jsonEncode(cpm.selectedSubcategories.value
          .map((e) => {"sub_category_id": e.id.toString()})
          .toList()),
      'project_description': cpm.descriptionController.text,
      'basic_revision': basicPackage.revision.toString(),
      'standard_revision': standardPackage.revision.toString(),
      'premium_revision': premiumPackage.revision.toString(),
      'basic_delivery': basicPackage.deliveryTime,
      'standard_delivery': standardPackage.deliveryTime,
      'premium_delivery': premiumPackage.deliveryTime,
      'basic_regular_charge': basicPackage.regularPrice.toString(),
      'basic_discount_charge': basicPackage.discountPrice.toString(),
      'standard_regular_charge': standardPackage.regularPrice.toString(),
      'standard_discount_charge': standardPackage.discountPrice.toString(),
      'premium_regular_charge': premiumPackage.regularPrice.toString(),
      'premium_discount_charge': premiumPackage.discountPrice.toString(),
      'checkbox_or_numeric_title':
          jsonEncode(cpm.extraFields.value.map((e) => e.toJson()).toList()),
      'offer_packages_available_or_not': cpm.multiplePackages.value ? "1" : "0",
    });
    request.headers.addAll(acceptJsonAuthHeader);
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      cpm.projectImage.value!.path,
    ));

    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.createProject);
    if (responseData != null) {
      return true;
    }
  }

  tryEditingProject() async {
    final cpm = CreateProjectViewModel.instance;

    final url = AppUrls.editProjectUrl;
    final request = http.MultipartRequest('POST', Uri.parse(url));
    final basicPackage = cpm.packages.value[0];
    final standardPackage = cpm.packages.value[1];
    final premiumPackage = cpm.packages.value[2];
    if (AppUrls.profileInfoUpdate.toLowerCase().contains("xilancer.xgenious")) {
      await Future.delayed(const Duration(seconds: 2));
      "This feature is turned off for demo app".showToast();
      return;
    }
    request.fields.addAll({
      "project_id": cpm.id.toString(),
      'project_title': cpm.titleController.text,
      'slug': cpm.slugController.text,
      'category': cpm.selectedCategory.value!.id.toString(),
      'subcategory': jsonEncode(cpm.selectedSubcategories.value
          .map((e) => {"sub_category_id": e.id.toString()})
          .toList()),
      'project_description': cpm.descriptionController.text,
      'basic_revision': basicPackage.revision.toString(),
      'standard_revision': standardPackage.revision.toString(),
      'premium_revision': premiumPackage.revision.toString(),
      'basic_delivery': basicPackage.deliveryTime,
      'standard_delivery': standardPackage.deliveryTime,
      'premium_delivery': premiumPackage.deliveryTime,
      'basic_regular_charge': basicPackage.regularPrice.toString(),
      'basic_discount_charge': basicPackage.discountPrice.toString(),
      'standard_regular_charge': standardPackage.regularPrice.toString(),
      'standard_discount_charge': standardPackage.discountPrice.toString(),
      'premium_regular_charge': premiumPackage.regularPrice.toString(),
      'premium_discount_charge': premiumPackage.discountPrice.toString(),
      'checkbox_or_numeric_title':
          jsonEncode(cpm.extraFields.value.map((e) => e.toJson()).toList()),
      'offer_packages_available_or_not': cpm.multiplePackages.value ? "1" : "0",
    });
    request.headers.addAll(acceptJsonAuthHeader);
    if (cpm.projectImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        cpm.projectImage.value!.path,
      ));
    }

    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.createProject);
    if (responseData != null) {
      return true;
    }
  }
}
