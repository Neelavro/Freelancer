import 'package:flutter/material.dart';

import '../../app_static_values.dart';
import '../../helper/extension/context_extension.dart';
import '../../helper/extension/int_extension.dart';
import '../../utils/components/custom_preloader.dart';
import '/helper/extension/string_extension.dart';
import 'empty_spacer_helper.dart';
import 'field_label.dart';

class FieldWithLabel extends StatelessWidget {
  final String label;
  final String hintText;
  final initialValue;
  final onChanged;
  final onFieldSubmitted;
  final String? Function(String? value)? validator;
  final keyboardType;
  final textInputAction;
  final String? svgPrefix;
  final AutovalidateMode? autovalidateMode;
  final ValueNotifier<Status>? errorNotifier;
  final errorText;
  final successText;
  final Iterable<String>? autofillHints;
  final controller;
  final isRequired;
  final int? minLines;
  final int? maxLines;
  final Widget? prefixIcon;
  final ValueNotifier<String>? exampleNotifier;
  const FieldWithLabel(
      {super.key,
      required this.label,
      required this.hintText,
      this.initialValue,
      this.onChanged,
      this.onFieldSubmitted,
      this.validator,
      this.keyboardType,
      this.textInputAction,
      this.svgPrefix,
      this.autovalidateMode,
      this.isRequired,
      this.errorNotifier,
      this.errorText,
      this.successText,
      this.prefixIcon,
      this.autofillHints,
      this.maxLines,
      this.minLines,
      this.exampleNotifier,
      this.controller});

  setInitialValue(value) {
    if (value == null || value.isEmpty) {
      return;
    }

    controller?.text = value;
  }

  @override
  Widget build(BuildContext context) {
    setInitialValue(initialValue);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: label, isRequired: isRequired ?? false),
        TextFormField(
          keyboardType: keyboardType,
          textInputAction: textInputAction ?? TextInputAction.next,
          controller: controller,
          autovalidateMode: autovalidateMode,
          autofillHints: autofillHints,
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: svgPrefix != null || prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: prefixIcon ?? svgPrefix!.toSVG,
                    )
                  : null,
              suffixIcon: errorNotifier == null
                  ? null
                  : ValueListenableBuilder(
                      valueListenable: errorNotifier!,
                      builder: (context, value, child) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: value == Status.NOT_INITIATED ||
                                      value == Status.INVALID
                                  ? const SizedBox()
                                  : value == Status.NOT_AVAILABLE
                                      ? Icon(
                                          Icons.close_rounded,
                                          color: context.dProvider.warningColor,
                                        )
                                      : value == Status.AVAILABLE
                                          ? Icon(
                                              Icons.done_rounded,
                                              color:
                                                  context.dProvider.greenColor,
                                            )
                                          : const CustomPreloader(),
                            ),
                          ],
                        );
                      })),
          onChanged: onChanged,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
        ),
        if (errorNotifier != null) ...[
          8.toHeight,
          ValueListenableBuilder(
              valueListenable: errorNotifier!,
              builder: (context, error, child) {
                return error == Status.NOT_INITIATED ||
                        error == Status.LOADING ||
                        error == Status.INVALID
                    ? const SizedBox()
                    : Text(
                        error == Status.NOT_AVAILABLE ? errorText : successText,
                        style: context.titleMedium
                            ?.copyWith(color: context.dProvider.black5),
                      );
              })
        ],
        if (exampleNotifier != null)
          ValueListenableBuilder(
              valueListenable: exampleNotifier!,
              builder: (context, value, child) {
                return Text(
                  value,
                  style: context.titleMedium
                      ?.copyWith(color: context.dProvider.black5),
                );
              }),
        EmptySpaceHelper.emptyHeight(16),
      ],
    );
  }
}
