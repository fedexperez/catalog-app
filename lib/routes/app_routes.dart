import 'package:flutter/material.dart';

import 'package:forms/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static final Map<String, Widget Function(BuildContext)> routes = {
    'login': (BuildContext context) => const LoginScreen(),
    'register': (BuildContext context) => const UserRegisterScreen(),
    'check_auth': (BuildContext context) => const CheckAuthScreen(),
    'home': (BuildContext context) => const HomeScreen(),
    'product': (BuildContext context) => const ProductScreen(),
  };
}
