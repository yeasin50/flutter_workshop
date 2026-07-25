import 'package:flutter/material.dart';

import './home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final pinController = TextEditingController();
  bool get isValid => pinController.text.trim().isNotEmpty;

  Future<void> login() async {
    // TODO: Validation and move on\
    final route = MaterialPageRoute(builder: (context) => HomePage());
    Navigator.of(context).pushReplacement(route);
  }

  @override
  void initState() {
    super.initState();
    pinController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: .min,
            spacing: 24,
            crossAxisAlignment: .stretch,
            children: [
              Icon(Icons.shop, size: 214, color: Colors.blueGrey.shade300),
              TextFormField(controller: pinController),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  fixedSize: Size.fromHeight(48),
                ),
                onPressed: isValid ? login : null,
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
