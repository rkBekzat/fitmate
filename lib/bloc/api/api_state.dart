part of 'api_bloc.dart';

abstract class ApiState {
  bool activeFilter = false;
}

class ApiInitial extends ApiState {
  final Future<List<ProductData>> products;

  ApiInitial({required this.products});
}

class FilterApiStat extends ApiState {
  final Future<List<ProductData>> products;

  FilterApiStat({required this.products});
}
