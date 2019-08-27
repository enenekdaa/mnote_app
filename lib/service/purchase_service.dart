import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mnote_app/utils/mnote.dart';

final String testID = 'android.test.purchased';

// inapp purchase
StreamSubscription<List<PurchaseDetails>> subscription;
bool available = true;

/// The In App Purchase plugin
InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

/// Products for sale
List<ProductDetails> products = [];
List<PurchaseDetails> purchases = [];

Future<bool> verifyPurchase(PurchaseDetails purchaseDetails) {
  // IMPORTANT!! Always verify a purchase before delivering the product.
  // For the purpose of an example, we directly return true.
  print('inapp verifyPurchase' + purchaseDetails.verificationData.toString());
  return Future<bool>.value(true);
}

// ignore: missing_return
Future<bool> getHistoryInApp() async {
  available = await _iap.isAvailable();

  if(available) {
    print('test inapp History');
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();
    print(response.toString());
    if(response.error != null) {
      // error
      print('error');
      return null;
    }
    for (PurchaseDetails purchase in response.pastPurchases) {
      verifyPurchase(purchase);
      if (Platform.isIOS) {
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
    }

    purchases = response.pastPurchases;

    if (purchases.length == 0) {
      print('inapp purchase 0');
      return false; // 미구독 상태
    }else {
      print('inapp purchase 구독중');
      return true; // 구독 상태
    }
  }else {
    print('inapp purchase 연결실패');
    return false;
  }
}


Future startInApp() async {
  print('startInApp');
  // 판매 제품 조회
  ProductDetailsResponse response = await _iap.queryProductDetails(Mnote.kIds);
  print(response.toString());
  if (response.notFoundIDs.isEmpty == false) {
    print('판매 제품이 로드되지 않았습니다.');
    return false;
  }
  products = response.productDetails;
  // 구매 연동
  ProductDetails pp = products.elementAt(0);
  print(pp.toString());
  PurchaseParam purchaseParam = PurchaseParam(productDetails: pp);
  _iap.buyNonConsumable(purchaseParam: purchaseParam).then((result){
    if (result.toString() == 'true'){
      Mnote.isInApp = true;
      return true;
    }else{
      return false;
    }
  });


}

void orPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
  purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    if (purchaseDetails.status == PurchaseStatus.pending) {
      print('inapp update pending : : : ' + PurchaseStatus.pending.toString());
    } else {
      if (purchaseDetails.status == PurchaseStatus.error) {
        print('test inapp update error : : : ' + PurchaseStatus.error.toString());
      }else if (purchaseDetails.status == PurchaseStatus.purchased) {
        bool valid = await verifyPurchase(purchaseDetails);
        print('test inapp update purchased status : : : ' + valid.toString());
      }
    }
  });
}

void setInitSubscription() {
  Stream purchaseUpdated = InAppPurchaseConnection.instance.purchaseUpdatedStream;
  subscription = purchaseUpdated.listen((purchaseDetailsList) {
    orPurchaseUpdated(purchaseDetailsList);
  }, onDone: () {
    subscription.cancel();
  }, onError: (error) {
    // handle error here.
  });
}

void disposeSubscription() {
  subscription.cancel();
}

