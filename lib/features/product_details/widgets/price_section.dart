import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import '../utils/price_calculator.dart';

class PriceSection extends StatelessWidget {
  final Product product;
  const PriceSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final priceData = PriceCalculator.calculate(
      price: product.price,
      discountPrice: product.discountPrice,
    );

    return Column(
      children: [
        if (priceData['hasDiscount'])
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "${priceData['displayOriginal'].toStringAsFixed(3)} KWD",
              style: const TextStyle(
                fontSize: 19,
                color: Colors.red,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2,
              ),
            ),
          ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${priceData['displayPrice'].toStringAsFixed(3)} KWD",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            if (priceData['hasDiscount'])
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  priceData['discountPercentage'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
