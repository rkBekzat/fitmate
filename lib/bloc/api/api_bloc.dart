import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../../models/product_data.dart';

part 'api_event.dart';
part 'api_state.dart';

bool contain(RangeValues r, double v) {
  return r.start <= v && v <= r.end;
}

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial(products: constProducts)) {
    on<AllProductsApiEvent>(_getAll);
    on<FilterProductAPIEvent>(_filtering);
  }

  _getAll(AllProductsApiEvent event, Emitter<ApiState> emit) {
    emit(ApiInitial(products: constProducts));
  }

  _filtering(FilterProductAPIEvent event, Emitter<ApiState> emit) {
    Future<List<ProductData>> filter = constProducts.then((value) {
      List<ProductData> results = [];
      for (int i = 0; i < value.length; i++) {
        bool okF = true, okS = true, okP = true, okC = true;
        for (int j = 0; j < value[i].nutriments.length; j++) {
          final nutr = value[i].nutriments[j];
          if (nutr.type == null || nutr.quantity == null) {
            continue;
          }
          double val = double.parse(nutr.quantity!);
          if (nutr.type == "fat_100g") {
            okF = contain(event.fatValues, val);
          }
          if (nutr.type == "sugars_100g") {
            okS = contain(event.sugarValues, val);
          }
          if (nutr.type == "proteins_100g") {
            okP = contain(event.proteinValues, val);
          }
          if (nutr.type == "carbohydrates_100g") {
            okC = contain(event.carboValues, val);
          }
        }
        if (okF && okS && okP && okC) {
          results.add(value[i]);
        }
      }
      return results;
    });
    emit(FilterApiStat(
      products: filter,
    ));
  }
}
