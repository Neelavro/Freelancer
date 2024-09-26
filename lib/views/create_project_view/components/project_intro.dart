import 'package:flutter/material.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:xilancer/customizations.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/category_dropdown.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import 'package:xilancer/views/create_project_view/components/add_subcategory.dart';
import 'package:xilancer/views/create_project_view/components/subcategory_chip.dart';

import '../../../utils/components/field_label.dart';
import '../../../view_models/create_project_view_model/create_project_view_model.dart';
import 'create_project_buttons.dart';

class ProjectIntro extends StatelessWidget {
  final CreateProjectViewModel cpv;
  const ProjectIntro({
    super.key,
    required this.cpv,
  });

  @override
  Widget build(BuildContext context) {
    final cpm = CreateProjectViewModel.instance;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocalKeys.projectIntro,
              style: context.titleMedium?.bold6,
            ).hp20,
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 24,
            ),
            Column(
              children: [
                Form(
                  key: cpm.introFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CategoryDropdown(
                        catNotifier: cpm.selectedCategory,
                        isRequired: true,
                      ),
                      16.toHeight,

                      FieldLabel(
                        label: LocalKeys.subcategory,
                        isRequired: true,
                      ),
                      ValueListenableBuilder(
                        valueListenable: cpm.selectedSubcategories,
                        builder: (context, value, child) {
                          return Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: context.dProvider.black9,
                              ),
                              constraints: const BoxConstraints(minHeight: 100),
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: [
                                  ...cpm.selectedSubcategories.value
                                      .map((e) =>
                                          SubCategoryChip(subcategory: e))
                                      .toList(),
                                  const AddSubCategory(),
                                ],
                              ));
                        },
                      ),
                      16.toHeight,
                      FieldWithLabel(
                        label: LocalKeys.whatAreYouOfferingToClients,
                        hintText: LocalKeys.writeServiceTitle,
                        controller: cpm.titleController,
                        isRequired: true,
                        onChanged: (value) {
                          cpm.slugController.text = value!.replaceAll(" ", "-");
                          cpm.slugExample.value =
                              "$siteLink/${value!.replaceAll(" ", "-")}";
                        },
                        validator: (value) {
                          return value.toString().length < 5
                              ? LocalKeys.writeServiceTitle
                              : null;
                        },
                      ),
                      FieldWithLabel(
                          label: LocalKeys.projectSlug,
                          hintText: LocalKeys.enterProjectSlug,
                          controller: cpm.slugController,
                          exampleNotifier: cpm.slugExample,
                          onChanged: (String? value) {
                            cpm.slugExample.value =
                                "$siteLink/${value!.replaceAll(" ", "-")}";
                          },
                          validator: (value) {
                            return value.toString().length < 20
                                ? LocalKeys.enterProjectSlug
                                : null;
                          },
                          isRequired: true),
                      FieldLabel(
                        label: LocalKeys.writeADescriptionAboutYourProject,
                        isRequired: true,
                      ),
                      // FieldWithLabel(
                      //     label: LocalKeys.description,
                      //     hintText: LocalKeys.writeADescriptionAboutYourProject,
                      //     controller: cpm.descriptionController,
                      //     textInputAction: TextInputAction.newline,
                      //     minLines: 4,
                      //     validator: (value) {
                      //       return value.toString().length < 50
                      //           ? LocalKeys.writeADescriptionAboutYourProject
                      //           : null;
                      //     },
                      //     isRequired: true),
                    ],
                  ).hp20,
                ),
                FlutterSummernote(
                  hint: cpm.descriptionController.text.isEmpty
                      ? LocalKeys.writeProjectDescription
                      : null,
                  hasAttachment: false,
                  value: cpm.descriptionController.text,
                  height: 360,
                  showBottomToolbar: false,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.dProvider.black7,
                      width: 1,
                    ),
                  ),
                  returnContent: (value) {
                    cpm.descriptionController.text = value;
                    debugPrint(value.toString());
                  },
                  key: cpv.keyEditor,
                ).hp20,
              ],
            ),
            20.toHeight,
            const CreateProjectButtons().hp20,
          ],
        ),
      ),
    );
  }
}
