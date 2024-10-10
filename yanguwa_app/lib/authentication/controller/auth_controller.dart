import 'package:yanguwa_app/authentication/service/auth_service.dart';
import 'package:yanguwa_app/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final AuthenticationService authenticationService = AuthenticationService();

  final RxBool isLoading = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController = TextEditingController();

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      await authenticationService.register(
        name: name,
        email: email,
        password: password,
      );
      Get.snackbar(
        'Success',
        'User registered successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAll(() => const HomeView());
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      await authenticationService.login(
        email: email,
        password: password,
      );

      Get.offAll(() => const HomeView());
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}