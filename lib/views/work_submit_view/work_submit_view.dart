import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';

import '../../app_static_values.dart';
import '../../helper/local_keys.g.dart';
import '../../utils/components/custom_button.dart';
import '../../utils/components/field_label.dart';
import '../../utils/components/warning_widget.dart';
import '../../view_models/my_order_details_view_model/my_order_details_view_model.dart';
import '../my_order_details_view/components/job_attachment_select.dart';

class WorkSubmitView extends StatelessWidget {
  final milestoneId;
  const WorkSubmitView({
    super.key,
    required this.milestoneId,
  });

  @override
  Widget build(BuildContext context) {
    final odm = MyOrderDetailsViewModel.instance;
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: context.dProvider.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WarningWidget(text: LocalKeys.orderSubmitWarning),
              12.toHeight,
              AttachmentSelect(
                selectedAttachment: odm.selectedFile,
                maxMBSize: 100,
                isRequired: true,
                allowedExtensions: supportedWorkFiles,
              ),
              FieldLabel(
                label: LocalKeys.description,
                isRequired: true,
              ),
              FlutterSummernote(
                hint: odm.workSubmitDescController.text.isEmpty
                    ? LocalKeys.enterDescription
                    : null,
                hasAttachment: false,
                value: odm.workSubmitDescController.text,
                height: 360,
                showBottomToolbar: false,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: context.dProvider.black7,
                    width: 1,
                  ),
                ),
                key: odm.keyEditor,
              ),
              20.toHeight,
              ValueListenableBuilder(
                valueListenable: odm.fileSubmitLoading,
                builder: (context, loading, child) => CustomButton(
                    onPressed: () {
                      odm.trySubmittingWork(context, milestoneId: milestoneId);
                    },
                    btText: LocalKeys.submit,
                    isLoading: loading),
              ),
              20.toHeight,
            ],
          ),
        ),
      ),
    );
  }
}
