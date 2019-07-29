import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/book_model.dart';
import 'package:mnote_app/utils/mnote.dart';

Future<List<BookModel>> getBooksMy() async {
  String dataURL =
      'http://icomerict.cafe24.com/untitled_note/json/books_my.php';
  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    final items = (jsonResponse['books_my'] as List)
        .map((i) => new BookModel.fromJson(i));
    return items.toList();
  } else {
    print('getMyNoteBookList() fail');
    return [];
  }
}

/*
* 19.07.20
*
* 내 노트 표시 보기
* http://icomerict.cafe24.com/untitled_note/json/books_my_intro.php
*
* 4번은 표지 클릭 시 나올 팝업창에서 해당 번호가 체크 된 상태이면 될 것 같습니다. 공개는 1 공개 0 비공개 입니다.
* 이 화면에서 수정 후 저장하기 클릭 시 다음 슬라이드의 표지 업데이트 api로 연결되면 됩니다.
*/

Future<List<BookModel>> getBooksMyIntro(String bookNo) async {
  String dataURL =
      'http://icomerict.cafe24.com/untitled_note/json/books_my_intro.php';
  final response = await http.post(
      dataURL,
      headers: {'access_token': Mnote.accessToken},
      body: {'book_no': bookNo});
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(dataURL);
    print(jsonResponse);
    final items = (jsonResponse['books_my'] as List)
        .map((i) => new BookModel.fromJson(i));
    return items.toList();
  } else {
    print('getMyNoteBookList() fail');
    return [];
  }
}

/*
   19.07.20
   새 노트 생성
   http://icomerict.cafe24.com/untitled_note/json/write_new_book.php

   출력 값
   출력 값은 따로 설명드릴 필요는 없을 것 같습니다. 여기서 true 값이 나오면 성공이며, false는 토큰에 에러가 있는 등 insert에 실패 할 때 출력됩니다.
   여기서 book_no 값을 가지고 챕터 목록 화면으로 넘어가면 될 것 같습니다. 여기는 임시 저장 필요 없습니다.
   안에 내용이 하나라도 있을 때 저장하기 버튼을 누르 지 않고 뒤로 버튼이나 직접 페이지를 나갈 때는 알림창, ‘저장하지 않은 정보는 삭제 됩니다.
   나가시겠습니까? -> 예 아니오.
   여기서 필수 항목은 타이틀 하나입니다. 타이틀이 null 일 경우 저장하기 불가 토스트 메시지 ‘제목을 입력해 주세요’
   나머지는 빈 값이여도 됩니다. 추후 노트 보기 시 null이면 hint로 ~를 입력해 주세요.
 */

Future<String> writeNewBook(String title, String subtitle,
    String intro, String coverImgNo, String show) async {
  String dataURL =
      'http://icomerict.cafe24.com/untitled_note/json/write_new_book.php';
  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
    body: {
      'title': title,
      'subtitle': subtitle,
      'intro': intro,
      'cover_img_no': coverImgNo,
      'show': show
    },
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(dataURL);
    print(jsonResponse);
    if (jsonResponse['result'] == 'true'){
      return jsonResponse['new_book']['book_no'];
    }
    else{
      return 'fail';
    }
  } else {
    print('writeNewBook() fail');
    return 'fail';
  }
}

/*
* 19.07.20
* 노트 표지 정보 쓰기 (노트 업데이트)
* 출력 값
* true 일 때 업데이트 성공, false 일 때는 업데이트 실패입니다. 실패할 경우는 거의 없 을 것 같긴한대..
* title 이나 book_no 값이 null이면 업데이트 false 나옵니다.
* 제목을 빈 칸으로 수정한 후 저장 버튼 클릭하면 ‘제목을 입력해 주세요’ 토스트 메시 지.
* 토큰값 만료되도 false 뜨면서 error에 토큰 에러 출력됩니다.
* 리프레쉬 api 통해서 토 큰 재 발급 받고 해당 값들로 업데이트 api 재요청 해야됩니다.
*
*/

Future<String> updateBook(String bookNo, String title, String subtitle,
    String intro, String coverImgNo, String show) async {
  String dataURL =
      'http://icomerict.cafe24.com/untitled_note/json/update_book.php';
  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
    body: {
      'book_no': bookNo,
      'title': title,
      'subtitle': subtitle,
      'intro': intro,
      'cover_img_no': coverImgNo,
      'show': show
    },
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(dataURL);
    print(jsonResponse);
    return jsonResponse['result'];
  } else {
    print('getMyNoteBookList() fail');
    return 'fail';
  }
}


/*
* 19.07.20
* 노트 삭제
* 출력 값
* 메인 페이지에서 노트 길게 누른 후 출력 되는 팝업에서 확인 눌렀을 때
* (이미지에 보 면 취소 비활성화인데 이거 실수인 것 같습니다. 취소 확인 둘 다 활성상태여야 합니 다.)
* true 삭제 성공, false 삭제 실패.
*
*/

Future<String> deleteBook(String bookNo) async {
  String dataURL =
      'http://icomerict.cafe24.com/untitled_note/json/delete_book.php';
  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
    body: {
      'book_no': bookNo,
    },
  );
  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(dataURL);
    print(jsonResponse);
    return jsonResponse['result'];
  } else {
    print('getMyNoteBookList() fail');
    return 'fail';
  }
}
