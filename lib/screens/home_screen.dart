import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:forms/models/product.dart';
import 'package:forms/services/services.dart';
import 'package:forms/screens/screens.dart';
import 'package:forms/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productsService.isLoading) {
      return const LoadingProductsScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        leading: IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: ((context, index) => GestureDetector(
            onTap: () {
              productsService.selectedProduct =
                  productsService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
            child: ProductCard(
              product: productsService.products[index],
            ))),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: const Icon(Icons.add_box_outlined),
        onPressed: () {
          productsService.selectedProduct =
              Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
