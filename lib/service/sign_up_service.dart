import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mnote_app/model/sign_model.dart';

String resultURL;


// url = http://icomerict.cafe24.com/untitled_note/sign_in/sign_up.php
// result ==.. true = 성공 / false = 실패
//access_token / refresh_token 받음

Future<SignModel> getSignUp(String dataURL) async {
  resultURL = dataURL;
  final response = await http.post(dataURL ,
      body: {'email' : 'test@test.com' , 'password' : '1234' , 'password_confirm' : '1234' , 'writer_name' : 'test' , 'intro' : 'introtest' }
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);

    SignModel sign_up_model = new SignModel.fromJson(jsonResponse);

    //print(post.first.dial_00);

    return sign_up_model;

  } else {
    throw Exception('Failed to load post');
  }

}