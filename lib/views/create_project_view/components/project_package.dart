import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/create_project_service.dart';
import 'package:xilancer/view_models/create_project_view_model/create_project_view_model.dart';
import 'package:xilancer/views/create_project_view/components/package_delivery_time.dart';
import 'package:xilancer/views/create_project_view/components/package_extra_field.dart';
import 'package:xilancer/views/create_project_view/components/package_name.dart';
import 'package:xilancer/views/create_project_view/components/package_price.dart';
import 'package:xilancer/views/create_project_view/components/package_revisions.dart';
import 'package:xilancer/views/create_project_view/components/packages_list.dart';
import 'package:xilancer/views/create_project_view/components/packages_switch.dart';

class ProjectPackages extends StatelessWidget {
  const ProjectPackages({super.key});

  @override
  Widget build(BuildContext context) {
    final cpv = CreateProjectViewModel.instance;
    int index = 0;
    return ValueListenableBuilder(
      valueListenable: cpv.currentPackageIndex,
      builder: (context, cIndex, child) {
        return ValueListenableBuilder(
            valueListenable: cpv.packages,
            builder: (context, packages, child) {
              final package = packages[cIndex.round()];
              debugPrint("package revision is ${package.revision}".toString());
              debugPrint(
                  "package delivery is ${package.deliveryTime}".toString());
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.toHeight,
                    PackagesSwitch(cpv: cpv),
                    PackagesList(cpv: cpv),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PackageName(
                          package: package,
                        ),
                        PackageRevisions(
                          cpv: cpv,
                          package: package,
                          index: cIndex,
                        ),
                        PackageDeliveryTime(
                          cpv: cpv,
                          package: package,
                          index: cIndex,
                        ),
                        ValueListenableBuilder(
                          valueListenable: cpv.extraFields,
                          builder: (context, value, child) {
                            return Column(
                              children: cpv.extraFields.value
                                  .map((e) => PackageExtraField(
                                        cpv: cpv,
                                        index: index,
                                        extraField: e,
                                      ))
                                  .toList(),
                            );
                          },
                        ),
                        Divider(
                          color: context.dProvider.black8,
                          height: 1,
                        ),
                        20.toHeight,
                        PackagePrice(
                          package: package,
                          cpv: cpv,
                        ),
                        // 20.toHeight,
                      ],
                    )
                    // Divider(
                    //   color: context.dProvider.black8,
                    //   thickness: 2,
                    //   height: 24,
                    // ),
                  ],
                ),
              );
            });
      },
    );
  }
}
