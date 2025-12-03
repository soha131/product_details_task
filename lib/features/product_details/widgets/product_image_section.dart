import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductImageSection extends StatelessWidget {
  final String? imageUrl;
  final String placeholderAsset;

  const ProductImageSection({
    super.key,
    required this.imageUrl,
    this.placeholderAsset = "assets/images/no_image.jpg",
  });

  @override
  Widget build(BuildContext context) {
    final hasValidUrl = imageUrl != null && imageUrl!.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 420), // أقصى عرض (مثالي للموبايل والتابلت)
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: AspectRatio(
              aspectRatio: 1 / 1.15,
              child: hasValidUrl
                  ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: (_, __) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.grey[300]),
                ),
                errorWidget: (_, __, ___) => Image.asset(
                  placeholderAsset,
                  fit: BoxFit.cover,
                ),
              )
                  : Image.asset(
                placeholderAsset,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}