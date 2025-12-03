import 'package:equatable/equatable.dart';

import '../data/models/product_model.dart';

abstract class ProductDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final Product product;

  ProductDetailsSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  ProductDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
