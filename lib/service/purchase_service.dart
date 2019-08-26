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
      verifyPurchase(purchase);
      if (Platform.isIOS) {
        InAppPurchaseConnection.instance.completePurchase(purchase);

      }
    }

    purchases = response.pastPurchases;
    print('test inapp History _purchases ');

    if (purchases.length == 0) {
      startInApp();
      print('test inapp purchase null');
      Mnote.isInApp = false;
    }else {
      print('test inapp History _purchases ' + purchases.elementAt(0).status.toString());
      purchases.forEach((PurchaseDetails pd){
        print('pd.billingClientPurchase.orderId :: ' + pd.billingClientPurchase.orderId);
        print('pd.billingClientPurchase.packageName :: ' + pd.billingClientPurchase.packageName);
        print('pd.billingClientPurchase.purchaseTime :: ' + pd.billingClientPurchase.purchaseTime.toString());
        print('pd.billingClientPurchase.purchaseToken :: ' + pd.billingClientPurchase.purchaseToken);
        print('pd.billingClientPurchase.signature :: ' + pd.billingClientPurchase.signature);
        print('pd.billingClientPurchase.sku :: ' + pd.billingClientPurchase.sku);
        print('pd.productID :: ' + pd.productID);
        print('pd.purchaseID :: ' + pd.purchaseID);
        print('pd.verificationData :: ' + pd.verificationData.toString());
        print(pd.status);
        print(pd.transactionDate);
        // startInApp();
      });
    }

  }else {
    //연결 실패 ...
    print('test inapp purchase 연결실패');
  }
}


Future startInApp() async {
  // 판매 제품 조회
  ProductDetailsResponse response = await _iap.queryProductDetails(Mnote.kIds);
  if (response.notFoundIDs.isEmpty == false) {
    print('판매 제품이 로드되지 않았습니다.');
  }
  products = response.productDetails;

  // 구매 연동
  ProductDetails pp = products.elementAt(0);
  PurchaseParam purchaseParam = PurchaseParam(productDetails: pp);
  _iap.buyNonConsumable(purchaseParam: purchaseParam).then((result){
    print('구매결과');
    print(result);
  });
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
        bool valid = await verifyPurchase(purchaseDetails);
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

