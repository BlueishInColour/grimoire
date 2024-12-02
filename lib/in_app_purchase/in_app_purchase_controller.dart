import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../main_controller.dart';

class InAppPurchaseUtils extends MainController {

  List<ProductDetails> _products = [];
  List<ProductDetails> get products => _products;
  set products(v){_products = v; notifyListeners();}

  // Private constructor
  InAppPurchaseUtils._();
  // Create a private variable
  final InAppPurchase _iap = InAppPurchase.instance;


  late StreamSubscription<List<PurchaseDetails>> _purchasesSubscription;

  InAppPurchaseUtils(

      ){
    _iap.isAvailable();
    initialize();
  }

  @override
dispose(){
    super.dispose();
  _purchasesSubscription.cancel();

}

  Future<void> initialize() async {
    if (!(await _iap.isAvailable())) return;

    ///catch all purchase updates
    _purchasesSubscription = InAppPurchase.instance.purchaseStream.listen((
        List<PurchaseDetails> purchaseDetailsList) {
      handlePurchaseUpdates(purchaseDetailsList);
    },
      onDone: () {
        _purchasesSubscription.cancel();
      },
      onError: (error) {},
    );
  }


  handlePurchaseUpdates(purchaseDetailsList) async {
    for (int index = 0; index < purchaseDetailsList.length; index++) {
      var purchaseStatus = purchaseDetailsList[index].status;
      switch (purchaseDetailsList[index].status) {
        case PurchaseStatus.pending:
          print(' purchase is in pending ');
          continue;
        case PurchaseStatus.error:
          print(' purchase error ');
          break;
        case PurchaseStatus.canceled:
          print(' purchase cancel ');
          break;
        case PurchaseStatus.purchased:
          print(' purchased ');
          break;
        case PurchaseStatus.restored:
          print(' purchase restore ');
          break;
      }

      if (purchaseDetailsList[index].pendingCompletePurchase) {
        await _iap.completePurchase(purchaseDetailsList[index]).then((value) {
          if (purchaseStatus == PurchaseStatus.purchased) {
            //on purchase success you can call your logic and your API here.
          }
        });
      }
    }
  }

  Future<void> buyConsumableProduct(String productId) async {
    debugPrint("trying ti bu");

    try {

      Set<String> _kIds = <String>{productId };
      final ProductDetailsResponse response =
      await _iap.queryProductDetails(_kIds);
      // if (response.notFoundIDs.isNotEmpty) {
      //   // Handle the error.
      //   print("####### found no products");
      // }
      // products = response.productDetails;

      final PurchaseParam purchaseParam =
      PurchaseParam(productDetails:ProductDetails(id: "grimoire_sliver", title: "Grimoire Sliver", description: "Unlock download section ", price: "1200.00", rawPrice: 1200.00, currencyCode: "NGN"));
      await _iap.buyConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      // Handle purchase error
      print('Failed to buy plan: $e');
    }
  }

  restorePurchases() async {
    try {
      await _iap.restorePurchases();
    } catch (error) {
      //you can handle error if restore purchase fails
    }
  }
  Stream<bool> isStoreAvailable()async*
  {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (available) {
      // The store cannot be reached or accessed. Update the UI accordingly.
      yield true;
    }
    else yield false;
  }
}