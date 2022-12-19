import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:forms/providers/product_form_provider.dart';
import 'package:forms/services/products_service.dart';
import 'package:forms/themes/themes.dart';
import 'package:forms/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Product name'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImage(url: productService.selectedProduct.picture),
            const _ProductForm(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: productService.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;
                final String? imageUrl = await productService.uploadImage();

                if (imageUrl != null) productForm.product.picture = imageUrl;

                await productService.saveOrCreateProduct(productForm.product);
              },
        child: productService.isSaving
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.save),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: _productFormDecoration(),
      child: Form(
        key: productForm.formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: product.name,
              onChanged: ((value) => product.name = value),
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'It must have a name';
                }
                return null;
              }),
              decoration: const InputDecoration(
                labelText: 'Product',
                hintText: 'Name of the product',
              ),
            ),
            TextFormField(
              initialValue: product.price.toString(),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              onChanged: (value) {
                if (double.tryParse(value) == null) {
                  product.price = 0;
                } else {
                  product.price = double.parse(value);
                }
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
            ),
            SwitchListTile.adaptive(
              title: const Text('Available'),
              value: product.available,
              activeColor: AppTheme.primary,
              onChanged: productForm.updateAvailability,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _productFormDecoration() {
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(45), bottomRight: Radius.circular(45)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 7),
            blurRadius: 5,
          )
        ]);
  }
}
