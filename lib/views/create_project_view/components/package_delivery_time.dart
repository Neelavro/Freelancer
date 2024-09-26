import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/app_static_values.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_dropdown.dart';

import '../../../models/packages_model.dart';
import '../../../view_models/create_project_view_model/create_project_view_model.dart';

class PackageDeliveryTime extends StatelessWidget {
  final Package package;
  final int index;
  const PackageDeliveryTime({
    super.key,
    required this.cpv,
    required this.package,
    required this.index,
  });
  final CreateProjectViewModel cpv;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      // padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 1),
            bottom: BorderSide(color: context.dProvider.black8, width: 1),
          )),
      child: Row(
        children: [
          Container(
            width: context.width / 2.2,
            padding: EdgeInsets.only(
              right: dProvider.textDirectionRight ? 20 : 0,
              left: dProvider.textDirectionRight ? 0 : 20,
            ),
            child:
                Text(LocalKeys.deliveryTime, style: context.titleSmall?.bold6),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: VerticalDivider(
              thickness: 2,
              color: context.dProvider.black8,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: context.width / 2.2,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: CustomDropdown(
                  LocalKeys.selectDeliveryTime,
                  jobLengths,
                  (value) {
                    debugPrint(value.toString());
                    package.deliveryTime = value!;
                    cpv.packages.notifyListeners();
                  },
                  value: package.deliveryTime.toString(),
                ),
              ),
              Expanded(child: 0.toHeight),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      cpv.addField(index: index);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          color: context.dProvider.primary05.withOpacity(.10)),
                      child: Icon(
                        Icons.add_rounded,
                        color: context.dProvider.primaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
