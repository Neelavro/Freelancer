import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/services/project_details_service.dart';
import 'package:xilancer/view_models/create_project_view_model/create_project_view_model.dart';
import 'package:xilancer/view_models/project_details_view_model/project_details_view_model.dart';
import 'package:xilancer/views/create_project_view/create_project_view.dart';

import '../../../helper/local_keys.g.dart';

class ProjectDetailsButtons extends StatelessWidget {
  const ProjectDetailsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final pdm = ProjectDetailsViewModel.instance;
    return Row(
      children: [
        Expanded(
          flex: 16,
          child: OutlinedButton(
            onPressed: () {
              pdm.tryDeleteProject(context);
            },
            child: Text(LocalKeys.deleteProject),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 16,
          child: ElevatedButton(
            onPressed: () async {
              final pdProvider =
                  Provider.of<ProjectDetailsService>(context, listen: false);
              if (pdProvider.projectDetailsModel.projectDetails != null) {
                CreateProjectViewModel.dispose;
                CreateProjectViewModel.instance.initProject(
                    pdProvider.projectDetailsModel.projectDetails!);
                context.toPage(const CreateProjectView());
              }
            },
            child: Text(LocalKeys.editProject),
          ),
        ),
      ],
    );
  }
}
