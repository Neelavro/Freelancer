import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/views/conversation_view/components/send_offer_sheet.dart';

class ConversationMenu extends StatelessWidget {
  final jobTitle;
  const ConversationMenu({
    super.key,
    this.jobTitle,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier isExpanded = ValueNotifier(false);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          border: Border(
            bottom: BorderSide(color: context.dProvider.black8),
          )),
      child: Column(
        children: [
          ExpansionTile(
            initiallyExpanded: false,
            onExpansionChanged: (value) => isExpanded.value = value,
            tilePadding: EdgeInsets.zero,
            collapsedShape: const RoundedRectangleBorder(),
            shape: const RoundedRectangleBorder(),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: ValueListenableBuilder(
                      valueListenable: isExpanded,
                      builder: (context, value, child) => Text(
                        jobTitle,
                        maxLines: value ? 3 : 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.titleMedium?.bold6
                            .copyWith(color: context.dProvider.primaryColor),
                      ),
                    )),
              ],
            ),
            trailing: Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.dProvider.black8,
              ),
              child: ValueListenableBuilder(
                valueListenable: isExpanded,
                builder: (context, value, child) => value
                    ? const Icon(Icons.keyboard_arrow_up_rounded)
                    : const Icon(Icons.keyboard_arrow_down_outlined),
              ),
            ),
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        height: 40,
                        width: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: context.dProvider.black8,
                            )),
                        child: SvgAssets.flag.toSVG,
                      )),
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 10,
                      child: OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) => const SendOfferSheet(),
                          );
                        },
                        child: Text(LocalKeys.sendOffer),
                      )),
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 10,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(LocalKeys.submitWork),
                      )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
