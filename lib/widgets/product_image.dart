import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:forms/services/services.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            _ShowProductImage(url: url),
            Positioned(
              top: 15,
              left: 10,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Positioned(
              top: 15,
              right: 15,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt),
                      color: Colors.white,
                      onPressed: () async {
                        final ImagePicker imagePicker = ImagePicker();
                        final XFile? pickedFile = await imagePicker.pickImage(
                            source: ImageSource.camera, imageQuality: 100);

                        if (pickedFile == null) {
                          return NotificationService.showSnackbar(
                              'No image picked');
                        }

                        productService
                            .updateSelectedProductImage(pickedFile.path);
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    child: IconButton(
                      icon: const Icon(Icons.photo),
                      color: Colors.white,
                      onPressed: () async {
                        final ImagePicker imagePicker = ImagePicker();
                        final XFile? pickedFile = await imagePicker.pickImage(
                            source: ImageSource.gallery, imageQuality: 100);

                        if (pickedFile == null) {
                          NotificationService.showSnackbar('No image picked');
                          return;
                        }

                        productService
                            .updateSelectedProductImage(pickedFile.path);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShowProductImage extends StatelessWidget {
  const _ShowProductImage({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: _imageBoxDecoration(),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        child: getImage(url),
      ),
    );
  }

  BoxDecoration _imageBoxDecoration() {
    return const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    );
  }

  Widget getImage(String? imageUrl) {
    if (imageUrl == null) {
      return const Image(
        image: AssetImage('assets/images/no-image.png'),
        fit: BoxFit.cover,
      );
    } else if (imageUrl.startsWith('http')) {
      return FadeInImage(
        image: NetworkImage(url!),
        placeholder: const AssetImage('assets/images/loading-image.gif'),
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imageUrl),
        fit: BoxFit.cover,
      );
    }
  }
}
