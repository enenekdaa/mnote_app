import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/overlap_check_model.dart';
import 'package:mnote_app/model/sign_model.dart';

String resultURL;

// 로그인
Future<SignModel> getSignIn(String email, String password) async {
  // result ==.. true = 성공 / false = 실패
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/sign_in/sign_in.php';
  final response = await http.post(dataURL, body: {'email': email, 'password': password});

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    SignModel signModel = new SignModel.fromJson(jsonResponse);
    return signModel;
  } else {
    throw Exception('Failed to load post');
  }
}

// 회원 가입
Future<SignModel> getSignUp(
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

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    SignModel signModel = new SignModel.fromJson(jsonResponse);
    return signModel;
  } else {
    throw Exception('Failed to load post');
  }
}

// 이메일 중복 체크
Future<bool> getEmailCheck(String email) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/sign_in/email_check.php';
  final response = await http.post(dataURL ,
      body: {'email' : email}
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse['result']);
    return jsonResponse['result'] == 'true'; // true : 사 가능
  } else {
    throw Exception('Failed to load post');
  }
}

// 필명 중복 체크
Future<bool> getWriterNameCheck(String name) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/sign_in/writer_name_check.php';
  final response = await http.post(dataURL ,
      body: {'writer_name' : name}
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return jsonResponse['result'] == 'true'; // true : 사 가능

  } else {
    throw Exception('Failed to load post');
  }
}