import 'package:fitmate/bloc/search/search_bloc.dart';
import 'package:fitmate/models/product_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../util/product_about.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
          return FutureBuilder<List<ProductData>>(
            future: products,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                final products = snapshot.data!;
                print("\n\n${products.length} \n\n");
                return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      if (product.productName != null) {
                        return ListTile(
                          title: Text(product.productName!),
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) {
                                return ProductAbout(
                                  productData: product,
                                );
                              },
                            );
                          },
                        );
                      }
                      return const Text("Data is null");
                    });
              }
              return const CircularProgressIndicator();
            },
          );
        }));
  }
}
