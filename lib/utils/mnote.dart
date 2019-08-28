import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mnote_app/model/sign_model.dart';
import 'package:mnote_app/service/refresh_token_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mnote {

  static double deviceWidth = 0.0;
  static String accessToken = '';
  static String refreshToken = '';
  static String myEmail = '';

  // 구독 상품 관련
  static bool isInApp = false; // false == 미구독 유저 true == 구독 유저
  static Set<String> kIds = {'a.001',};

  // setting
  static String homeEditMode = 'ON'; // ON / OFF
  static String todayAlarmMode = 'OFF'; // ON / OFF
  static String secretMode = 'OFF'; // ON / OFF
  static String secretNumber = '';
  static String nightMode  = 'OFF';
  static String defaultFontFamily = 'MNote'; // MNoteNanum

  // edit status
  static String alignValue = '0'; // 0,1,2,3

  // 앱바 오른쪽 완료 버튼
  static TextStyle appBarRightOkBtnText =
  TextStyle(color: Color.fromRGBO(255, 113, 43, 1), fontSize: 15);

  // 앱바 가운데 제목
  static TextStyle appBarCenterTitle =
  TextStyle(color: Colors.black, fontSize: 20);

  // 기본 본문 타이틀 필드 라벨 텍스트
  static TextStyle textFiledLabel = TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
  static TextStyle textFiledLabelDisabled =
  TextStyle(color: Colors.grey, fontSize: 18);

  // 기본 본문 텍스트 필드 힌트 텍스트
  static TextStyle textFiledHint = TextStyle(color: Colors.black12,);

  // 노트 제목 텍스트 필드 힌트 텍스트
  static TextStyle noteTitleFiledHint = TextStyle(fontSize: 24, color: Colors.black);

  // 노트 부제목 텍스트 필드 힌트 텍스트
  static TextStyle noteSubTitleFiledHint = TextStyle(fontSize: 15, color: gray153);
  static TextStyle noteSubTitleFiled = TextStyle(fontSize: 15, color: Colors.black);

  // 노트 BOX 하단 텍스트
  static TextStyle noteBoxBottomText = TextStyle(fontSize: 15, color: Colors.black);
  // 노트 BOX 내부 텍스트
  static TextStyle noteBoxTitleText = TextStyle(fontSize: 12, color: Colors.black, decoration: TextDecoration.underline);

  // 화면 하단 버튼 텍스트 스타일
  static TextStyle screenBottomBtnWText = TextStyle(fontSize: 16, color: Colors.white);
  static TextStyle screenBottomBtnBText = TextStyle(fontSize: 16, color: Colors.black);

  // 13.5 font
  static TextStyle textBlack_13_5 = TextStyle(fontSize: 13.5, color: Colors.black);
  static TextStyle textBlackUnder_13_5 = TextStyle(fontSize: 13.5, color: Colors.black, decoration: TextDecoration.underline);
  static TextStyle textHint_13_5 = TextStyle(fontSize: 13.5, color: gray153);

  // 16 font
  static TextStyle textBlack_16 = TextStyle(fontSize: 16, color: Colors.black);
  static TextStyle textHint_16 = TextStyle(fontSize: 16, color: gray153);
  static TextStyle textBlackUnder_16 = TextStyle(fontSize: 16, color: Colors.black, decoration: TextDecoration.underline);

  // 20 font
  static TextStyle textBlack_20 = TextStyle(fontSize: 20, color: Colors.black);
  static TextStyle textHint_20 = TextStyle(fontSize: 20, color: gray153);

  // 토글 버튼
  static TextStyle toggleBtnWText = TextStyle(fontSize: 10, color: Colors.white);

  // 오렌지 컬러
  static Color orange = Color.fromRGBO(255, 113, 43, 1);

  // 회색 컬러
  static Color gray153 = Color.fromRGBO(153, 153, 153, 1);
  static Color gray245 = Color.fromRGBO(245, 245, 245, 1);

  // 블랙 컬러
  static Color mnoteBlack = Color.fromRGBO(46, 46, 46, 1);

  // 야간모드에 따른  배경 색
  static Color nightModeBackgroundColor = Colors.white; // or Color.fromRGBO(46, 46, 46, 1) splash_screen 에서 설정
  static Color nightModeTextColor = Colors.black; // or Color.fromRGBO(46, 46, 46, 1) splash_screen 에서 설정

  // 날짜 포멧 1
  static String getDateFormat_1(String date){
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyy.MM.dd').format(dateTime);
  }
  static String getDateFormat_2(String date){
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyy.MM.dd hh:mm').format(dateTime);
  }
  static String getDateFormat_3(String date){
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd hh:mm').format(dateTime);
  }

  // email
  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  // subString & add Text
  static String subStringAndAddText(String originText, String addText, int position){
    String startText = originText.substring(0, position);
    String endText = originText.substring(position, originText.length);
    String resultText = startText + addText + endText;
    return resultText;
  }

  // 토큰 만료
  static Future<String> tokenErrorCheck(String jsonResponse) async {
    print('만료체크 ??????????? ');
    print(jsonResponse);
    if (jsonResponse.contains('Expired token')){
      SignModel signModel = await getRefreshToken();
      if (signModel == null || signModel.accessToken == '' || signModel.refreshToken == ''){
        print('실패');
        return '실패';
      }else{
        print('갱신');
        Mnote.accessToken = signModel.accessToken;
        Mnote.refreshToken = signModel.refreshToken;
        return '갱신';
      }
    }
    if (jsonResponse.contains('Signature verification failed')){
      return '만료';
    }
    // 에러 없을 경우
    return '정상';
  }

  // 전체 설정값 초기화
  static void logout(SharedPreferences prefs){
    prefs.setString('auto_login', 'false');
    prefs.setString('access_token', '');
    prefs.setString('refresh_token', '');
    prefs.setString('night_mode', 'OFF');
    prefs.setString('secret_mode', 'OFF');
    Mnote.accessToken = '';
    Mnote.refreshToken = '';
    Mnote.myEmail = '';
    Mnote.isInApp = false;
    Mnote.nightMode  = 'OFF';
    Mnote.secretMode = 'OFF';
  }
}
