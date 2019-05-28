import 'package:flutter/material.dart';

class MyNavigator {
  static void goToSplash(BuildContext context) {
    Navigator.pushNamed(context, "/splash");
  }

  static void goToSignIn(BuildContext context) {
    Navigator.pushNamed(context, "/sign_in");
  }

  static void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, "/sign_up");
  }

  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  static void goToNote(BuildContext context) {
    Navigator.pushNamed(context, "/note");
  }

  static void goToPremium(BuildContext context) {
    Navigator.pushNamed(context, "/premium");
  }

  static void goToAppSetting(BuildContext context) {
    Navigator.pushNamed(context, "/app_setting");
  }
  static void goToProfile(BuildContext context) {
    Navigator.pushNamed(context, "/profile");
  }


}