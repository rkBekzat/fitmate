import 'package:fitmate/util/home_item.dart';
import 'package:fitmate/util/product_about.dart';
import 'package:fitmate/bloc/api/api_bloc.dart';
import 'package:fitmate/bloc/internet/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product_data.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetCubit, InternetState>(
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
                  return listProduct(state.products, false);
                }
                if(state is FilterApiStat){
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              final apiBloc = context.read<ApiBloc>();
                              apiBloc.add(AllProductsApiEvent());
                            },
                            child: Row(
                              children: [
                                Text("Filter"),
                                Icon(Icons.delete_forever),
                              ],
                            )),
                        listProduct(state.products, true),
                      ],
                    ),
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
    );
  }

  Widget listProduct(Future<List<ProductData>> products, bool filter){
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
            physics: filter ? NeverScrollableScrollPhysics() : ScrollPhysics() ,
            shrinkWrap: true,
            itemCount: futureProducts.length,
            itemBuilder: (context, index) {
              final product = futureProducts[index];
              String image = product.productImage ?? "No image";
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

}
