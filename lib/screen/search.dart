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
    return  Scaffold(
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
                        final searchBloc = context.read<ApiBloc>();
                        searchBloc.add(SearchProductAPIEvent(title: value));

                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          /* Clear the search field */
                          _searchController.clear();
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            )),
        body: BlocBuilder<ApiBloc, ApiState>(
            builder: (context, state) {
              if (state is ApiInitial) {
                final products = state.products;
                return FutureBuilder<List<ProductData>>(
                    future: products,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        print("Products: ${snapshot.data!.length}  Text:${_searchController.value.text}\n");
                        final _data = snapshot.data!;
                        return ListView.builder(
                          itemCount: _data?.length,
                            itemBuilder: (context, index) {
                            final product = _data[index];
                              if(product.productName != null) {
                                return ListTile(title: Text(
                                    product.productName!));
                              }
                              return Text("Data is null");
                            }
                        );
                      } else if(snapshot.hasError){
                        return Text("The errors: ${snapshot.error.toString()}");
                      }
                      return Text("Data not ready");
                    });
              }
              return Text("Different state");
            }),
    );
  }
}
