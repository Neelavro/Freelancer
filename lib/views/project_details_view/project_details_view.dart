import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/project_details_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/views/project_details_view/components/project_details_basic_info.dart';
import 'package:xilancer/views/project_details_view/components/project_details_package.dart';

class ProjectDetailsView extends StatelessWidget {
  static const routeName = 'project_details_view';
  const ProjectDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final List routeData =
        (ModalRoute.of(context)?.settings.arguments ?? []) as List;
    final id = routeData.firstOrNull;
    final pdProvider =
        Provider.of<ProjectDetailsService>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.projectDetails),
        ),
        body: CustomFutureWidget(
          function: pdProvider.shouldAutoFetch(id.toString())
              ? pdProvider.fetchProjectDetails(id)
              : null,
          shimmer: const CustomPreloader(),
          child: Consumer<ProjectDetailsService>(builder: (context, pd, child) {
            return pd.projectDetailsModel.projectDetails?.id == null
                ? EmptyWidget(title: LocalKeys.projectNotFound)
                : ListView(
                    children: const [
                      ProjectDetailsBasicInfo(showEdit: true),
                      ProjectDetailsPackages()
                    ],
                  );
          }),
        ));
  }
}
