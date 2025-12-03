import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../data/models/product_model.dart';
import '../utils/price_calculator.dart';

class SimilarProductCard extends StatelessWidget {
  final Product product;
  final String placeholderAsset;

  const SimilarProductCard({
    super.key,
    required this.product,
    this.placeholderAsset = "assets/images/no_image.jpg",
  });

  @override
  Widget build(BuildContext context) {
    final priceData = PriceCalculator.calculate(
      price: product.price,
      discountPrice: product.discountPrice,
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الصورة بنسبة ثابتة
          Expanded(
            flex: 5, // الصورة تأخد حوالي 55-60% من الارتفاع
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: product.image,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.grey[300]),
                ),
                errorWidget: (_, __, ___) => Image.asset(
                  placeholderAsset,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // المحتوى + الزراير
          Expanded(
            flex: 4, // الباقي للنص والزراير
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // اسم المنتج
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13.5, height: 1.3),
                  ),
                  const SizedBox(height: 6),

                  // السعر
                  _buildPriceWidget(priceData),

                  const Spacer(),

                  // الزراير دايمًا في الأسفل
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFE7E00),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Add",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(
                          product.isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: product.isFavorite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceWidget(Map<String, dynamic> priceData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (priceData['hasDiscount'])
          Text(
            "${priceData['displayOriginal'].toStringAsFixed(3)} KWD",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.red,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        Text(
          "${priceData['displayPrice'].toStringAsFixed(3)} KWD",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}