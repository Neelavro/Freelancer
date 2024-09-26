import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/services/create_project_service.dart';
import 'package:xilancer/view_models/create_project_view_model/create_project_view_model.dart';
import 'package:xilancer/views/create_project_view/components/create_project_buttons.dart';

import '../../../helper/local_keys.g.dart';
import '../../../utils/components/field_with_label.dart';
import '../../../models/packages_model.dart';

class PackagePrice extends StatelessWidget {
  final Package package;
  final CreateProjectViewModel cpv;
  const PackagePrice({
    super.key,
    required this.package,
    required this.cpv,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateProjectService>(
        builder: (context, cpProvider, child) {
      final cpv = CreateProjectViewModel.instance;
      cpv.regularPriceController.text = package.regularPrice.toString();
      cpv.discountPriceController.text = package.discountPrice.toString();
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
          // border: Border(
          //   top: BorderSide(color: context.dProvider.black8, width: 1),
          //   bottom: BorderSide(color: context.dProvider.black8, width: 1),
          // ),
        ),
        child: Column(
          children: [
            FieldWithLabel(
              label: LocalKeys.regularPrice,
              hintText: LocalKeys.regularPrice,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              controller: cpv.regularPriceController,
              onFieldSubmitted: (newValue) {
                final price = newValue.toString().tryToParse;
                if (price <= (package.discountPrice ?? 0)) {
                  LocalKeys.invalidDRegularPrice.showToast();
                  cpv.regularPriceController.text =
                      package.regularPrice.toString();
                  return;
                }
                package.regularPrice = price;
                cpv.packages.notifyListeners();
              },
            ),
            FieldWithLabel(
              label: LocalKeys.discountPrice,
              hintText: LocalKeys.regularPrice,
              keyboardType: TextInputType.number,
              controller: cpv.discountPriceController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (newValue) {
                final price = newValue.toString().tryToParse;
                if (price >= package.regularPrice) {
                  LocalKeys.invalidDiscountPrice.showToast();
                  cpv.discountPriceController.text =
                      package.discountPrice.toString();
                  return;
                }
                package.discountPrice = price;
                cpv.packages.notifyListeners();
              },
            ),
            20.toHeight,
            const CreateProjectButtons(lastPage: true),
          ],
        ),
      );
    });
  }
}
