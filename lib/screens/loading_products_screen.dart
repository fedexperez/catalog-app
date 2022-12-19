import 'package:flutter/material.dart';

class LoadingProductsScreen extends StatelessWidget {
  const LoadingProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Center(
        child: Image.asset('assets/images/loading-image.gif'),
      ),
    );
  }
}
