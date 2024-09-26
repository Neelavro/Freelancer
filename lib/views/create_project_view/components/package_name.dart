import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

import '../../../models/packages_model.dart';
import '../../../view_models/create_project_view_model/create_project_view_model.dart';

class PackageName extends StatelessWidget {
  final Package package;
  const PackageName({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    final cpv = CreateProjectViewModel.instance;
    TextEditingController nameController = TextEditingController();
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 1),
            bottom: BorderSide(color: context.dProvider.black8, width: 1),
          )),
      child: Row(
        children: [
          SizedBox(
            width: context.width / 2.2,
          ),
          VerticalDivider(
            thickness: 2,
            color: context.dProvider.black8,
          ),
          Text(
            package.name,
            style: context.titleMedium?.bold6,
          )
        ],
      ),
    );
  }
}
