import 'package:fitmate/util/home_item.dart';
import 'package:fitmate/util/product_about.dart';
import 'package:fitmate/bloc/api/api_bloc.dart';
import 'package:fitmate/bloc/internet/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product_data.dart';
import 'filter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Add a search bar with a text field and a button
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  // Open a filter page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterPage()),
                  );
                },
                child: Text('Filters'),
              ),
            ],
          ),
          // Wrap the existing code with a BlocConsumer
          BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state is NotConnectedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Internet not connected'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is ConnectedState) {
                return Center(
                  child: BlocBuilder<ApiBloc, ApiState>(
                    builder: (context, state) {
                      if (state is ApiInitial) {
                        late final products = state.products;
                        return FutureBuilder<List<ProductData>>(
                          future: products,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final futureProducts = snapshot.data!;
                              return GridView.builder(
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                ),
                                itemCount: futureProducts.length,
                                itemBuilder: (context, index) {
                                  final product = futureProducts[index];
                                  String image =
                                      product.productImage ?? "No image";
                                  String name = product.productName ?? "No name";

                                  return GestureDetector(
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
                                    child: HomeItem(name: name, image: image),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return const CircularProgressIndicator();
                          },
                        );
                      }
                      return const Center(child: Text('None'));
                    },
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.network_check),
                      SizedBox(height: 10),
                      Text("Internet not connected"),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }



}
