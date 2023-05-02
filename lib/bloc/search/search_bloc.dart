import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api/api.dart';
import '../../models/product_data.dart';

part 'search_event.dart';
part 'search_state.dart';

bool same(String a, String b) {
  for (int i = 0; i < min(a.length, b.length); i++) {
    if (a[i].toLowerCase() != b[i].toLowerCase()) {
      return false;
    }
  }
  return true;
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(products: PRODUCTS, searched: Future(() => []))) {
    on<EmptySearchEvent>(_empty);
    on<SearchProductEvent>(_search);
  }

  _empty(EmptySearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith(Future(() => [])));
  }

  _search(SearchProductEvent event, Emitter<SearchState> emit)  {

    emit(state.copyWith(PRODUCTS.then((value) {
      List<ProductData> result = [];
      for (int i = 0; i < value.length; i++) {
        if (value[i].productName == null) {
          continue;
        }
        if (same(value[i].productName!, event.name)) {
          result.add(value[i]);
        }
      }
      return result;
    })));
  }
}
