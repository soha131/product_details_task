import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/product_model.dart';
import '../data/repository/product_repo.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductRepository repository;

  ProductDetailsCubit(this.repository) : super(ProductDetailsInitial());

  Future<void> getProductDetails(int id) async {
    if (state is ProductDetailsLoading) return;

    emit(ProductDetailsLoading());

    try {
      final product = await repository.getProductById(id);
      emit(ProductDetailsSuccess(product));
    } catch (e, stack) {
      log("Error loading product details: $e", stackTrace: stack);
      emit(ProductDetailsError(e.toString()));
    }
  }


}
