import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int sortType = 0;
  RangeValues sugarValues = const RangeValues(0, 500);
  RangeValues proteinValues = const RangeValues(0, 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sorting"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    sortType = 1;
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: sortType == 1 ? Colors.blue : Colors.grey,
                  ),
                  child: const Text("Relevent"),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    sortType = 2;
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: sortType == 2 ? Colors.blue : Colors.grey,
                  ),
                  child: const Text("Ascending order"),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    sortType = 3;
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: sortType == 3 ? Colors.blue : Colors.grey,
                  ),
                  child: const Text("descending order"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Filtering"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Sugar"),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Protein"),
                RangeSlider(
                    values: proteinValues,
                    min: 0,
                    max: 1000,
                    onChanged: (value) => setState(() {
                          proteinValues = value;
                        })),
                Text(
                    "${proteinValues.start.round()} - ${proteinValues.end.round()}  g")
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Done"))
          ],
        ),
      ),
    );
  }
}
