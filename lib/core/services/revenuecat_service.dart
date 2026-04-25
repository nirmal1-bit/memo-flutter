// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

// class RevenueService {
//   static Future<void> fetchOfferings() async {
//     try {
//       final offerings = await Purchases.getOfferings();

//       if (offerings.current != null) {
//         final packages = offerings.current!.availablePackages;

//         print("Packages found: ${packages.length}");

//         for (var package in packages) {
//           print(package.identifier);
//           print(package.storeProduct.title);
//           print(package.storeProduct.priceString);
//         }
//       } else {
//         print("No offerings found");
//       }
//     } catch (e) {
//       print("Error fetching offerings: $e");
//     }
//   }

//   static Future<void> presentPaywall() async {
//     final paywallResult = await RevenueCatUI.presentPaywall();
//     print("Paywall result: $paywallResult");

//     switch (paywallResult) {
//       case PaywallResult.purchased:
//       case PaywallResult.restored:
//         print("✅ User has premium access");
//         break;

//       case PaywallResult.cancelled:
//         print("❌ User cancelled");
//         break;

//       case PaywallResult.error:
//         print("⚠️ Error occurred");
//         break;

//       case PaywallResult.notPresented:
//         print("ℹ️ Paywall not shown");
//         break;
//     }
//   }

//   static Future<bool> checkSubscriptionStatus() async {
//     try {
//       final purchaserInfo = await Purchases.getCustomerInfo();
//       print("purchaserInfo: $purchaserInfo");
//       final isPro =
//           purchaserInfo.entitlements.all["InkList Pro"]?.isActive ?? false;

//       if (isPro) {
//         print("✅ User has active subscription");

//         return isPro;
//       } else {
//         print("❌ User does NOT have active subscription");
//         return false;
//       }
//     } catch (e) {
//       print("Error checking subscription status: $e");
//       return false;
//     }
//   }
// }
