import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:forms/routes/app_routes.dart';
import 'package:forms/services/services.dart';
import 'package:forms/themes/themes.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsService()),
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: NotificationService.messengerKey,
      title: 'Products App',
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      theme: AppTheme.ligthTheme,
    );
  }
}
