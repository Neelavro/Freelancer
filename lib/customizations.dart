import 'package:flutter/material.dart';

String siteLink = 'https://skilled.zone';

String appLabel = 'SkilledZone Freelancer';
String storeLabel = "SkilledZone Freelancer";
String appVersion = '1.0.0';

String wPaymentUpdateEncryptionKey = 'apiwalletkey';
String socialSignInKey =
    '\$2y\$10\$GlEhJtlTAqv2rvQd2llgPeGGV8RT2Yap844OSazHfHlbU.0bvVTPm';

//This is only needed for apple sign-in.
String clientSecret = "";

String get baseEndPoint => "$siteLink/api/v1/freelancer";
String get projectImagePath => "$siteLink/assets/uploads/project";

const Color primaryColor = Color(0xff6176F6);
const Color blackColor = Color(0xff101828);
const Color whiteColor = Color(0xffffffff);
const Color hintColor = Color(0xff9a9a9e);
const Color borderColor = Color(0xffCDCCCE);
const Color secondaryColor = Color(0xff6176F6);
const Color warningColor = Color(0xffEB4747);
const Color greenColor = Color(0xff65C18C);
const Color yellowColor = Color(0xffFFB200);

const Color gOneColor = Color(0xff6176F6);
const gTwoColor = Color(0xffFAA500);

List<Color> get chatAvatarBGColors => [
      const Color(0xff0087BF),
      const Color(0xff5A8770),
      const Color(0xff9A89B5),
      const Color(0xffF5888D),
      const Color(0xff98A2B3),
      const Color(0xffF18636),
    ];
List<Color> get statusColors => [
      const Color(0xff9a9a9e),
      const Color(0xff65C18C),
      const Color(0xffEB4747),
    ];
