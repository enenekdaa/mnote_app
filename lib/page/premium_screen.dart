
import 'package:flutter/material.dart';
import 'package:mnote_app/utils/mnote.dart';
import 'dart:async';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';


final String testID = 'android.test.purchased';


class PremiumScreen extends StatefulWidget {
  @override
  _PremiumScreenState createState() => new _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {

  StreamSubscription<List<PurchaseDetails>> _subscription;
  bool available = true;
  /// The In App Purchase plugin
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;
  /// Products for sale
  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
// IMPORTANT!! Always verify a purchase before delivering the product.
// For the purpose of an example, we directly return true.


    print('test puirchase detail' + purchaseDetails.status.toString());
    return Future<bool>.value(true);
  }

  Future<List<PurchaseDetails>> getHistoryInApp() async {
    available = await _iap.isAvailable();

    if(available) {
      print('test histoy connect : : : ');
      QueryPurchaseDetailsResponse response =
      await _iap.queryPastPurchases();
      if(response.error != null) {
// error
        return null;
      }
      for (PurchaseDetails purchase in response.pastPurchases) {
        _verifyPurchase(purchase);
        if (Platform.isIOS) {
          InAppPurchaseConnection.instance.completePurchase(purchase);

        }
      }
      _purchases = response.pastPurchases;

      if (_purchases.length == 0) {
        print('test start : : : ');
        startInApp();
      }else {
        print('test no start : : : ');
      }

    }else {
      print('test cancle.. : : : ');
//연결 실패 ...
    }
  }


  Future startInApp() async {
    Set<String> ids = <String>[testID].toSet();
    ProductDetailsResponse response = await _iap.queryProductDetails(ids.toSet());
    if (!response.notFoundIDs.isEmpty) {
//error
    }
    _products = response.productDetails;

    ProductDetails pp = response.productDetails.elementAt(0);
    PurchaseParam purchaseParam = PurchaseParam(productDetails: pp);
    _iap.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void orPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        print('test pending : : : ');
// pending 구매전 ?
      } else {
        print('test no pending : : : ');
// 후 ?
        if (purchaseDetails.status == PurchaseStatus.error) {
          print('test error : : : ');
//error
        }else if (purchaseDetails.status == PurchaseStatus.purchased) {
          bool valid = await _verifyPurchase(purchaseDetails);
          if(valid) {
            print('test purchased t: : : ' + valid.toString());

          }else {

            print('test purchased f : : : ' + valid.toString());
          }
        }
      }
    });

  }

  @override
  void initState() {
    Stream purchaseUpdated =
        InAppPurchaseConnection.instance.purchaseUpdatedStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      print('test init subscript : : : ' + _subscription.isPaused.toString());
      orPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
// handle error here.
    print('test init error : : : ' + error);

    });
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
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
                      Text('PC버전 이용', style: Mnote.textFiledLabel,),
                      SizedBox(height: 10,),
                      Text('프리미엄 구매 이용자만 PC버전 이용 가능',),
                    ],
                  ),
// [2]
                  Column(
                    children: <Widget>[
                      Text('글꼴 설정', style: Mnote.textFiledLabel,),
                      SizedBox(height: 10,),
                      Text('실제 출판용 글꼴을 이용할 수 있습니다',),
                    ],
                  ),
// [3]
                  Column(
                    children: <Widget>[
                      Text('야간 모드', style: Mnote.textFiledLabel,),
                      SizedBox(height: 10,),
                      Text('야간 모드를 통해 어두운 환경에서 이용 가능',),
                    ],
                  ),
// [4]
                  Column(
                    children: <Widget>[
                      Text('무제한 나만의 책', style: Mnote.textFiledLabel,),
                      SizedBox(height: 10,),
                      Text('책의 개수 제한 없이 작성할 수 있습니다',),
                    ],
                  ),
// [5]
                  Column(
                    children: <Widget>[
                      Text('다운로드', style: Mnote.textFiledLabel,),
                      SizedBox(height: 10,),
                      Text('작성한 글을 txt파일 뿐 아닌 책 원고, PDF 등',),
                      SizedBox(height: 5,),
                      Text('다양한 형태로 다운로드 받으실 수 있습니다.',),
                    ],
                  ),
// [6]
                  Column(
                    children: <Widget>[
                      Text('15,000 ₩', style: TextStyle(color: Mnote.orange, fontSize: 24),),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  )
                ],
              ),
            ),
            MaterialButton(
              onPressed: () => {
                print('test click : : : '),
                getHistoryInApp()
              },
              color: Mnote.orange,
              minWidth: MediaQuery.of(context).size.width,
              height: 60,
              child: Text('구매하기', style: Mnote.screenBottomBtnWText,),
            )
          ],
        ));
  }
}
