import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitmate/api/api.dart';
import 'package:openfoodfacts/model/ProductResultV3.dart';
import 'package:mockito/mockito.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:openfoodfacts/utils/PnnsGroups.dart';

import 'mocks/test_api.mocks.dart';

@GenerateMocks([ApiHelper])
void main() async {
  final apiMock = MockApiHelper();
  GetIt.instance.registerSingleton<ApiHelper>(apiMock);

  group("API unit tests", () {
    test("getProductByBarcode: Product not found", () async {
      when(apiMock.getProductV3(any)).thenAnswer((_) async {
        final Map<String, dynamic> productJson = {
          "status": "product_not_found",
        };
        return ProductResultV3.fromJson(productJson);
      });

      final ret = await getProductByBarcode("000000000");
      expect(ret!.productName, "((product not found))");
    });

    test("getProductByBarcode: Product found successfully", () async {
      when(apiMock.getProductV3(any)).thenAnswer((_) async {
        final Map<String, dynamic> nutriments = {};

        final Map<String, dynamic> products = {
          "product_name": "E-ON Almond Rush",
          "ingredients": [],
          "nutriments": nutriments,
        };

        final Map<String, dynamic> productJson = {
          "status": "success",
          "product": products,
        };

        return ProductResultV3.fromJson(productJson);
      });

      final ret = await getProductByBarcode("000000000");
      expect(ret!.productName, "E-ON Almond Rush");
    });

    test("getProducts list", () async {
      when(apiMock.searchProducts(any, any)).thenAnswer((_) async {
        final Map<String, dynamic> nutriments = {};

        final Map<String, dynamic> products = {
          "product_name": "E-ON Almond Rush",
          "ingredients": [],
          "nutriments": nutriments,
        };

        final Map<String, dynamic> productJson = {
          "status": "success",
          "product": products,
        };

        final Map<String, dynamic> searchResult = {
          "products": [productJson, productJson],
        };

        return SearchResult.fromJson(searchResult);
      });

      final ret = await getProductsByCategory(PnnsGroup2.MILK_AND_YOGURT);
      expect(ret.length, 2);
    });
  });
}
