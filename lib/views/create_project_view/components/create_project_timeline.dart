import 'package:flutter/material.dart';
import 'package:xilancer/view_models/create_project_view_model/create_project_view_model.dart';
import '../../../helper/local_keys.g.dart';
import '../../../utils/components/empty_spacer_helper.dart';
import '/helper/extension/context_extension.dart';
import 'create_project_title_timeline.dart';

class CreateProjectTimeline extends StatelessWidget {
  const CreateProjectTimeline({
    super.key,
    required this.cpv,
  });

  final CreateProjectViewModel cpv;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: context.dProvider.primary05,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 2),
            bottom: BorderSide(color: context.dProvider.black8, width: 2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CreateProjectTitleTimeline(),
            EmptySpaceHelper.emptyHeight(16),
            ValueListenableBuilder(
              valueListenable: cpv.currentIndex,
              builder: (context, value, child) => Text(
                cpv.timelineDescriptions[value.toInt()],
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.black4),
              ),
            ),
            EmptySpaceHelper.emptyHeight(16),
            ValueListenableBuilder(
              valueListenable: cpv.currentIndex,
              builder: (context, value, child) => cpv.timelineList.length ==
                      (value + 1)
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: context.dProvider.black8),
                      child: FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "${LocalKeys.next}: ",
                              style: context.titleSmall
                                  ?.copyWith(color: context.dProvider.black5),
                            ),
                            Text(
                              cpv.timelineList[value.toInt() + 1],
                              style: context.titleSmall,
                            ),
                          ],
                        ),
                      )),
            ),
          ],
        ));
  }
}
