import 'package:flutter/material.dart';
import 'package:mnote_app/service/purchase_service.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'dart:async';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';

class PremiumScreen extends StatefulWidget {
  @override
  _PremiumScreenState createState() => new _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {

  @override
  void initState() {
    Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
    subscription = purchaseUpdated.listen((purchaseDetailsList) {
      print('test init subscript : : : ' + subscription.isPaused.toString());
      orPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      subscription.cancel();
    }, onError: (error) {
      // handle error here.
      print('test init error : : : ' + error);
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: FlatButton(
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.only(left: 30),
              child: Image.asset('images/icons/00_top_back.png')),
          title: Text(
            '프리미엄 구매',
            style: Mnote.appBarCenterTitle,
          ),
          centerTitle: true,
          elevation: 0.5,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
// [1]
                  Column(
                    children: <Widget>[
                      Text(
                        'PC버전 이용',
                        style: Mnote.textFiledLabel,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '프리미엄 구매 이용자만 PC버전 이용 가능',
                      ),
                    ],
                  ),
// [2]
                  Column(
                    children: <Widget>[
                      Text(
                        '글꼴 설정',
                        style: Mnote.textFiledLabel,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '실제 출판용 글꼴을 이용할 수 있습니다',
                      ),
                    ],
                  ),
// [3]
                  Column(
                    children: <Widget>[
                      Text(
                        '야간 모드',
                        style: Mnote.textFiledLabel,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '야간 모드를 통해 어두운 환경에서 이용 가능',
                      ),
                    ],
                  ),
// [4]
                  Column(
                    children: <Widget>[
                      Text(
                        '무제한 나만의 책',
                        style: Mnote.textFiledLabel,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '책의 개수 제한 없이 작성할 수 있습니다',
                      ),
                    ],
                  ),
// [5]
                  Column(
                    children: <Widget>[
                      Text(
                        '다운로드',
                        style: Mnote.textFiledLabel,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '작성한 글을 txt파일 뿐 아닌 책 원고, PDF 등',
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '다양한 형태로 다운로드 받으실 수 있습니다.',
                      ),
                    ],
                  ),
// [6]
                  Column(
                    children: <Widget>[
                      Text(
                        '15,000 ₩',
                        style: TextStyle(color: Mnote.orange, fontSize: 24),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  )
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                getHistoryInApp();
              },
              color: Mnote.orange,
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              child: Text(
                '구매하기',
                style: Mnote.screenBottomBtnWText,
              ),
            )
          ],
        ));
  }
}
