import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import 'package:xilancer/utils/components/warning_widget.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';
import 'package:xilancer/views/my_order_details_view/components/job_attachment_select.dart';

import '../../../app_static_values.dart';

class SubmitWorkSheet extends StatelessWidget {
  final milestoneId;
  const SubmitWorkSheet({super.key, this.milestoneId});

  @override
  Widget build(BuildContext context) {
    final odm = MyOrderDetailsViewModel.instance;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: context.dProvider.whiteColor,
      ),
      constraints: BoxConstraints(
          maxHeight: context.height / 2 +
              (MediaQuery.of(context).viewInsets.bottom / 2)),
      child: Form(
        key: odm.workSubmitFormKey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 4,
                width: 48,
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.dProvider.black7,
                ),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  FieldWithLabel(
                    label: LocalKeys.description,
                    hintText: LocalKeys.enterDescription,
                    controller: odm.workSubmitDescController,
                    minLines: 4,
                    isRequired: true,
                    validator: (value) =>
                        value!.isEmpty ? LocalKeys.enterSomeDescription : null,
                  ),
                  ValueListenableBuilder(
                    valueListenable: odm.fileSubmitLoading,
                    builder: (context, loading, child) => CustomButton(
                        onPressed: () {
                          odm.trySubmittingWork(context,
                              milestoneId: milestoneId);
                        },
                        btText: LocalKeys.submit,
                        isLoading: loading),
                  ),
                  20.toHeight,
                ],
              ),
            ).hp20),
          ],
        ),
      ),
    );
  }
}
