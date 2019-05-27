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


}