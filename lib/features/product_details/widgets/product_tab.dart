import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../data/models/product_model.dart';
import 'description_section.dart';
import 'price_section.dart';
import 'product_image_section.dart';
import 'related_products_section.dart';

class ProductTab extends StatelessWidget {
  final Product product;
  final bool isDescriptionExpanded;
  final VoidCallback onToggleDescription;

  const ProductTab({
    super.key,
    required this.product,
    required this.isDescriptionExpanded,
    required this.onToggleDescription,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          ProductImageSection(imageUrl: product.image),
          const SizedBox(height: 16),
          _buildActionButtons(),
          const SizedBox(height: 16),
          _buildImageIndicators(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(product.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                PriceSection(product: product),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 6),
                _buildBrandAndRating(),
                const SizedBox(height: 20),
                DescriptionSection(
                  description: product.description,
                  isExpanded: isDescriptionExpanded,
                  onToggle: onToggleDescription,
                ),
                const SizedBox(height: 30),
                RelatedProductsSection(currentProduct: product),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              product.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: product.isFavorite ? Colors.red : Colors.black,
              size: 28,
            ),
            onPressed: () {

            },
          ),
          IconButton(
            icon: const Icon(Icons.ios_share, color: Colors.black, size: 28),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildImageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (i) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: i == 0 ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: i == 0 ? const Color(0xFFFE7E00) : Colors.orange.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildBrandAndRating() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Brand: ${product.brand}",
            ),
            InkWell(
              onTap: () {
              },
              splashColor: Colors.grey.shade50,
              highlightColor: Colors.transparent,
              hoverColor: Colors.grey.shade50,
              child: Row(
                children: const [
                  Text(
                    "More",
                    style: TextStyle(

                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,

                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),
        const Divider(),
        const SizedBox(height: 10),
        Row(
          children: [
            RatingBarIndicator(
              rating: product.averageRating,
              itemSize: 22,
              itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
            ),
            const SizedBox(width: 8),
            Text("${product.averageRating}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 6),
            Text("(${product.reviews.length} Reviewers)", style: const TextStyle(color: Colors.grey)),
            const Spacer(),
            Text("SKU: ${product.id}"),
          ],
        ),
      ],
    );
  }
}