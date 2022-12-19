import 'package:flutter/material.dart';
import 'package:forms/providers/login_form_provider.dart';
import 'package:forms/widgets/widgets.dart';
import 'package:provider/provider.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);

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
                    'Create account',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 30),
                  //FORMULARIO
                  ChangeNotifierProvider(
                    create: (context) => LoginFormProvider(),
                    child: const RegisterForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: const Text(
                  'Return to log in',
                  style: TextStyle(color: Colors.black),
                )),
            const SizedBox(height: 50),
          ],
        ),
      )),
    );
  }
}
