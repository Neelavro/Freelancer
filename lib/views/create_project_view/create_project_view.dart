import 'package:flutter/material.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/view_models/create_project_view_model/create_project_view_model.dart';
import 'package:xilancer/views/create_project_view/components/create_project_timeline.dart';
import 'package:xilancer/views/create_project_view/components/project_gallery.dart';
import 'package:xilancer/views/create_project_view/components/project_package.dart';

import 'components/project_intro.dart';

class CreateProjectView extends StatelessWidget {
  static const routeName = 'create_project_view';
  const CreateProjectView({super.key});
  @override
  Widget build(BuildContext context) {
    final cpv = CreateProjectViewModel.instance;
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.createProject),
        ),
        body: Column(
          children: [
            CreateProjectTimeline(cpv: cpv),
            Expanded(
              child: Container(
                child: ValueListenableBuilder<double>(
                  valueListenable: cpv.currentIndex,
                  builder: (context, value, child) => PageView(
                    controller: cpv.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ProjectIntro(cpv: cpv),
                      const ProjectGallery(),
                      const ProjectPackages()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

final map = [
  {
    "name": "basic",
    "revision": 5,
    "delivery_time": 5,
    "regular_price": 250.00,
    "discount_price": 250.00,
    "extra_fields": [
      {"name": "dfas dgfs", "type": "check", "checked": false, "quantity": 5},
      {"name": "asf sdfghsfh", "type": "check", "checked": true, "quantity": 0},
      {
        "name": ";klfs jksa",
        "type": "quantity",
        "checked": false,
        "quantity": 11
      },
      {
        "name": "hjkfasyf j hshdffkh",
        "type": "quantity",
        "checked": false,
        "quantity": 16,
      },
      {"name": "dfas dgfs", "type": "check", "checked": false, "quantity": 5},
      {"name": "asf sdfghsfh", "type": "check", "checked": true, "quantity": 0},
      {
        "name": ";klfs jksa",
        "type": "quantity",
        "checked": false,
        "quantity": 11
      },
      {
        "name": "hjkfasyf j hshdffkh",
        "type": "quantity",
        "checked": false,
        "quantity": 16
      }
    ]
  }
];
