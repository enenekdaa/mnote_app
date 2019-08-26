import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/utils/mnote.dart';

String resultURL;

// url = http://icomerict.cafe24.com/untitled_note/sign_in/refresh_token.php
// result ==.. true = 성공 / false = 실패
// access_token / refresh_token 받음

Future<SignModel> getRefreshToken() async {
  String resultURL = 'http://icomerict.cafe24.com/untitled_note/sign_in/refresh_token.php';
  final response = await http.post(resultURL, headers: {'refresh_token' : Mnote.refreshToken},);
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    SignModel signUpModel = new SignModel.fromJson(jsonResponse);
    return signUpModel;
  } else {
    return null;
  }
}