import 'package:easy_localization/easy_localization.dart';
import 'package:fitmate/models/product_data.dart';
import 'package:fitmate/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fitmate/bloc/theme/theme_cubit.dart';
import 'package:fitmate/models/nutriments_data.dart';


class ProductAbout extends StatefulWidget {
  const ProductAbout({super.key, required this.productData});

  final ProductData productData;

  @override
  State<ProductAbout> createState() => _ProductAboutState();
}

class _ProductAboutState extends State<ProductAbout> {
  bool _showIngredients = true;

  void _toggleButton(int index) {
    setState(() {
      _showIngredients = index == 0;
    });
  }

  Widget buildIngredients(BuildContext context) {
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

  Widget buildNutriments(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (NutrimentsData nutriment in widget.productData.nutriments)
                  if (double.parse(nutriment.quantity ?? "0") != 0.0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getHumanReadableNutriment(nutriment.type),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Text(
                          '${nutriment.quantity}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
              ],
            ),
            if (canBuildPieChart(widget.productData.nutriments))
              PieChart(
                dataMap: buildPieChart(widget.productData.nutriments),
                animationDuration: const Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3.2,
              )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: false);
    var productImage = widget.productData.productImage ?? "";
    var productName = widget.productData.productName ?? LocaleKeys.no_name.tr();
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: themeCubit.isDark ? const Color.fromRGBO(66, 66, 66, 1): Colors.white,
        borderRadius: const BorderRadius.only(
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
              Center(
                  child: FadeInImage.assetNetwork(
                placeholder: "assets/images/default_product.png",
                image: productImage,
                fit: BoxFit.contain,
                height: 200,
                imageErrorBuilder: (context, object, stacktrace) {
                  return Image.asset(
                    "assets/images/default_product.png",
                    fit: BoxFit.contain,
                    height: 200,
                    color: themeCubit.isDark ? Colors.white : Colors.black
                  );
                },
              )),
              const SizedBox(height: 16),
              Text(
                productName,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Center(child: LayoutBuilder(
                builder: (context, constraints) {
                  return ToggleButtons(
                      isSelected: [_showIngredients, !_showIngredients],
                      fillColor: themeCubit.isDark ? Colors.white : Colors.blue,
                      selectedBorderColor: themeCubit.isDark ? Colors.white : Colors.blue,
                      selectedColor: themeCubit.isDark ? Colors.black : Colors.white,
                      onPressed: _toggleButton,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      constraints: BoxConstraints.expand(
                          width: constraints.maxWidth / 2 - 3),
                      children: [
                        Text(LocaleKeys.ingredients.tr(),
                            style: const TextStyle(fontSize: 20)),
                        Text(
                          LocaleKeys.nutriments.tr(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ]);
                },
              )),
              const SizedBox(height: 16),
              _showIngredients
                  ? buildIngredients(context)
                  : buildNutriments(context)
            ],
          ),
        ),
      ),
    );
  }
}
