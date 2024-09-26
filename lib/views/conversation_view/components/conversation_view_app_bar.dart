import 'package:flutter/material.dart';
import '/utils/components/navigation_pop_icon.dart';

import '/helper/extension/context_extension.dart';
import '../../../helper/local_keys.g.dart';
import '../../../utils/components/empty_spacer_helper.dart';

class ConversationViewAppBar extends StatelessWidget {
  final String name;
  final String? imageUrl;
  const ConversationViewAppBar({required this.name, this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: context.dProvider.whiteColor,
      margin: EdgeInsets.only(top: context.paddingTop),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        EmptySpaceHelper.emptyWidth(12),
        const NavigationPopIcon(),
        EmptySpaceHelper.emptyWidth(24),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: context.titleMedium?.bold6,
            ),
            Text(
              LocalKeys.online,
              style: context.titleSmall?.bold5,
            ),
          ],
        ),
      ]),
    );
  }
}
