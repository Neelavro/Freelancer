import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/view_models/create_project_view_model/create_project_view_model.dart';

import '../../../helper/local_keys.g.dart';

class PackagesSwitch extends StatelessWidget {
  const PackagesSwitch({
    super.key,
    required this.cpv,
    this.extraField,
  });

  final CreateProjectViewModel cpv;
  final extraField;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 2),
            bottom: BorderSide(color: context.dProvider.black8, width: 1),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalKeys.projectPackagesAndCharge,
            style: context.titleMedium?.bold6,
          ),
          8.toHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocalKeys.multiplePackages,
                style: context.titleSmall,
              ),
              4.toWidth,
              ValueListenableBuilder(
                  valueListenable: cpv.multiplePackages,
                  builder: (context, value, child) {
                    return SizedBox(
                        height: 36,
                        child: FittedBox(
                          child: Switch(
                              value: value,
                              onChanged: (newValue) {
                                cpv.multiplePackages.value = !value;
                              }),
                        ));
                  })
            ],
          ),
        ],
      ).hp20,
    );
  }
}
