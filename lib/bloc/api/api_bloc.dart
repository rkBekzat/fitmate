import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
