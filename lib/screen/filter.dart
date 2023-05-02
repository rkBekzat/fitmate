import 'package:easy_localization/easy_localization.dart';
import 'package:fitmate/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/api/api_bloc.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues sugarValues = const RangeValues(0, 500);
  RangeValues proteinValues = const RangeValues(0, 500);
  RangeValues carboValues = const RangeValues(0, 500);
  RangeValues fatValues = const RangeValues(0, 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.filter.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.filtering.tr()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(LocaleKeys.sugar.tr()),
                RangeSlider(
                    values: sugarValues,
                    min: 0,
                    max: 1000,
                    onChanged: (value) => setState(() {
                          sugarValues = value;
                        })),
                Text(
                    "${sugarValues.start.round()} - ${sugarValues.end.round()} g")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(LocaleKeys.protein.tr()),
                RangeSlider(
                    values: proteinValues,
                    min: 0,
                    max: 1000,
                    onChanged: (value) => setState(() {
                          proteinValues = value;
                        })),
                Text(
                    "${proteinValues.start.round()} - ${proteinValues.end.round()}  ${LocaleKeys.g.tr()}")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(LocaleKeys.fat.tr()),
                RangeSlider(
                    values: fatValues,
                    min: 0,
                    max: 1000,
                    onChanged: (value) => setState(() {
                          fatValues = value;
                        })),
                Text(
                    "${fatValues.start.round()} - ${fatValues.end.round()}  ${LocaleKeys.g.tr()}")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(LocaleKeys.carbohydrates.tr()),
                RangeSlider(
                    values: carboValues,
                    min: 0,
                    max: 1000,
                    onChanged: (value) => setState(() {
                          carboValues = value;
                        })),
                Text(
                    "${carboValues.start.round()} - ${carboValues.end.round()}  ${LocaleKeys.g.tr()}")
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  final filterBloc = context.read<ApiBloc>();
                  filterBloc.add(FilterProductAPIEvent(
                      sugarValues: sugarValues,
                      proteinValues: proteinValues,
                      carboValues: carboValues,
                      fatValues: fatValues));
                  Navigator.pop(context);
                },
                child: Text(LocaleKeys.done.tr()))
          ],
        ),
      ),
    );
  }
}
