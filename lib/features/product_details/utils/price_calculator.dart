class PriceCalculator {
  static Map<String, dynamic> calculate({
    required String price,
    required String? discountPrice,
  }) {
    final cleanPrice = price.replaceAll(',', '').trim();
    final cleanDiscount = (discountPrice ?? "").replaceAll(',', '').trim();

    var original = double.tryParse(cleanPrice) ?? 0.0;
    var discount = double.tryParse(cleanDiscount) ?? 0.0;

    // Fix swapped logic
    if (discount > original && discount > 0) {
      final temp = original;
      original = discount;
      discount = temp;
    }

    final hasDiscount = discount > 0 && discount < original;
    final percentage = hasDiscount
        ? ((original - discount) / original * 100).round()
        : 0;

    return {
      'originalPrice': original,
      'discountPrice': discount,
      'hasDiscount': hasDiscount,
      'discountPercentage': hasDiscount ? '-$percentage%' : '',
      'displayPrice': hasDiscount ? discount : original,
      'displayOriginal': hasDiscount ? original : null,
    };
  }
}