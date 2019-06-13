import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';

class OrangeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
        height: 1,
        width: 30,
        margin: EdgeInsets.only(bottom: 15),
        color: Mnote.orange,
      );
  }
}

class GrayDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Container(
        height: 2.5,
        margin: EdgeInsets.only(bottom: 15),
        color: Colors.black12,
      );
  }
}
