import 'package:e_commerce_app/Constants/comman_tost.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void handlePaymentSuccess(PaymentSuccessResponse response) {
  commonTost("Payment Success");
}

void handlePaymentError(PaymentFailureResponse response) {
 commonTost("Payment Failure");
}

void handleExternalWallet(ExternalWalletResponse response) {
   commonTost("External Wallet");
}