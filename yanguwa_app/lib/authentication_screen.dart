import 'package:flutter/material.dart';
import 'package:yanguwa_app/authentication_text_form_field.dart';
import 'package:yanguwa_app/wave.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  bool register = true;

  Future<void> _authenticate() async {
    if (_formKey.currentState!.validate() == false) return;

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
                    AuthenticationTextFormField(
                      key: const Key('email'),
                      icon: Icons.email,
                      label: 'Email',
                      textEditingController: emailController,
                    ),
                    AuthenticationTextFormField(
                      key: const Key('password'),
                      icon: Icons.vpn_key,
                      label: 'Password',
                      textEditingController: passwordController,
                    ),
                    if (register == true)
                    AuthenticationTextFormField(
                      key: const Key('password_confirmation'),
                      icon: Icons.password,
                      label: 'Password Confirmation',
                      textEditingController: passwordConfirmationController,
                      confirmationController: passwordController,
                    ),
                    const SizedBox(height: 25,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: _authenticate,
                      child: Text(register == true ? 'Create Account' : 'Login',
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
      )
    );
  }
}