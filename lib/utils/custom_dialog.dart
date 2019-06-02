import 'package:flutter/material.dart';

import 'm_navigator.dart';

class MainDialog extends StatefulWidget {
  @override
  _MainDialogState createState() => _MainDialogState();
}

class _MainDialogState extends State<MainDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  List<String> noteItems = ['무제_1', '무제_2', '무제_3'];

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
            height: maxSize / 1.2,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("저장할 노트를 선택하세요"),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: noteItems.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: maxSize,
                            height: 50,
                            padding: EdgeInsets.only(bottom: 6, left: 10, right: 10),
                            child: MaterialButton(
                              child: Text(noteItems[index]),
                              onPressed: () => MyNavigator.goToNote(context),
                              elevation: 0,
                              color: Colors.black,
                              textColor: Colors.white,
                            ),
                          );
                        }),
                  ),
                  Container(
                    width: maxSize,
                    height: 50,
                    padding: EdgeInsets.only(top:6, bottom: 6, left: 10, right: 10),
                    child: MaterialButton(
                        elevation: 0,
                        color: Colors.black,
                        textColor: Colors.white,
                        onPressed: () => {},
                        child: Text(' + 새노트 작성')),
                  ),
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    elevation: 0,
                    color: Colors.white,
                    minWidth: maxSize,
                    child: Text('취소',),
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
