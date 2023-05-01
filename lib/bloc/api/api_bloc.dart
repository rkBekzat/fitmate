import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../../models/product_data.dart';

part 'api_event.dart';
part 'api_state.dart';

bool contain(RangeValues r, double v){
  return r.start <= v && v <= r.end;
}

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInitial(products: getProducts())) {
    on<AllProductsApiEvent>(_getAll);
    on<FilterProductAPIEvent>(_filtering);
  }

  _getAll(AllProductsApiEvent event, Emitter<ApiState> emit) {
      emit(ApiInitial(products: getProducts()));
  }

  _filtering(FilterProductAPIEvent event, Emitter<ApiState> emit) {
    print("\n\n Cal the filter function \n\n");
    Future<List<ProductData>> filter = getProducts().then(
            (value){
              List<ProductData> results = [];
              for(int i = 0; i < value.length; i++){
                bool okF = true, okS = true, okP = true, okC = true;
                for(int j = 0; j < value[i].nutriments.length; j++){
                  final nutr = value[i].nutriments[j];
                  if(nutr.type == null || nutr.quantity == null){
                    continue;
                  }
                  double val = double.parse(nutr.quantity!);
                  if(nutr.type == "fat_100g"){
                    print("\n Fat: $val \n");
                    okF =contain(event.fatValues, val);
                  }
                  if(nutr.type == "sugars_100g"){
                    print("\n sugars_100g: $val \n");
                    okS = contain(event.sugarValues, val);
                  }
                  if(nutr.type == "proteins_100g"){
                    print("\n proteins_100g: $val \n");
                    okP = contain(event.proteinValues, val);
                  }
                  if(nutr.type == "carbohydrates_100g"){
                    print("\n carbohydrates_100g: $val \n");
                    okC = contain(event.carboValues, val);
                  }
                }
                if(okF && okS && okP && okC){
                  results.add(value[i]);
                }
              }
              return results;
            }
    );
    emit(FilterApiStat(products: filter, ));
  }
}
