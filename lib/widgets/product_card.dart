import 'package:flutter/material.dart';
import 'package:forms/models/models.dart';
import 'package:forms/themes/themes.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 400,
      margin: const EdgeInsets.all(15),
      decoration: _cardBorders(),
      child: Stack(
        children: [
          _BackgroundImage(url: product.picture),
          Positioned(
            right: 0,
            top: 0,
            child: _ProductPrice(size: size, price: product.price),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: _ProductDetails(
                size: size, productTitle: product.name, productId: product.id),
          ),
          if (!product.available)
            Positioned(child: _ProductAvailable(size: size))
        ],
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 7),
            blurRadius: 10,
          )
        ]);
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
    this.url,
  }) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: (url == null || url == '')
              ? const Image(
                  image: AssetImage('assets/images/no-image.png'),
                  fit: BoxFit.cover,
                )
              : FadeInImage(
                  placeholder:
                      const AssetImage('assets/images/loading-image.gif'),
                  image: NetworkImage(url!),
                  fit: BoxFit.cover,
                )),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  const _ProductDetails({
    Key? key,
    required this.size,
    required this.productTitle,
    this.productId,
  }) : super(key: key);

  final Size size;
  final String productTitle;
  final String? productId;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.65,
      height: 70,
      decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productTitle,
            style: _cardTextStyle(),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          Text(
            '$productId',
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}

class _ProductPrice extends StatelessWidget {
  const _ProductPrice({
    Key? key,
    required this.size,
    required this.price,
  }) : super(key: key);

  final Size size;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.25,
      height: 70,
      decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )),
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$price',
              style: _cardTextStyle(),
            ),
            Text(
              'USD',
              style: _cardTextStyle(),
            )
          ],
        ),
      ),
    );
  }
}

class _ProductAvailable extends StatelessWidget {
  const _ProductAvailable({Key? key, required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.25,
      height: 70,
      decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      padding: const EdgeInsets.all(10),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Not available', style: _cardTextStyle()),
          ],
        ),
      ),
    );
  }
}

TextStyle _cardTextStyle() {
  return const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
