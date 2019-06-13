import 'package:flutter/material.dart';

import 'package:mnote_app/utils/my_navigator.dart';

class NoteCoverDialog extends StatefulWidget {
  @override
  _NoteCoverDialogState createState() => _NoteCoverDialogState();
}

class _NoteCoverDialogState extends State<NoteCoverDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  List<String> coverItems = ['', '', '','', '', '','', '', ''];

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
    final maxWdithSize = MediaQuery.of(context).size.width;
    final maxHeightSize = MediaQuery.of(context).size.height;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            width: maxWdithSize / 1.3,
            height: maxHeightSize / 1.85,
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 0.75,
                        children: List.generate(coverItems.length, (index) {
                          return Container(
                            padding: EdgeInsets.all(5),
                            child: MaterialButton(
                              child: Text(coverItems[index]),
                              onPressed: () => {},
                              elevation: 0,
                              color: Colors.black,
                              textColor: Colors.white,
                            ),
                          );
                        })),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () => Navigator.pop(context),
                        elevation: 0,
                        color: Colors.white,
                        child: Text('취소',),
                      ),
                      MaterialButton(
                        onPressed: () => Navigator.pop(context),
                        elevation: 0,
                        color: Colors.white,
                        child: Text('선택완료',),
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
