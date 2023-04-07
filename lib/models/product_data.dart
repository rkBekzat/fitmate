import 'package:fitmate/models/nutriments_data.dart';

class ProductData {
  ProductData({
    required this.productName,
    required this.productImage,
    required this.ingredients,
    required this.nutriments,
  });

  final String? productName;
  final String? productImage;
  final List<String?> ingredients;
  final List<NutrimentsData> nutriments;
}