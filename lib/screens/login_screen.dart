import 'package:flutter/material.dart';
import 'package:forms/providers/login_form_provider.dart';
import 'package:forms/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
          bodyChild: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 180),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 30),
                  //FORMULARIO
                  ChangeNotifierProvider(
                    create: (context) => LoginFormProvider(),
                    child: const LoginForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'register');
                },
                child: const Text(
                  'Create account',
                  style: TextStyle(color: Colors.black),
                )),
            const SizedBox(height: 50),
          ],
        ),
      )),
    );
  }
}
