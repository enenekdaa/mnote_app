import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnote_app/service/books_my_service.dart';

class NoteBookRemoveDialog extends StatefulWidget {
  final String bookNo;

  NoteBookRemoveDialog({this.bookNo});

  @override
  _NoteBookRemoveDialogState createState() => _NoteBookRemoveDialogState();
}

class _NoteBookRemoveDialogState extends State<NoteBookRemoveDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  void _deleteBook()async{
    if ( await deleteBook(widget.bookNo) == ''){
      Fluttertoast.showToast(msg: '성공적으로 삭제되었습니다.');
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: '삭제에 실패하였습니다.');
      Navigator.pop(context);
    }
  }

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
                  Text('노트를 삭제하시겠습니까?'),
                  Text('삭제된 노트는 복구할 수 없습니다.'),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          _deleteBook();
                        },
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
