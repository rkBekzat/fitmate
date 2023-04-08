part of 'barcode_bloc.dart';

@immutable
abstract class BarcodeEvent {}

class DefaultBarcodeEvent extends BarcodeEvent {}

class ScannedBarcodeEvent extends BarcodeEvent {
  final String barcode;

  ScannedBarcodeEvent(this.barcode);
}