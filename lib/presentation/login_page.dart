import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final pinController = TextEditingController();
  bool get isValid => pinController.text.trim().isNotEmpty;

  bool isLoading = false;
  Future<void> login() async {
    setState(() => isLoading = true);

    final err = await context.read<AuthService>().login(pinController.text);
    if (err != null && context.mounted) {
      final snackbar = SnackBar(content: Text(err));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    setState(() => isLoading = false);
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
                onPressed: isValid && !isLoading ? login : null,
                child: isLoading ? CircularProgressIndicator() : Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
