import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/job_list_service.dart.dart';
import 'package:xilancer/services/message_notification_count_service.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/views/home_view/components/job_card.dart';
import 'package:xilancer/views/home_view/components/jobs_search_field.dart';
import '../../view_models/home_view_model/home_view_model.dart';
import '/utils/components/custom_refresh_indicator.dart';

import '../home_view/components/home_app_bar.dart';
import 'components/job_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final hvm = HomeViewModel.instance;
    Provider.of<MessageNotificationCountService>(context, listen: false)
        .fetchMN();
    return Column(
      children: [
        const HomeAppBar(),
        Expanded(
          child: CustomRefreshIndicator(
            onRefresh: () async {
              await Provider.of<JobListService>(context, listen: false)
                  .fetchJobList(refreshing: true);
            },
            child: Container(
              color: context.dProvider.black9,
              child: Column(
                children: [
                  const JobsSearchField(),
                  JobList(
                    hvm: hvm,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
