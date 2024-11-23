import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
<<<<<<< HEAD:yanguwa_app/lib/main.dart
import 'package:yanguwa_app/constants.dart';
import 'authentication/authentication_screen.dart';
=======
import 'package:yanguwa_app/screens/booking.dart';
>>>>>>> 038dc0c464be13e46b5ff3dd1fa5f5bfcc013b1f:lib/main.dart

void main() async {
  await _setup();
  runApp(const MyApp());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A237E))
            .copyWith(error: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const AuthenticationScreen(),
    );
  }
}
