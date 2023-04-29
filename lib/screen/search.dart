import 'package:fitmate/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/api/api_bloc.dart';
import '../models/product_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // The search area here
            title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                final searchBloc = context.read<SearchBloc>();
                searchBloc.add(SearchProductEvent(name: value));
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      /* Clear the search field */
                      _searchController.clear();
                      final searchBloc = context.read<SearchBloc>();
                      searchBloc.add(EmptySearchEvent());
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        )),
        body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
          final products = state.searched;
          return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                if (product.productName != null) {
                  return ListTile(title: Text(product.productName!));
                }
                return Text("Data is null");
              });
        }));
  }
}
