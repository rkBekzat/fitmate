import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../../models/product_data.dart';

part 'api_event.dart';
part 'api_state.dart';

bool same(String a, String b){
  for(int i = 0; i < min(a.length, b.length); i++) {
    if(a[i] != b[i]){
      return false;
    }
  }
  return true;
}

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial(products: getProducts())) {
    on<AllProductsApiEvent>(_getAll);
    on<SearchProductAPIEvent>(_search);
    on<FilterProductAPIEvent>(_filtering);
  }

  _getAll(AllProductsApiEvent event, Emitter<ApiState> emit) {
    if(state.activeFilter) {
      emit(ApiInitial(products: getProducts()));
    }
    state.activeFilter = false;
  }

  _search(SearchProductAPIEvent event, Emitter<ApiState> emit){
    if(event.title == ""){
      emit(ApiInitial(products: getProducts()));
        return ;
    }
    state.activeFilter = true;
    final _searchProducts = getProducts().then((List<ProductData> value) {
      List<ProductData> result = [];
      for (int i = 0; i < value.length; i++){
        if(value[i] == null || value[i].productName == null){
          continue;
        }
        if(same(value[i].productName!, event.title)){
          result.add(value[i]);
        }
      }
      result ??= [];
      return result;
    });
    emit(ApiInitial(products: _searchProducts)  );
  }
  _filtering(FilterProductAPIEvent event, Emitter<ApiState> emit) {
    state.activeFilter = true;
  }
}
