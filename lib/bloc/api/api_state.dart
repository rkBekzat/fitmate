part of 'api_bloc.dart';

@immutable
abstract class ApiState {}

class ApiInitial extends ApiState {
  final Future<List<ProductData>> products;

  ApiInitial({required this.products});
}

class ProductApiState extends ApiState {
  final Future<ProductData> product;

  ProductApiState({required this.product});
}
