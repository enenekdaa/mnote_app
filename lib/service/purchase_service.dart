import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mnote_app/utils/mnote.dart';

final String testID = 'android.test.purchased';

// inapp purchase

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


  print('test inapp verifyPurchase' + purchaseDetails.verificationData.toString());
  return Future<bool>.value(true);
}

// ignore: missing_return
Future<List<PurchaseDetails>> getHistoryInApp() async {
  available = await _iap.isAvailable();

  if(available) {
    print('test inapp History');
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
    print('test inapp History _purchases ');

    if (_purchases.length == 0) {
      //  startInApp();
      print('test inapp purchase null');
      Mnote.isInApp = true;
    }else {
      print('test inapp History _purchases ' + _purchases.elementAt(0).status.toString());
    }

  }else {
    //연결 실패 ...
  }
}


Future startInApp() async {
  print('test isinApp : : :  ' + Mnote.isInApp.toString());
  if(!Mnote.isInApp) {
    print('tes isInApp : : : ' + Mnote.isInApp.toString());
    return;
  }
  Set<String> ids = <String>[testID].toSet();
  ProductDetailsResponse response = await _iap.queryProductDetails(ids.toSet());
  if (!response.notFoundIDs.isEmpty) {
    //error
  }
  _products = response.productDetails;

  ProductDetails pp = response.productDetails.elementAt(0);
  PurchaseParam purchaseParam =  PurchaseParam(productDetails: pp);
  _iap.buyNonConsumable(purchaseParam: purchaseParam);
  print('test inapp start purchase : : : ');
}

void orPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
  purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      // pending 구매전 ?
      print('test inapp update pending : : : ' + PurchaseStatus.pending.toString());
      Mnote.isInApp = true;
    } else {
      // 후 ?
      if (purchaseDetails.status == PurchaseStatus.error) {
        print('test inapp update error : : : ' + PurchaseStatus.error.toString());
        Mnote.isInApp = true;
        //error
      }else if (purchaseDetails.status == PurchaseStatus.purchased) {
        bool valid = await _verifyPurchase(purchaseDetails);
        print('test inapp update purchased status : : : ' + valid.toString());
        Mnote.isInApp = false;
        if(valid) {

        }else {

        }
      }
    }
  });
}

void setInitSubscription() {
  Stream purchaseUpdated =
      InAppPurchaseConnection.instance.purchaseUpdatedStream;
  _subscription = purchaseUpdated.listen((purchaseDetailsList) {
    orPurchaseUpdated(purchaseDetailsList);
  }, onDone: () {
    _subscription.cancel();
  }, onError: (error) {
    // handle error here.
  });
}

void disposeSubscription() {
  _subscription.cancel();
}

