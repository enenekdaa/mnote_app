import 'package:flutter/material.dart';

import 'package:mnote_app/utils/my_navigator.dart';

class ReportDialog extends StatefulWidget {
  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

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
                  child: Text('글감 제보하기'),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: maxSize / 1.6 / 10, bottom: maxSize / 1.6 / 10),
                  child: Text('함께 쓰고싶은 글감을 제보해주세요.'),
                ),
                Expanded(
                  child: TextField(
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
                      onPressed: () => Navigator.pop(context),
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
