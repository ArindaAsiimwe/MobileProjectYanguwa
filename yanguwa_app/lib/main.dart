import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yanguwa_app/authentication/authentication_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 14, 122, 194))
          .copyWith(error: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const AuthenticationScreen(),
    );
  }
}