import 'package:flutter/material.dart';

import 'm_navigator.dart';

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
            padding: EdgeInsets.all(10),
            width: maxSize / 1.4,
            height: maxSize / 1.4,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('글감 제보하기'),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('글감 제보하기'),
                ),
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide:
                          BorderSide(width: 0.2, color: Colors.black38)),
                      hintText: '글감..',
                      hintStyle: TextStyle(color: Colors.black12),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(child: Text('취소'),),
                    FlatButton(child: Text('보내기'),),
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
