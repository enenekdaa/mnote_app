import 'package:flutter/material.dart';

import 'package:mnote_app/utils/my_navigator.dart';

class FontDialog extends StatefulWidget {
  @override
  _FontDialogState createState() => _FontDialogState();
}

class _FontDialogState extends State<FontDialog>
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
            // padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
            width: maxSize / 1.4,
            height: maxSize / 2,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  onPressed: ()=>{
                    Navigator.pop(context, 'MNote')
                  },
                  child: Text('아리따부리'),
                ),
                MaterialButton(
                  onPressed: ()=>{
                    Navigator.pop(context, 'MNoteNanum')
                  },
                  child: Text(
                      '나눔고딕'
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
