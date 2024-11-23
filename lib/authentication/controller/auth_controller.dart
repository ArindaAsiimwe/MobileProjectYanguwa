import 'package:yanguwa_app/authentication/service/auth_service.dart';
import 'package:yanguwa_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  final AuthenticationService authenticationService = AuthenticationService();
  final RxBool isLoading = false.obs;
  final RxString userName = ''.obs; // Add this line

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
      final userModel = await authenticationService.register(
        name: name,
        email: email,
        password: password,
      );
      userName.value = userModel.user.name; // Store the user's name
      Get.snackbar(
        'Success',
        'User registered successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      Get.offAll(() => HomeScreen(userName: userName.value)); // Pass the user's name
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
      final userModel = await authenticationService.login(
        email: email,
        password: password,
      );
      userName.value = userModel.user.name; // Store the user's name
      Get.offAll(() => HomeScreen(userName: userName.value)); // Pass the user's name
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}