import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forms/screens/screens.dart';
import 'package:forms/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    const storage = FlutterSecureStorage();

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.verifyToken(),
          builder: ((context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return const Icon(Icons.person, size: 100);

            if (snapshot.hasData == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const LoginScreen(),
                      transitionDuration: const Duration(seconds: 0)),
                );
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => const HomeScreen(),
                      transitionDuration: const Duration(seconds: 0)),
                );
              });
            }

            return Container();
          }),
        ),
      ),
    );
  }
}
