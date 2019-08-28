import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/model/writer_all.dart';
import 'package:mnote_app/utils/mnote.dart';

// 로그인
Future<SignModel> getSignIn(BuildContext context, String email, String password) async {
  // result ==.. true = 성공 / false = 실패
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/sign_in/sign_in.php';
  final response = await http.post(dataURL, body: {'email': email, 'password': password});

  final jsonResponse = json.decode(response.body);

  if (response.statusCode == 200) {
    SignModel signModel = new SignModel.fromJson(jsonResponse);
    return signModel;
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
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

  if (response.statusCode == 200) {
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

  if (response.statusCode == 200) {
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

  if (response.statusCode == 200) {
    return jsonResponse['result'] == 'true'; // true : 사용 가능
  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }
}

// 비밀 번호 찾기
/*
  로그인 화면에서 좌측 하단의 pw찾기 버튼 클릭 시 이벤트 입니다.
  우측 ‘글감 제보하기’와 같은 형식의 팝업창을 띄운 후
  타이틀: 임시 비밀번호 받기
  내용: 회원 가입 시 이용하신 이메일 주소를 입력해 주세요. 해당 메일로 임시 비밀번호가 발송됩니다.
  입력창: 이메일 형식(회원가입 처럼 이메일 검증하여 메일 형식 아닐 시 토스트. 이메일 형식을 확인해 주세요.)

  출력 변수 result
  true – 메일 발송 성공. 토스트 메시지 또는 팝업창으로 ‘임시 비밀번호가 발송되었습니다.’
  false – 메일 발송 실패. 위와 같은 형식으로 ‘메일 발송에 실패하였습니다. 다시 시도해주세요.’
  email_incorrect – 실패. ‘존재하지 않는 회원입니다. 회원 가입 시 입력한 이메일 계정을 확인해주세요.’
  result 값은 위 3가지 경우만 출력됩니다.
*/
Future<String> changePasswordMail(BuildContext context, String email) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/mail/change_pw_mail.php';
  final response = await http.post(dataURL ,
      body: {'my_email' : email}
  );

  final jsonResponse = json.decode(response.body);

  if (response.statusCode == 200) {
    return jsonResponse['result']; // true : 사용 가능
  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }
}

// 내 프로필 조회

Future<WriterAll> getMyProfile(BuildContext context,) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/my_profile.php';
  final response = await http.post(dataURL ,
      headers: {'access_token': Mnote.accessToken},
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    print(jsonResponse);
    WriterAll profile = new WriterAll.fromJson(jsonResponse['my_profile']);
    return profile;
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getMyProfile(context);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}

// 내 프로필 변경
/*
호출 요청 값 (팝업창에 입력한 이메일 값을 변수에 담아 전달)

필명 중복 확인은 회원 가입에 있는 중복확인 api와 같은 주소로 검증하시면 됩니다.
기본 입력되어 있는 값을 수정하지 않고 저장 버튼 입력해도 함께 보내야 합니다.
업데이트 문에 들어가는거라 필명이나 인트로에 빈 값이 전달되면 null로 업데이트 됩니다.
기존에 있는 값이 수정되지 않으면 기존값, 수정되면 수정값으로 전달하면 되므로 텍스트 박스에 있는 값이
hint나 placeholder 처럼 동작하지 않고 value 처럼 동작하면될 것 같습니다.

비밀번호 칸만 기본 빈 칸으로 있게 두고, 입력하지 않을 시 null 전달하면 됩니다.
비밀번호에 값이 있는지 없는지에 따라 비밀번호 제외하고 업데이트 하는지, 비밀번호도 같이 업데이트 하는지 2 가지 업데이트 문 중 맞게 돌아갑니다.
강제로 필명에 빈 칸 입력 후 저장 누르면 ‘필명을 입력해 주세요‘ 토스트, 비밀번호 둘중 하나가 비었거나,
둘이 다를 때 토스트 (토스트 메시지는 회원가입 부분 작업해 두신 것과 거의 똑같이 작업하시면 될 것 같습니다.)

출력 값
result – true or false 빈 칸이 있거나 필명이 중복이거나 할 때 외에는 true 이며 업데
이트 성공입니다. false는 거의 안나오는데 빈칸, 중복 모두 앱에서 검증 해도 api에서
한번 더 검증하게 해두었습니다. 앱에서 잘 검증 됐으면 false 나올 일은 없습니다.
*/
Future<String> changeMyProfile(
    BuildContext context,
    String email,
    String writerName,
    String intro,
    String password,
    String passwordConfirm
    ) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/update_my_profile.php';
  final response = await http.post(dataURL ,
      headers: {'access_token': Mnote.accessToken},
      body: {
        'writer_name' : writerName,
        'intro' : intro,
        'password' : password,
        'password_confirm' : passwordConfirm,
      }
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  print(jsonResponse);

  if (response.statusCode == 200 && isTokenOk == '정상') {
    print(jsonResponse['result']);
    return jsonResponse['result'];
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await changeMyProfile(context, email, writerName, intro, password, passwordConfirm);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}

// 구독 업데이트 
// subscribeYN = 0 (구독x)
// subscribeYN = 1 (구독 중)
Future<String> updateSubscribeYN(BuildContext context, String yn) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/sign_in/subscribeYN.php';
  final response = await http.post(dataURL ,
    headers: {'access_token': Mnote.accessToken},
    body: {'subscribeYN': yn == 'Y' ? '1' : '0'}
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    return jsonResponse['result'];
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await updateSubscribeYN(context, yn);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}
