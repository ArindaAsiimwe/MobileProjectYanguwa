import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../constants.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<bool> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(
        300000, // Amount in USD cents, e.g., 100 = $1
        "Ugx",
      );
      if (paymentIntentClientSecret == null) return false;

      // Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Yanguwa App",
        ),
      );

      // Present the payment sheet to the user
      await _processPayment();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error during payment: $e');
      }
      return false;
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.data != null) {
        if (kDebugMode) {
          print('Payment Intent Response: ${response.data}');
        }
        return response.data["client_secret"];
      }

      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error creating Payment Intent: $e');
      }
      return null;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      if (kDebugMode) {
        print('Error processing payment: $e');
      }
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
