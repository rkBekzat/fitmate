import 'package:fitmate/api.dart';
import 'package:fitmate/util/home_item.dart';
import 'package:fitmate/util/product_about.dart';
import 'package:flutter/material.dart';

import '../models/product_data.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<ProductData>>(
          future: getProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final futureProducts = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
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
                          return ProductAbout(productData: product);
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
        ),
      ),
    );
  }
}