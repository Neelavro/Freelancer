import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroService with ChangeNotifier {
  final introData = [
    {
      "title": "Browse Jobs",
      "description":
          "Browse and find thousands of jobs offered by clients using our filters and get hired for your dream projects.",
      "image": "assets/images/intro_1.png",
    },
    {
      "title": "Track Orders",
      "description":
          "Monitor project progress and delivery status in real-time for seamless management.",
      "image": "assets/images/intro_2.png",
    },
    {
      "title": "Live Chat",
      "description":
          "Talk with clients directly and work efficiently towards a great project.",
      "image": "assets/images/intro_3.png",
    },
  ];
  int currentIndex = 0;

  void setIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  checkIntro() async {
    final sp = await SharedPreferences.getInstance();
    bool? intro = sp.getBool("intro");
    if (intro == null) {
      return true;
    }
    return false;
  }

  seeIntroValue() async {
    final sp = await SharedPreferences.getInstance();
    sp.setBool("intro", true);
  }

  fetchIntro(BuildContext context) {}
}
