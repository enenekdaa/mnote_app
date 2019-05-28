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

  List<String> noteItems = ['note 1' , 'note 2' , 'note 3'];



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
                      padding: EdgeInsets.all(20),
                      child: Text("저장할 노트를 선택하세요"),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: noteItems.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(padding : EdgeInsets.only(left: 20 , right: 20),
                              width : maxSize,
                              child: FlatButton(
                                child: Text(noteItems[index]),
                                onPressed: ()=>MyNavigator.goToNote(context),
                                color: Colors.grey,
                            ),
                            );

                          }),
                    ),
                    Container(
                      width: maxSize,
                      padding: EdgeInsets.only(right: 20 , left: 20),
                      child: FlatButton(color: Colors.grey, onPressed: () => {}, child: Text(' + 새노트 작성')),
                    ),
                    MaterialButton(
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.all(20),
                      color: Colors.grey,
                      child: Text('취소' , style: TextStyle(fontSize: 18, color: Colors.white),),
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