import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/writer_all.dart';
import 'package:mnote_app/utils/mnote.dart';

/*
 * 작과 관련 API Service
 *
 */

// 작가 리스트 전체
Future<List<WriterAll>> getWriterListAll(BuildContext context, String pageNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/writer_list_all.php';

  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'page_no' : pageNo},
  );

  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());


  if (response.statusCode == 200 || isTokenOk) {
    final items = (jsonResponse['writer_list'] as List).map((i) => new WriterAll.fromJson(i));
    return items.toList();

  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }

}

// 구독 작가 목록
Future<List<WriterAll>> getWriterListSub(BuildContext context, String pageNo) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/writer_list_sub.php';

  final response = await http.post(dataURL ,
    headers: {'access_token' : Mnote.accessToken},
    body: {'page_no' : pageNo},
  );

  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 || isTokenOk) {
    if (!jsonResponse.toString().contains('my_sub_list')){
      return [];
    }
    final items = (jsonResponse['my_sub_list'] as List).map((i) => new WriterAll.fromJson(i));
    return items.toList();

  } else {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacementNamed(context, '/sign_in');
    return null;
  }
}



/*
* 19.08.20
* 구독하기 / 구독 취소
* 출력 값
  true 업데이트 성공, false 업데이트 실패. 실패할 경우는 아마 헤더가 만료될 때 혹은
  값이 잘못됐을 때 뿐입니다.
  해당 페이지와 우측 구독 중 페이지, 작가 노트 보는 페이지의 우측 상단 작가 구독 버
  튼 등 모두 위 api로 작업하면 될 것 같습니다.

  목록에 바로 반영 되려면 새로고침이 되야하는데 스크롤 위치가 어떨지 몰라서.. 목록
  을 새로고침 하지않고 버튼을 on / off 로 하면 될 것 같습니다.
  구독 중 페이지에서 구독 취소를 해도 바로 목록에서 사라지는 것이 아닌, 버튼만 on /
  off 되게 하고 다시 클릭하면 위 api로 sub에 1값 전달. 그러고 다시 나갔다가 들어가면

  구독 목록이 최신화 되서 목록에서 아예 안보임.
  전체 페이지는 구독 취소해도 해당 목록이 남아있어야 하는게 정상이라 그냥 버튼만
  on/off 되면 될 것 같습니다.
*
*/

Future<String> updateSubState(BuildContext context, String writerEmail, String sub) async {
  String dataURL = 'http://icomerict.cafe24.com/untitled_note/json/update_sub_state.php';
  final response = await http.post(
    dataURL,
    headers: {'access_token': Mnote.accessToken},
    body: {
      'writer_email': writerEmail,
      'sub': sub
    },
  );

  final jsonResponse = json.decode(response.body);
  bool isTokenOk = await Mnote.tokenErrorCheck(jsonResponse.toString());

  if (response.statusCode == 200 || isTokenOk) {
    return jsonResponse['result'];
  } else {
    print('updateBookShowState() fail');
    return 'fail';
  }
}
