import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import 'package:openfoodfacts/model/Product.dart';

part 'barcode_event.dart';
part 'barcode_state.dart';

class BarcodeBloc extends Bloc<BarcodeEvent, BarcodeState> {
  BarcodeBloc() : super(BarcodeInitial()) {
    on<DefaultBarcodeEvent> (_beforeScan);
    on<ScanBarcodeEvent> (_afterScan);
  }

  _beforeScan(DefaultBarcodeEvent event, Emitter<BarcodeState> emit){
    emit(BarcodeInitial());
  }

  _afterScan(ScanBarcodeEvent event, Emitter<BarcodeState> emit) async {
    final barcodeValue = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    if(barcodeValue.length > 3) {
      emit(GetBarcodeState(
          product: getProductByBarcode(barcodeValue), barcode: barcodeValue));
    } else {
      emit(BarcodeInitial());
    }
  }

}
