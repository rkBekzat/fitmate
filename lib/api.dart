import 'dart:async';
import 'package:fitmate/models/nutriments_data.dart';
import 'package:fitmate/models/product_data.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/ProductResultV3.dart';
import 'package:openfoodfacts/model/parameter/PnnsGroup2Filter.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/PnnsGroups.dart';

/// request a product from the OpenFoodFacts database using BarCode
Future<Product?> getProductByBarcode(String barCode) async {

  final ProductQueryConfiguration configuration = ProductQueryConfiguration(
    barCode,
    language: OpenFoodFactsLanguage.RUSSIAN,
    fields: [ProductField.ALL],
    version: ProductQueryVersion.v3,
  );
  final ProductResultV3 result =
      await OpenFoodAPIClient.getProductV3(configuration);

  if (result.status == ProductResultV3.statusSuccess) {
    return result.product;
  } else {
    throw Exception('product not found, please insert data for $barCode');
  }
}


/// request a list of products from the OpenFoodFacts database
Future<List<ProductData>> getProducts() async {
  List<ProductData> list = [];

  ProductSearchQueryConfiguration configuration = 
    ProductSearchQueryConfiguration(
      parametersList: <Parameter>[
        const PnnsGroup2Filter(pnnsGroup2: PnnsGroup2.CHOCOLATE_PRODUCTS),
        const PageSize(size: 15),
      ]
    );
  
  SearchResult result = await OpenFoodAPIClient.searchProducts(null, configuration,);

  var products = result.products;
  products ??= [];
  for (final product in products) {
    var nutr = product.nutriments;
    nutr ??= Nutriments.empty();
    final nutrList = nutr.toData();
    var nutrimentsData = <NutrimentsData>[];
    
    for (final entry in nutrList.entries) {
      nutrimentsData.add(
        NutrimentsData(
          type: entry.key,
          quantity: entry.value,
        )
      );
    }

    var ingredients = <String?>[];
    var productIngredients = product.ingredients;
    productIngredients ??= [];
    for (final ingr in productIngredients) {
      ingredients.add(ingr.text);
    }

    list.add(
      ProductData(
        productName: product.productName,
        productImage: product.imageFrontUrl,
        ingredients: ingredients,
        nutriments: nutrimentsData,
      )
    );
  }
  return list;
}
