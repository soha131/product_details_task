import '../../../../core/api_service.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ApiService api;

  ProductRepository(this.api);

  Future<List<Product>> getAllProducts() async {
    final data = await api.get("/products/");
    return (data as List).map((e) => Product.fromJson(e)).toList();
  }

  Future<Product> getProductById(int id) async {
    final data = await api.get("/products/$id/");
    return Product.fromJson(data);
  }

}
