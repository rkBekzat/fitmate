import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../api/api.dart';
import 'package:openfoodfacts/model/Product.dart';

part 'barcode_event.dart';
part 'barcode_state.dart';

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState> {
  BarcodeBloc() : super(BarcodeInitial()) {
    on<DefaultBarcodeEvent> (_beforeScan);
    on<ScannedBarcodeEvent> (_afterScan);
  }

  _beforeScan(DefaultBarcodeEvent event, Emitter<BarcodeState> emit){
    emit(BarcodeInitial());
  }

  _afterScan(ScannedBarcodeEvent event, Emitter<BarcodeState> emit) {
    emit(GetBarcodeState(product: getProductByBarcode(event.barcode)));
  }

}
