import 'dart:async';
import 'package:fitmate/models/nutriments_data.dart';
import 'package:fitmate/models/product_data.dart';
import 'package:openfoodfacts/model/Nutriments.dart';
import 'package:openfoodfacts/model/ProductResultV3.dart';
import 'package:openfoodfacts/model/parameter/PnnsGroup2Filter.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/CountryHelper.dart';
import 'package:openfoodfacts/utils/PnnsGroups.dart';

/// request a product from the OpenFoodFacts database using BarCode
///
/// Сникерс с лесным орехом: 5000159439480
/// Липтон
/// Монстр 5060639124275
///
/// Возвращает ProductData или null
///
Future<ProductData?> getProductByBarcode(String barCode) async {
  final ProductQueryConfiguration configuration = ProductQueryConfiguration(
    barCode,
    language: OpenFoodFactsLanguage.RUSSIAN,
    fields: [ProductField.ALL],
    version: ProductQueryVersion.v3,
  );
  final ProductResultV3 result =
      await OpenFoodAPIClient.getProductV3(configuration);

  if (result.status == ProductResultV3.statusSuccess) {
    var product = result.product;
    var nutr = product!.nutriments;
    nutr ??= Nutriments.empty();
    final nutrList = nutr.toData();
    var nutrimentsData = <NutrimentsData>[];

    for (final entry in nutrList.entries) {
      nutrimentsData.add(NutrimentsData(
        type: entry.key,
        quantity: entry.value,
      ));
    }

    var ingredients = <String?>[];
    var productIngredients = product.ingredients;
    productIngredients ??= [];
    for (final ingr in productIngredients) {
      ingredients.add(ingr.text);
    }

    return ProductData(
      productName: product.productName,
      productImage: product.imageFrontUrl,
      ingredients: ingredients,
      nutriments: nutrimentsData,
    );
  } else {
    return null;
  }
}

Future<List<ProductData>> getProducts() async {
  const productCategories = <PnnsGroup2>[
    PnnsGroup2.CHEESE,
    PnnsGroup2.CHOCOLATE_PRODUCTS,
    PnnsGroup2.MILK_AND_YOGURT,
    PnnsGroup2.MEAT,
    PnnsGroup2.FRUIT_JUICES,
    PnnsGroup2.SWEETS,
  ];

  var products = <ProductData>[];

  for (final productCategory in productCategories) {
    products.addAll(await getProductsByCategory(productCategory));
  }

  products.shuffle();
  return products;
}

/// request a list of products from the OpenFoodFacts database
Future<List<ProductData>> getProductsByCategory(PnnsGroup2 filter) async {
  List<ProductData> list = [];

  ProductSearchQueryConfiguration configuration =
      ProductSearchQueryConfiguration(
    parametersList: <Parameter>[
      PnnsGroup2Filter(pnnsGroup2: filter),
      const PageSize(size: 15),
    ],
    language: OpenFoodFactsLanguage.RUSSIAN,
    country: OpenFoodFactsCountry.RUSSIA,
    fields: [ProductField.ALL],
  );

  SearchResult result = await OpenFoodAPIClient.searchProducts(
    null,
    configuration,
  );

  var products = result.products;
  products ??= [];
  for (final product in products) {
    var nutr = product.nutriments;
    nutr ??= Nutriments.empty();
    final nutrList = nutr.toData();
    var nutrimentsData = <NutrimentsData>[];

    for (final entry in nutrList.entries) {
      nutrimentsData.add(NutrimentsData(
        type: entry.key,
        quantity: entry.value,
      ));
    }

    var ingredients = <String?>[];
    var productIngredients = product.ingredients;
    productIngredients ??= [];
    for (final ingr in productIngredients) {
      ingredients.add(ingr.text);
    }

    list.add(ProductData(
      productName: product.productName,
      productImage: product.imageFrontUrl,
      ingredients: ingredients,
      nutriments: nutrimentsData,
    ));
  }
  return list;
}
