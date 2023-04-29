import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api.dart';
import '../../models/product_data.dart';

part 'search_event.dart';
part 'search_state.dart';

bool same(String a, String b) {
  for (int i = 0; i < min(a.length, b.length); i++) {
    if (a[i] != b[i]) {
      return false;
    }
  }
  return true;
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(products: getProducts(), searched: [])) {
    on<EmptySearchEvent>(_empty);
    on<SearchProductEvent>(_search);
  }

  _empty(EmptySearchEvent event, Emitter<SearchState> emit) {
    emit(state.copyWith([]));
  }

  _search(SearchProductEvent event, Emitter<SearchState> emit) async {
    List<ProductData> result = [];
    final current = await state.products;
    for (int i = 0; i < current.length; i++) {
      if (current[i].productName == null) {
        continue;
      }
      if (same(current[i].productName!, event.name)) {
        result.add(current[i]);
      }
    }
    emit(state.copyWith(result));
  }
}
