import 'package:flutter/material.dart';

class Mnote {
  // 앱바 오른쪽 완료 버튼
  static TextStyle appBarRightOkBtnText =
  TextStyle(color: Color.fromRGBO(255, 113, 43, 1), fontSize: 15);

  // 앱바 가운데 제목
  static TextStyle appBarCenterTitle =
  TextStyle(color: Colors.black, fontSize: 20);

  // 기본 본문 타이틀 필드 라벨 텍스트
  static TextStyle textFiledLabel =
  TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);

  // 기본 본문 텍스트 필드 힌트 텍스트
  static TextStyle textFiledHint = TextStyle(color: Colors.black12,);

  // 노트 제목 텍스트 필드 힌트 텍스트
  static TextStyle noteTitleFiledHint = TextStyle(
      fontSize: 20, color: Colors.black);

  // 노트 부제목 텍스트 필드 힌트 텍스트
  static TextStyle noteSubTitleFiledHint = TextStyle(
      fontSize: 15, color: Colors.grey);

  // 노트 BOX 하단 텍스트
  static TextStyle noteBoxBottomText = TextStyle(fontSize: 15, color: Colors.black);
  // 노트 BOX 내부 텍스트
  static TextStyle noteBoxTitleText = TextStyle(fontSize: 12, color: Colors.black, decoration: TextDecoration.underline);

  // 화면 하단 버튼 텍스트 스타일
  static TextStyle screenBottomBtnWText = TextStyle(fontSize: 16, color: Colors.white);
  static TextStyle screenBottomBtnBText = TextStyle(fontSize: 16, color: Colors.black);

  // 토글 버튼
  static TextStyle toggleBtnWText = TextStyle(fontSize: 10, color: Colors.white);

  // 오렌지 컬러
  static Color orange = Color.fromRGBO(255, 113, 43, 1);

}
