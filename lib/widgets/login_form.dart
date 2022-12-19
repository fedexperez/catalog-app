import 'package:flutter/material.dart';
import 'package:forms/providers/login_form_provider.dart';
import 'package:forms/services/services.dart';
import 'package:forms/themes/themes.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
        key: loginForm.formKey,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                icon: const Icon(Icons.alternate_email),
                iconColor: AppTheme.primary,
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'Wrong format for a email';
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock_outline),
              ),
              onChanged: (value) => loginForm.password = value,
            ),
            const SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                disabledColor: Colors.grey,
                color: AppTheme.primary,
                textColor: Colors.white,
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
                        final authService =
                            Provider.of<AuthService>(context, listen: false);

                        if (!loginForm.isValidForm()) return;

                        loginForm.isLoading = true;
                        final String? errorResp = await authService.signIn(
                            loginForm.email, loginForm.password);

                        if (errorResp == null) {
                          Navigator.restorablePushReplacementNamed(
                              context, 'home');
                        } else {
                          NotificationService.showSnackbar(
                              'Wrong email or password, try again');
                        }
                        loginForm.isLoading = false;
                      },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    loginForm.isLoading ? 'Login in' : 'Log in',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ));
  }
}
