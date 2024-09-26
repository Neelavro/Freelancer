import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/create_project_service.dart';
import 'package:xilancer/view_models/create_project_view_model/create_project_view_model.dart';

class PackagesList extends StatelessWidget {
  const PackagesList({
    super.key,
    required this.cpv,
  });

  final CreateProjectViewModel cpv;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      height: 56,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 1),
            bottom: BorderSide(color: context.dProvider.black8, width: 1),
          )),
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            return ValueListenableBuilder(
              valueListenable: cpv.multiplePackages,
              builder: (context, value, child) => !value && index > 0
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        cpv.setCurrentIndex(index);
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: cpv.currentPackageIndex.value == index
                              ? context.dProvider.primaryColor
                              : context.dProvider.black9,
                        ),
                        child: Text(
                          cpv.packages.value[index].name,
                          style: context.titleSmall?.copyWith(
                              color: cpv.currentPackageIndex.value == index
                                  ? context.dProvider.whiteColor
                                  : context.dProvider.black5),
                        ),
                      ),
                    ),
            );
          },
          separatorBuilder: (context, index) => 12.toWidth,
          itemCount: cpv.packages.value.length),
    );
  }
}
