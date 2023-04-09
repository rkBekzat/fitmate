import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../../models/product_data.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial(products: getProducts())) {
    on<AllProductsApiEvent>(_getAll);

  }

  _getAll(AllProductsApiEvent event, Emitter<ApiState> emit){
    emit(ApiInitial(products: getProducts()));
  }





}
