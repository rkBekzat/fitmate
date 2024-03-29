import 'package:easy_localization/easy_localization.dart';
import 'package:fitmate/translations/locale_keys.g.dart';

class NutrimentsData {
  NutrimentsData({
    required this.type,
    required this.quantity,
  });

  final String? type;
  final String? quantity;

  @override
  String toString() {
    return '$type $quantity';
  }
}

String getHumanReadableNutriment(String? key) {
  var parts = key?.split('_') ?? ['', ''];
  var result = '';
  if (nutrimentKeyStringMap.containsKey(parts[0])) {
    var translateKey = parts[0].replaceAll('-', '_');
    result += tr(translateKey);
  }
  if (parts[1] == 'serving') {
    result += ' (${LocaleKeys.survey.tr()})';
  } else {
    result += ' (100${LocaleKeys.g.tr()})';
  }
  return result;
}

bool canBuildPieChart(List<NutrimentsData> list) {
  for (NutrimentsData i in list) {
    if (i.type?.contains('energy-kj') == true) continue;
    if (i.type?.contains('energy-kcal') == true) continue;
    if (i.type?.contains('100g') == true) return true;
  }
  return false;
}

Map<String, double> buildPieChart(List<NutrimentsData> list) {
  Map<String, double> res = {};
  for (NutrimentsData i in list) {
    if (i.type?.contains('energy-kj') == true) continue;
    if (i.type?.contains('energy-kcal') == true) continue;
    if (i.type?.contains('100g') == true) {
      res[getHumanReadableNutriment(i.type)] = double.parse(i.quantity ?? '');
    }
  }
  return res;
}

const nutrimentKeyStringMap = {
  'salt': 'Salt',
  'fiber': 'Fiber',
  'sugars': 'Sugars',
  'fat': 'Fat',
  'saturated-fat': 'Saturated fat',
  'proteins': 'Proteins',
  'nova-group': 'Nova group',
  'energy': 'Energy',
  'energy-kj': 'Energy KJ',
  'energy-kcal': 'Energy KCal',
  'carbohydrates': 'Carbohydrates',
  'caffeine': 'Caffeine',
  'calcium': 'Calcium',
  'iron': 'Iron',
  'vitamin-c': 'Vitamin C',
  'magnesium': 'Magnesium',
  'phosphorus': 'Phosphorus',
  'potassium': 'Potassium',
  'sodium': 'Sodium',
  'zinc': 'Zinc',
  'copper': 'Copper',
  'selenium': 'Selenium',
  'vitamin-a': 'Vitamin A',
  'vitamin-e': 'Vitamin E',
  'vitamin-d': 'Vitamin D',
  'vitamin-b1': 'Vitamin B1',
  'vitamin-b2': 'Vitamin B2',
  'vitamin-pp': 'Vitamin PP',
  'vitamin-b6': 'Vitamin B6',
  'vitamin-b12': 'Vitamin B12',
  'vitamin-b9': 'Vitamin B9',
  'vitamin-k': 'Vitamin K',
  'cholesterol': 'Cholesterol',
  'butyric-acid': 'Butyric Acid',
  'caproic-acid': 'Caproic Acid',
  'caprylic-acid': 'Caprylic Acid',
  'capric-acid': 'Capric Acid',
  'lauric-acid': 'Lauric Acid',
  'myristic-acid': 'Mytistic Acid',
  'palmitic-acid': 'Palmitic Acid',
  'stearic-acid': 'Stearic Acid',
  'oleic-acid': 'Oleic Acid',
  'linoleic-acid': 'Linoleic Acid',
  'docosahexaenoic-acid': 'Docosahexaenoic Acid',
  'eicosapentaenoic-acid': 'Eicosapentaenoic Acid',
  'erucic-acid': 'Erucic Acid',
  'monounsaturated': 'Monounsaturated Fat',
  'polyunsaturated': 'Polyunsaturated Fat',
  'alcohol': 'Alcohol',
  'pantothenic-acid': 'Pantothenic Acid',
  'biotin': 'Biotin',
  'chloride': 'Chloride',
  'chromium': 'Chromium',
  'fluoride': 'Fluoride',
  'iodine': 'Iodine',
  'manganese': 'Manganese',
  'molybdenum': 'Molybdenum',
  'omega-3-fat': 'Omega-3 Fat',
  'omega-6-fat': 'Omega-6 Fat',
  'trans-fat': 'Trans Fat'
};
