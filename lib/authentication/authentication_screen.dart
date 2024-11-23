import 'package:flutter/material.dart';
import 'package:yanguwa_app/authentication/authentication_text_form_field.dart';
import 'package:yanguwa_app/wave.dart';
import 'package:yanguwa_app/authentication/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:yanguwa_app/screens/home_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool register = true;

  final AuthenticationController authenticationController = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Wave(),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    if (register == true)
                      AuthenticationTextFormField(
                        key: const Key('name'),
                        icon: Icons.vpn_key,
                        label: 'Full Name',
                        textEditingController: authenticationController.nameController,
                      ),
                    AuthenticationTextFormField(
                      key: const Key('email'),
                      icon: Icons.email,
                      label: 'Email',
                      textEditingController: authenticationController.emailController,
                    ),
                    AuthenticationTextFormField(
                      key: const Key('password'),
                      icon: Icons.vpn_key,
                      label: 'Password',
                      textEditingController: authenticationController.passwordController,
                    ),
                    if (register == true)
                      AuthenticationTextFormField(
                        key: const Key('password_confirmation'),
                        icon: Icons.password,
                        label: 'Password Confirmation',
                        textEditingController: authenticationController.passwordConfirmationController,
                      ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () async {
                        await _authenticate();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen(userName: authenticationController.userName.value)),
                        );
                      },
                      child: Text(
                        register == true ? 'Create Account' : 'Login',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        setState(() => register = !register);
                        _formKey.currentState?.reset();
                      },
                      child: Text(
                        register == true ? 'Already have an account? Login instead' : 'Create an account if you do not have one',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    if (_formKey.currentState!.validate() == false) return;

    // If registering, validate password confirmation
    if (register) {
      if (authenticationController.passwordController.text != authenticationController.passwordConfirmationController.text) {
        // Show error if passwords do not match
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Passwords do not match',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: Colors.red,
          ),
        );
        return; // Prevent registration if passwords don't match
      }

      // Call the registerUser method if passwords match
      await authenticationController.registerUser(
        name: authenticationController.nameController.text,
        email: authenticationController.emailController.text,
        password: authenticationController.passwordController.text,
      );
    } else {
      // Call the loginUser method if not registering
      await authenticationController.loginUser(
        email: authenticationController.emailController.text,
        password: authenticationController.passwordController.text,
      );
    }

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Success',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}