import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/services/my_projects_service.dart';

import '../../helper/local_keys.g.dart';
import '../../services/project_details_service.dart';
import '../../utils/components/alerts.dart';
import '../../views/create_project_view/components/packages_model.dart';

class ProjectDetailsViewModel {
  ValueNotifier<int> packageIndex = ValueNotifier(0);
  List<PackageForView> packages = [];

  ProjectDetailsViewModel._init();
  static ProjectDetailsViewModel? _instance;
  static ProjectDetailsViewModel get instance {
    _instance ??= ProjectDetailsViewModel._init();
    return _instance!;
  }

  ProjectDetailsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  initPackage(context, projectId) {
    packages.clear();
    debugPrint("project id is $projectId".toString());
    final pdProvider =
        Provider.of<ProjectDetailsService>(context, listen: false);

    try {
      for (var element in pdProvider.projectPackages) {
        packages.add(element);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint("package length is ${packages.length}".toString());
  }

  tryDeleteProject(BuildContext context) async {
    final pdProvider =
        Provider.of<ProjectDetailsService>(context, listen: false);
    Alerts().confirmationAlert(
      context: context,
      title: LocalKeys.areYouSure,
      onConfirm: () async {
        await pdProvider.tryDeleteProject().then((v) {
          if (v == true) {
            Provider.of<MyProjectsService>(context, listen: false)
                .removeProject(
                    pdProvider.projectDetailsModel.projectDetails?.id);
            context.popFalse;
            context.popFalse;
          }
        });
      },
      buttonText: LocalKeys.delete,
    );
  }

  tryProjectStatusChange(BuildContext context) async {
    final pdProvider =
        Provider.of<ProjectDetailsService>(context, listen: false);
    Alerts().confirmationAlert(
      context: context,
      title: LocalKeys.areYouSure,
      onConfirm: () async {
        await pdProvider.tryStatusChange().then((v) {
          if (v == true) {
            context.popFalse;
          }
        });
      },
      buttonText: LocalKeys.confirm,
      buttonColor: dProvider.primaryColor,
    );
  }
}
