import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/conversation_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/view_models/send_offer_view_model/send_offer_view_model.dart';

import '../../utils/components/navigation_pop_icon.dart';
import '../send_offer_view/send_offer_view.dart';
import '/views/conversation_view/components/conversations_input_box.dart';
import 'components/conversation_message_list.dart';
import 'components/conversation_skeleton.dart';

class ConversationView extends StatelessWidget {
  static const routeName = "conversation_view";
  const ConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = context.arguments;
    final id = arguments[0];
    final name = arguments[1];
    final image = arguments[2];
    final clientId = arguments[3];
    final freelancerId = arguments[4];
    final cProvider = Provider.of<ConversationService>(context, listen: false);
    return Scaffold(
      backgroundColor: context.dProvider.black9,
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(name),
        actions: [
          OutlinedButton(
              onPressed: () {
                SendOfferViewModel.dispose;
                context.toPage(SendOfferView(
                  clientId: clientId,
                ));
              },
              child: Text(LocalKeys.sendOffer)),
          12.toWidth,
        ],
      ),
      body: CustomFutureWidget(
          function: cProvider.shouldAutoFetch(id)
              ? cProvider.fetchConversationMessages(
                  id.toString(),
                  context: context,
                  clientId: clientId,
                  freelancerId: freelancerId,
                )
              : null,
          shimmer: const ConversationSkeleton(),
          child: Consumer<ConversationService>(builder: (context, cs, child) {
            // Provider.of<MessageNotificationCountService>(context, listen: false)
            //     .fetchMN();
            return Column(
              children: [
                Expanded(
                    child: ConversationMessageList(
                  cs: cs,
                  name: name,
                  clientImage: image,
                )),
                ConversationInputBox(
                  clientId: clientId,
                ),
              ],
            );
          })),
    );
  }
}
