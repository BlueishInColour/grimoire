// import 'dart:async';
//
// import 'package:grimoire/in_app_purchase/purchasable_product.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
//
// import '../main_controller.dart';
//
// class DashPurchases extends MainController {
//   late StreamSubscription<List<PurchaseDetails>> _subscription;
//   final iapConnection = IAPConnection.instance;
//
//   DashPurchases() {
//     final purchaseUpdated =
//         iapConnection.purchaseStream;
//     _subscription = purchaseUpdated.listen(
//       _onPurchaseUpdate,
//       onDone: _updateStreamOnDone,
//       onError: _updateStreamOnError,
//     );
//   }
//
//   @override
//   void dispose() {
//     _subscription.cancel();
//     super.dispose();
//   }
//
//   Future<void> buy(PurchasableProduct product) async {
//     // omitted
//   }
//
//   void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
//     // Handle purchases here
//   }
//
//   void _updateStreamOnDone() {
//     _subscription.cancel();
//   }
//
//   void _updateStreamOnError(dynamic error) {
//     //Handle error here
//   }
//
//   Future<void> loadPurchases() async {
//     final available = await iapConnection.isAvailable();
//     if (!available) {
//       storeState = StoreState.notAvailable;
//       notifyListeners();
//       return;
//     }
//   }
//
// }
