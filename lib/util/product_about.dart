import 'package:fitmate/models/product_data.dart';
import 'package:flutter/material.dart';

import '../models/nutriments_data.dart';

class ProductAbout extends StatelessWidget {
  const ProductAbout({super.key, required this.productData});

  final ProductData productData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
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
              Image.network(
                productData.productImage ?? '',
                width: double.infinity,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              Text(
                '${productData.productName}',
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 8),
              const Text(
                'Product Details:',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ingredients:',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    for (String? ingredient in productData.ingredients)
                      Text(
                        '• $ingredient',
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nutriments:',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 4),
                    for (NutrimentsData nutriment in productData.nutriments)
                      Text(
                        '${getHumanReadableNutriment(nutriment.type, context)}: ${nutriment.quantity}',
                        style: const TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
