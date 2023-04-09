part of 'barcode_bloc.dart';

@immutable
abstract class BarcodeEvent {}

class DefaultBarcodeEvent extends BarcodeEvent {}

class ScanBarcodeEvent extends BarcodeEvent {}