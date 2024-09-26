import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/services/profile_details_service.dart';

import '../../helper/constant_helper.dart';
import '../../helper/local_keys.g.dart';
import '../../utils/components/alerts.dart';

class ProfileDetailsViewModel {
  final viewAsClient = ValueNotifier(true);
  final editPrice = ValueNotifier(false);
  TextEditingController priceController = TextEditingController();
  TextEditingController skillTextController = TextEditingController();
  ScrollController controller = ScrollController();
  ValueNotifier skillEditing = ValueNotifier(false);
  ProfileDetailsViewModel._init();
  static ProfileDetailsViewModel? _instance;
  static ProfileDetailsViewModel get instance {
    _instance ??= ProfileDetailsViewModel._init();
    return _instance!;
  }

  ProfileDetailsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  tryChangingStatus(BuildContext context) async {
    final pdProvider =
        Provider.of<ProfileDetailsService>(context, listen: false);
    Alerts().confirmationAlert(
      context: context,
      title: LocalKeys.areYouSure,
      onConfirm: () async {
        await pdProvider.tryChangingStatus().then((v) {
          if (v == true) {
            context.popFalse;
          }
        });
      },
      buttonText: LocalKeys.confirm,
      buttonColor: dProvider.primaryColor,
    );
  }

  tryProjectStatusChange(BuildContext context, {id}) async {
    final pdProvider =
        Provider.of<ProfileDetailsService>(context, listen: false);
    Alerts().confirmationAlert(
      context: context,
      title: LocalKeys.areYouSure,
      onConfirm: () async {
        await pdProvider.tryStatusChange(id: id).then((v) {
          if (v == true) {
            context.popFalse;
          }
        });
      },
      buttonText: LocalKeys.confirm,
      buttonColor: dProvider.primaryColor,
    );
  }
}
