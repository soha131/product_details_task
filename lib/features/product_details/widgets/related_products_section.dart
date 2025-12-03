import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import '../data/repository/product_repo.dart';
import 'similar_product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelatedProductsSection extends StatefulWidget {
  final Product currentProduct;

  const RelatedProductsSection({super.key, required this.currentProduct});

  @override
  State<RelatedProductsSection> createState() => _RelatedProductsSectionState();
}

class _RelatedProductsSectionState extends State<RelatedProductsSection> {
  late final Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = context.read<ProductRepository>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: CircularProgressIndicator(color: Color(0xFFFE7E00)),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox();
        }

        final related =
            snapshot.data!
                .where(
                  (p) =>
                      p.category.id == widget.currentProduct.category.id &&
                      p.id != widget.currentProduct.id,
                )
                .take(12)
                .toList();

        if (related.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: Text("No Related Products Found")),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: const [
                  Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "Related Products",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: crossAxisCount == 2 ? 0.50 : 0.45,
                  ),
                  itemCount: related.length,
                  itemBuilder:
                      (context, index) =>
                          SimilarProductCard(product: related[index]),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
