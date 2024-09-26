import 'package:flutter/material.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/view_models/create_project_view_model/create_project_view_model.dart';

import '../../../helper/local_keys.g.dart';

class CreateProjectButtons extends StatelessWidget {
  final lastPage;
  const CreateProjectButtons({super.key, this.lastPage = false});

  @override
  Widget build(BuildContext context) {
    final cpv = CreateProjectViewModel.instance;
    return Row(
      children: [
        Expanded(
          flex: 16,
          child: OutlinedButton(
            onPressed: () {
              final cpv = CreateProjectViewModel.instance;
              cpv.goBack();
            },
            child: Text(LocalKeys.back),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 16,
          child: ValueListenableBuilder(
            valueListenable: cpv.isLoading,
            builder: (context, loading, child) {
              return CustomButton(
                onPressed: () async {
                  cpv.nextPage(context);
                },
                btText: lastPage
                    ? (cpv.id != null
                        ? LocalKeys.editProject
                        : LocalKeys.createProject)
                    : LocalKeys.next,
                isLoading: loading,
              );
            },
          ),
        ),
      ],
    );
  }
}
