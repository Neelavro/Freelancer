import 'package:flutter/material.dart';

class CustomFutureWidget extends StatelessWidget {
  final child;
  final shimmer;
  final isLoading;
  final function;
  const CustomFutureWidget(
      {super.key,
      required this.child,
      this.function,
      this.shimmer,
      this.isLoading});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: function,
      builder: (context, snapshot) {
        if ((snapshot.connectionState == ConnectionState.waiting ||
                isLoading == true) &&
            shimmer != null) {
          return shimmer;
        }

        return child;
      },
    );
  }
}
