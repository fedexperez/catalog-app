import 'package:flutter/material.dart';

import 'package:forms/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  bool updateAvailability(bool value) {
    product.available = value;
    notifyListeners();
    return product.available;
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
