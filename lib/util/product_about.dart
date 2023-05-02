import 'package:fitmate/models/product_data.dart';
import 'package:flutter/material.dart';

import '../models/nutriments_data.dart';


class ProductAbout extends StatefulWidget {
  const ProductAbout({super.key, required this.productData});

  final ProductData productData;

  @override
  State<ProductAbout> createState() => _ProductAboutState();
}

class _ProductAboutState extends State<ProductAbout> {
  bool _showIngredients = true;

  void _toggleButton(int index){
    setState(() {
      _showIngredients = index == 0;
    });
  }

  Widget buildIngredients(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (String? ingredient in widget.productData.ingredients)
            Text(
              '• $ingredient',
              style: const TextStyle(fontSize: 18),
            ),
        ],
      ),
    );
  }

  Widget buildNutriments(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (NutrimentsData nutriment in widget.productData.nutriments)
            if(double.parse(nutriment.quantity ?? "0") != 0.0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${nutriment.type}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Divider(thickness: 1,),
                  Text(
                    '${nutriment.quantity}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var productImage = widget.productData.productImage ?? "";
    var productName = widget.productData.productName ?? "No name";
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child:
              FadeInImage.assetNetwork(
                placeholder: "assets/images/default_product.png",
                image: productImage,
                fit: BoxFit.contain,
                height: 200,
                imageErrorBuilder: (context, object, stacktrace){
                  return Image.asset(
                    "assets/images/default_product.png",
                    fit:BoxFit.contain,
                    height: 200,);
                },
              )),
              const SizedBox(height: 16),
              Text(
                productName,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Center(
                child:
                    LayoutBuilder(
                      builder: (context, constraints){
                        return ToggleButtons(
                            isSelected: [_showIngredients, !_showIngredients],
                            onPressed: _toggleButton,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(8)),
                            constraints: BoxConstraints.expand(
                                width: constraints.maxWidth / 2 - 3),
                            children: const [
                              Text('Ingredients',
                                  style: TextStyle(fontSize: 20)),
                              Text('Nutriments',
                                style: TextStyle(fontSize: 20),
                              ),
                            ]
                        );
                      },
                    )
              ),
              const SizedBox(height: 16),
              _showIngredients ?
              buildIngredients(context) : buildNutriments(context)
            ],
          ),
        ),
      ),
    );
  }
}
