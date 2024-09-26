import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/my_projects_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/views/my_projects/components/project_list.dart';
import 'package:xilancer/views/my_projects/components/project_list_skeleton.dart';

class MyProjects extends StatelessWidget {
  static const routeName = "my_projects";
  const MyProjects({super.key});

  @override
  Widget build(BuildContext context) {
    final mpProvider = Provider.of<MyProjectsService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.myProjects),
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await mpProvider.fetchMyProjects();
        },
        child: CustomFutureWidget(
          function:
              mpProvider.shouldAutoFetch ? mpProvider.fetchMyProjects() : null,
          shimmer: const ProjectListSkeleton(),
          child: const ProjectList(),
        ),
      ),
    );
  }
}
