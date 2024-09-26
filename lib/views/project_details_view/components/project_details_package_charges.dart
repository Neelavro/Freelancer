import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/profile_info_service.dart';

class ProjectDetailsPackageChanges extends StatelessWidget {
  final String regularCharge;
  final num discountCharge;
  final projectId;
  const ProjectDetailsPackageChanges({
    super.key,
    required this.regularCharge,
    required this.discountCharge,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 1),
            bottom: BorderSide(color: context.dProvider.black8, width: 1),
          )),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                child:
                    Text(LocalKeys.charges, style: context.titleSmall?.bold6),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Consumer<ProfileInfoService>(
                    builder: (context, cpProvider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (discountCharge > 0
                                ? discountCharge.toStringAsFixed(2)
                                : regularCharge)
                            .cur
                            .toString(),
                        style: context.titleMedium
                            ?.copyWith(color: context.dProvider.primaryColor)
                            .bold6,
                      ),
                      if (discountCharge > 0) ...[
                        8.toWidth,
                        Text(
                          (regularCharge).cur.toString(),
                          style: context.titleSmall
                              ?.copyWith(
                                  color: context.dProvider.black5,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: context.dProvider.black5)
                              .bold6,
                        ),
                      ]
                    ],
                  );
                }),
              ),
            ],
          ),
          12.toHeight,
        ],
      ),
    );
  }
}
