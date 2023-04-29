part of 'api_bloc.dart';

@immutable
abstract class ApiState {
  bool activeFilter = false;
}

class ApiInitial extends ApiState {
  final Future<List<ProductData>> products;

  ApiInitial({required this.products});
}
