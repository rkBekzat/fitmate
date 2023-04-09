part of 'barcode_bloc.dart';

@immutable
abstract class BarcodeState {}

class BarcodeInitial extends BarcodeState {}

class GetBarcodeState extends BarcodeState {
  final Future<Product?> product;
  final String barcode;

  GetBarcodeState({required this.product, required this.barcode});
}
