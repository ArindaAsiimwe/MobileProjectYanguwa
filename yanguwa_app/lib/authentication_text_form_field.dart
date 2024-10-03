import 'package:flutter/material.dart';

class AuthenticationTextFormField extends StatelessWidget {
  const AuthenticationTextFormField({
    this.confirmationController,
    required this.icon,
    required this.label,
    required this.textEditingController,
    super.key,
  });

  final TextEditingController? confirmationController;
  final IconData icon;
  final String label;
  final TextEditingController textEditingController;

  String? _validate(String? value) {
    if (value!.isEmpty) {
      return 'This field cannot be empty.';
    }

    if (key.toString().contains('email') == true &&
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) == false) {
      return 'This is not a valid email address.';
    }

    if (key.toString().contains('password') == true && value.length < 6) {
      return 'The password must be at least 6 characters.';
    }

    if (key.toString().contains('password_confirmation') == true &&
        value != confirmationController?.text) {
      return 'The password does not match.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return TextFormField(
      controller: textEditingController,
      obscureText: label.toLowerCase().contains('password'),
      decoration: InputDecoration(
        floatingLabelStyle: theme.textTheme.titleLarge,
        icon: Icon(icon, color: theme.colorScheme.primary),
        labelText: label,
      ),
      validator: _validate,
    );
  }
}