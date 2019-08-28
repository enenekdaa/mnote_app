import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mnote_app/model/chapter_model.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/utils/mnote.dart';

Future<ChapterModel> getChapterDetail(BuildContext context, String bookNo, String chapterNo) async {
  String dataURL =
      'http://icomerict.cafe24.com/untitled_note/json/books_chapter_detail.php';

  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
    body: {'book_no': bookNo, 'chapter_no': chapterNo},
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    ChapterModel chapterDetail =
    new ChapterModel.fromJson(jsonResponse['chapter_detail']);
    return chapterDetail;
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await getChapterDetail(context, bookNo, chapterNo);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}

/*
* 19.07.20
* 새 챕터 생성
* http://icomerict.cafe24.com/untitled_note/json/write_new_chapter.php
*
* 출력 값
* result:,
* new_chapter: {email:, book_no:, chapter_no:}
*
* 빨간 사각형으로 표시해 둔 + 버튼 눌렀을 때, 글 쓰기 화면 들어가면서 호출해야 할 api입니다.
* 임시저장 때문에 처음 글쓰기로 들어갈 때 빈 row를 만들게 됩니다.
* 현재 노트 넘버와 헤더 토큰 함께 보내면 됩니다. 챕터 넘버는 서버에서 현재 마지막 챕터 넘버 조회하여 부여되기 때문에 노트 번호만 있으면 됩니다.
* 우측처럼 나오고 email은 무시하셔도 됩니다.
* 제대로 됐는지 구분하려고 출력하는데 추후 출력 하지 않도록 할 수도 있습니다.
* 어차피 이메일값은 헤더에서 가져옵니다.
* 글 작성 페이지로 넘어갈 때 해당에서 나오는 book_no값과 chapter_no값만 가져가면 됩니다.
* row 생성 실패하면 false 출력됩니다.
*/

Future<String> writeNewChapter(BuildContext context, String bookNo) async {
  String dataURL =
      'http://icomerict.cafe24.com/untitled_note/json/write_new_chapter.php';
  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
    body: {
      'book_no': bookNo,
    },
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    if(jsonResponse['result'] == 'true'){
      return jsonResponse['new_chapter']['chapter_no'];
    }else{
      return 'fail';
    }
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await writeNewChapter(context, bookNo);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}

/*
* 19.07.20
* 챕터 글쓰기 (챕터 수정/업데이트)
* http://icomerict.cafe24.com/untitled_note/json/update_chapter.php
*
* 출력 값
* result:,
*
* book_no, chapter_no 는 이 전 페이지에서 넘어온 값 가져와야 합니다.
* 챕터 타이틀은 빈 칸이 될 수 없으며 내용은 빈 칸도 가능합니다.
* 정렬은 0 양쪽, 1 중앙, 2 오른쪽 입니다.
* show는 하루 글감에만 있는 것으로 기본은 1 입니다. show 값 안보내면 자동으로 1 입 력됩니다.
* 우측 상단 저장하기 버튼 직접 클릭 혹은 임시 저장 모두 똑같이 보내면 됩니다.
* 저장하기 버튼은 클릭 시 위 내용 보내서 저장하고, 목록으로 이동합니다.
* 뒤로가기 버튼(좌측 상단 or 안드로이드 뒤로) 클릭 시 다음 페이지에 있는 삭제 api 돌 리면 됩니다.
* “저장하지 않은 내용은 삭제됩니다. 저장하지 않고 나가시겠습니까?” 팝 업 출력 후 예 아니오.
*/

Future<String> updateChapter(
    BuildContext context,
    String bookNo,
    String chapterNo,
    String chapterTitle,
    String contents,
    String contentsAlignCenter,
    {String show = '1'}) async {
  String dataURL =
      'http://icomerict.cafe24.com/untitled_note/json/update_chapter.php';
  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
    body: {
      'book_no': bookNo,
      'chapter_no': chapterNo,
      'chapter_title': chapterTitle,
      'contents': contents,
      'contents_align_center': contentsAlignCenter,
      'show': show
    },
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    return jsonResponse['result'];
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await updateChapter(context, bookNo, chapterNo, chapterTitle, contents, contentsAlignCenter);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}

/*
* 19.07.20
* 챕터 삭제
* http://icomerict.cafe24.com/untitled_note/json/delete_chapter.php
*
* 출력 값
* result:,
*
* 뒤로 버튼을 눌러 “저장하지 않은 내용은 삭제됩니다. 저장하지 않고 나가시겠습니까?” 출력 후 예 버튼 누를 시 동작.
* 챕터 목록에서 길게 누른 후 삭제 버튼 클릭 시 동작
* true 삭제 성공, false 삭제 실패. 실패할 경우는 아마 헤더가 만료될 때 뿐일 듯?
* 삭제 후 챕터 목록으로 돌아가며 챕터 목록 조회 api 호출. 목록에서 삭제 시 페이지 새 로고침처럼 목록 다시 불러오기.
*
*/

Future<String> deleteChapter(
    BuildContext context,
    String bookNo,
    String chapterNo,) async {
  String dataURL =
      'http://icomerict.cafe24.com/untitled_note/json/delete_chapter.php';
  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
    body: {
      'book_no': bookNo,
      'chapter_no': chapterNo,
    },
  );

  final jsonResponse = json.decode(response.body);
  String isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 && isTokenOk == '정상') {
    return jsonResponse['result'];
  }

  if (isTokenOk == '갱신') { // API 재호출 작업
    return await deleteChapter(context, bookNo, chapterNo);
  }

  Navigator.of(context).popUntil((route) => route.isFirst);
  Navigator.pushReplacementNamed(context, '/sign_in');
  return null;
}
