import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

class TextSkeleton extends StatelessWidget {
  final height;
  final width;
  final color;
  const TextSkeleton({this.height, this.width, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width?.toDouble(),
      height: height?.toDouble(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color ?? context.dProvider.black8,
      ),
    );
  }
}
