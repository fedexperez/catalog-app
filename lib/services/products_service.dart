//It's like the controller, its the one that is going to do the POST, GET, UPTDATE

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:forms/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'products-b6d7d-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectedProduct;

  final _storage = const FlutterSecureStorage();

  File? newPicture;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await _storage.read(key: 'token') ?? ''});
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = json.decode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }

  Future<Product> saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
    return product;
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json',
        {'auth': await _storage.read(key: 'token') ?? ''});
    final resp = await http.put(url, body: product.toJson());
    final decodedData = resp.body;

    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await _storage.read(key: 'token') ?? ''});
    final resp = await http.post(url, body: product.toJson());
    final decodedData = json.decode(resp.body);

    product.id = decodedData['name'];

    products.add(product);

    return product.id!;
  }

  void updateSelectedProductImage(String imagePath) async {
    selectedProduct.picture = imagePath;
    newPicture = File.fromUri(Uri(path: imagePath));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (newPicture == null) return null;

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('YOUR_CLOUDINARY_PERSONAL_LINK');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', newPicture!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }

    newPicture = null;

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
