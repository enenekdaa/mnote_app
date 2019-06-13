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

  static void goToNoteBookView(BuildContext context) {
    Navigator.pushNamed(context, "/note_book_view");
  }

  static void goToNoteBookEdit(BuildContext context) {
    Navigator.pushNamed(context, "/note_book_eidt");
  }

  static void goToNoteView(BuildContext context) {
    Navigator.pushNamed(context, "/note_view");
  }

  static void goToNoteEdit(BuildContext context) {
    Navigator.pushNamed(context, "/note_edit");
  }

  static void goToTodayNoteMain(BuildContext context) {
    Navigator.pushNamed(context, "/today_note_main");
  }

  static void goToTodayNoteEdit(BuildContext context) {
    Navigator.pushNamed(context, "/today_note_edit");
  }

  static void goToTodayNoteSubject(BuildContext context) {
    Navigator.pushNamed(context, "/today_note_subjects");
  }

  static void goToTodayNoteList(BuildContext context) {
    Navigator.pushNamed(context, "/today_note_list");
  }

  static void goToTodayNoteView(BuildContext context) {
    Navigator.pushNamed(context, "/today_note_view");
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

  static void goToNavigation(BuildContext context) {
    Navigator.pushNamed(context, "/navigation");
  }


}