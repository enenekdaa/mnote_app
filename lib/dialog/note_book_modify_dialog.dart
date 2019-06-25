import 'package:flutter/material.dart';
import 'package:mnote_app/page/note_book_edit_screen.dart';
import 'package:mnote_app/page/note_book_view_screen.dart';
import 'package:mnote_app/utils/my_navigator.dart';
import 'note_book_remove_dialog.dart';

class NoteBookModifyDialog extends StatefulWidget {
  final String bookNo;

  NoteBookModifyDialog({this.bookNo});

  @override
  _NoteBookModifyDialogState createState() => _NoteBookModifyDialogState();
}

class _NoteBookModifyDialogState extends State<NoteBookModifyDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  void _showRemoveNoteBookDialog() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => NoteBookRemoveDialog(),
    );
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final maxSize = MediaQuery
        .of(context)
        .size
        .width;
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
              padding: EdgeInsets.only(
                  top: 30, bottom: 10, left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                      elevation: 0,
                      height: 50,
                      minWidth: double.infinity,
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => NoteBookEditScreen(bookNo: widget.bookNo)));
                      },
                      child: Text('표지 및 제목 설정')),
                  SizedBox(height: 10,),
                  MaterialButton(
                      elevation: 0,
                      height: 50,
                      minWidth: double.infinity,
                      color: Colors.black,
                      textColor: Colors.white,
                      onPressed: () => _showRemoveNoteBookDialog(),
                      child: Text('노트 삭제')),
                  SizedBox(height: 10,),
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    elevation: 0,
                    color: Colors.white,
                    minWidth: double.infinity,
                    child: Text(
                      '취소',
                    ),
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
