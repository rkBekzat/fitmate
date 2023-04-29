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
    on<FilterProductAPIEvent>(_filtering);
  }

  _getAll(AllProductsApiEvent event, Emitter<ApiState> emit) {
    if (state.activeFilter) {
      emit(ApiInitial(products: getProducts()));
    }
    state.activeFilter = false;
  }

  _filtering(FilterProductAPIEvent event, Emitter<ApiState> emit) {
    state.activeFilter = true;
  }
}
