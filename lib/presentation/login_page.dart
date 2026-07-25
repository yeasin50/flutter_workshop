import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final pinController = TextEditingController();

  bool get isValid => pinController.text.trim().isNotEmpty;

  Future<void> login() async {
    // ...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: .min,
          spacing: 24,
          children: [
            TextFormField(controller: pinController),
            ElevatedButton(onPressed: isValid ? login : null, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}
