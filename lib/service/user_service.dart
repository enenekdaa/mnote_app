import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/utils/mnote.dart';

// 로그인
Future<SignModel> getSignIn(BuildContext context, String email, String password) async {
  // result ==.. true = 성공 / false = 실패
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/sign_in/sign_in.php';
  final response = await http.post(dataURL, body: {'email': email, 'password': password});

  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 || isTokenOk) {
    SignModel signModel = new SignModel.fromJson(jsonResponse);
    return signModel;
  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }
}

// 회원 가입
Future<SignModel> getSignUp(
    BuildContext context,
    String email,
    String password,
    String password2,
    String writerName,
    String intro) async {
  // result ==.. true = 성공 / false = 실패
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/sign_in/sign_up.php';
  final response = await http.post(
      dataURL,
      body: {
        'email': email,
        'password': password,
        'password_confirm': password2,
        'writer_name': writerName,
        'intro': intro
      });


  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 || isTokenOk) {
    SignModel signModel = new SignModel.fromJson(jsonResponse);
    return signModel;
  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }
}

// 이메일 중복 체크
Future<bool> getEmailCheck(BuildContext context, String email) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/sign_in/email_check.php';
  final response = await http.post(dataURL ,
      body: {'email' : email}
  );


  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 || isTokenOk) {
    return jsonResponse['result'] == 'true'; // true : 사 가능
  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }
}

// 필명 중복 체크
Future<bool> getWriterNameCheck(BuildContext context, String name) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/sign_in/writer_name_check.php';
  final response = await http.post(dataURL ,
      body: {'writer_name' : name}
  );

  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 || isTokenOk) {
    return jsonResponse['result'] == 'true'; // true : 사용 가능
  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }
}