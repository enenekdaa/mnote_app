import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/utils/mnote.dart';

class FindPasswordDialog extends StatefulWidget {
  @override
  _FindPasswordDialogState createState() => _FindPasswordDialogState();
}

class _FindPasswordDialogState extends State<FindPasswordDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final maxSize = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
            width: maxSize / 1.4,
            height: maxSize / 1.6,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: maxSize / 1.6 / 10),
                  child: Text('임시 비밀번호 받기'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: maxSize / 1.6 / 10, bottom: maxSize / 1.6 / 10),
                  child: Text('회원 가입 시 이용하신 이메일 주소를 입력해 주세요. 해당 메일로 임시 비밀번호가 발송됩니다.'),
                ),
                Expanded(
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Mnote.validateEmail,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide:
                          BorderSide(width: 0.2, color: Colors.black38)),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('취소'),
                    ),
                    FlatButton(
                      onPressed: () {
                        if(Mnote.validateEmail(emailController.text) != null){
                          Fluttertoast.showToast(msg: '이메일 형식을 확인해 주세요.');
                          return;
                        }
                      },
                      child: Text('확인'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
