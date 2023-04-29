part of 'search_bloc.dart';

class SearchState {
  final Future<List<ProductData>> products ;
  final List<ProductData> searched ;
  SearchState({ required this.products, required this.searched });

  SearchState copyWith(List<ProductData> newProducts){
    return SearchState(
        products: products,
        searched: newProducts);
  }
}

