import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/my_projects_service.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/view_models/my_projects_view_model/my_projects_view_model.dart';

import '../../../utils/components/scrolling_preloader.dart';
import 'project_card.dart';

class ProjectList extends StatelessWidget {
  const ProjectList({super.key});

  @override
  Widget build(BuildContext context) {
    final mpm = MyProjectsViewModel.instance;
    return Consumer<MyProjectsService>(builder: (context, mp, child) {
      if (mp.mProjectsModel.projectLists?.data?.isEmpty ?? true) {
        return EmptyWidget(title: LocalKeys.noProjectFound);
      }
      mpm.scrollController.addListener(() {
        mpm.tryToLoadMore(context);
      });
      return ListView.separated(
          controller: mpm.scrollController,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            if (mp.nextPage != null &&
                (mp.mProjectsModel.projectLists!.data!.length + 0) == (index)) {
              return ScrollPreloader(
                loading: mp.nextPageLoading,
              );
            }
            final pItem = mp.mProjectsModel.projectLists!.data![index];
            return ProjectCard(
              project: pItem,
              projectsPath: mp.mProjectsModel.projectImagePath ?? "",
            );
          },
          separatorBuilder: (context, index) => 12.toHeight,
          itemCount: mp.mProjectsModel.projectLists!.data!.length +
              (mp.nextPage != null && !mp.nexLoadingFailed ? 1 : 0));
    });
  }
}
