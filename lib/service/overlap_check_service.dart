import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/overlap_check_model.dart';

String resultURL;
// url http://icomerict.cafe24.com/untitled_note/sign_in/email_check.php        : email 체크
// url http://icomerict.cafe24.com/untitled_note/sign_in/writer_name_check.php    : 필명 체크
// result ==.. true = 중복안됨 , false = 중복됨

Future<OverlapCheckModel> getSignUp(String dataURL) async {
  resultURL = dataURL;
  final response = await http.post(dataURL ,
      body: {'email' : 'test@test.com'}
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    OverlapCheckModel overlap_check_model = new OverlapCheckModel.fromJson(jsonResponse);

    //print(post.first.dial_00);

    return overlap_check_model;

  } else {
    throw Exception('Failed to load post');
  }

}