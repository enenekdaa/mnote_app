import 'package:flutter/material.dart';

import 'package:mnote_app/utils/my_navigator.dart';

class NoteChapterRemoveDialog extends StatefulWidget {
  @override
  _NoteChapterRemoveDialogState createState() => _NoteChapterRemoveDialogState();
}

class _NoteChapterRemoveDialogState extends State<NoteChapterRemoveDialog>
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
            width: maxSize / 1.3,
            //height: maxSize / 1.2,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            child: Container(
              padding: EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('해당 글을 삭제하시겠습니까?'),
                  Text('삭제된 글은 복구할 수 없습니다.'),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        elevation: 0,
                        color: Colors.white,
                        child: Text(
                          '확인',
                        ),
                      ),
                      MaterialButton(
                        onPressed: () => Navigator.pop(context),
                        elevation: 0,
                        color: Colors.white,
                        child: Text(
                          '취소',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
