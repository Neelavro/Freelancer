import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:xilancer/services/chat_credential_service.dart';
import 'package:xilancer/services/conversation_service.dart';

class PusherHelper {
  late BuildContext context;
  var clientId;
  var userId;
  var channelName;
  bool subscribed = false;
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  ChatCredentialService get credentials {
    return Provider.of<ChatCredentialService>(context, listen: false);
  }

  disConnect() async {
    try {
      await pusher.unsubscribe(channelName: channelName.toString());
      await pusher.disconnect();
    } catch (e) {}
  }

  void connectToPusher(BuildContext context, clientId, userId) async {
    this.context = context;
    this.clientId = clientId;
    channelName = "private-livechat-client-channel.$userId.$clientId";
    this.userId = userId;
    if (credentials.appKey.isEmpty) {
      return;
    }
    try {
      await pusher.init(
        apiKey: credentials.appKey,
        cluster: credentials.appCluster,
        onEvent: onEvent,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onConnectionStateChange: onConnectionStateChange,
        onError: (s, i, d) {
          throw s;
        },
        onAuthorizer: onAuthorizer,
      );
      await pusher.subscribe(channelName: channelName.toString());
      await pusher.connect();
      subscribed = true;
    } catch (e) {
      await pusher.unsubscribe(channelName: channelName.toString());
      await pusher.disconnect();
    }
  }

  dynamic onAuthorizer(String channelName, String socketId, dynamic options) {
    var stringToSign = '$socketId:$channelName';

    var hmacSha256 = Hmac(sha256, utf8.encode(credentials.appSecret));
    var digest = hmacSha256.convert(utf8.encode(stringToSign));

    return {
      "auth": "${credentials.appKey}:$digest",
      "user_data": "{\"id\":\"1\"}",
    };
  }

  void onEvent(PusherEvent event) {
    final messageReceived = jsonDecode(event.data)['message'];
    debugPrint(messageReceived.toString());
    final receivedUserId = jsonDecode(event.data)['message']['from_user'];
    debugPrint(receivedUserId.toString());

    if (context.mounted) {
      Provider.of<ConversationService>(context, listen: false)
          .addNewMessage(messageReceived);
    } else {
      ConversationService().addNewMessage(messageReceived);
    }
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    subscribed = true;
    debugPrint("onSubscriptionSucceeded: $channelName data: $data");
  }

  void onConnectionStateChange(dynamic currentState, dynamic previousState) {
    debugPrint("Connection: $currentState");
  }
}
