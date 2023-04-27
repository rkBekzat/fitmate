import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  int sortType = 0;
  RangeValues sugarValues = RangeValues(0, 500);
  RangeValues proteinValues = RangeValues(0, 500);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Sorting"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {sortType = 1; setState(() {});},
                  child: Text("Relevent"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: sortType == 1 ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(width: 15,),
                ElevatedButton(
                    onPressed: () {sortType = 2; setState(() {});},
                    child: Text("Ascending order"),
                    style: ElevatedButton.styleFrom(
                    backgroundColor: sortType == 2 ? Colors.blue : Colors.grey,
                  ),
                ),
                SizedBox(width: 15,),
                ElevatedButton(
                    onPressed: () {sortType = 3; setState(() {});},
                    child: Text("descending order"),
                    style: ElevatedButton.styleFrom(
                    backgroundColor: sortType == 3 ? Colors.blue : Colors.grey,
                ),),
              ],
            ),
            SizedBox(height: 20,),
            Text("Filtering"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sugar"),
                RangeSlider(
                    values: sugarValues,
                    min: 0,
                    max: 1000,
                    onChanged: (value) => setState(() {
                      this.sugarValues = value;
                    })),
                Text("${sugarValues.start.round()} - ${sugarValues.end.round()} g")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Protein"),
                RangeSlider(
                    values: proteinValues,
                    min: 0,
                    max: 1000,
                    onChanged: (value) => setState(() {
                      this.proteinValues = value;
                    })),
                Text("${proteinValues.start.round()} - ${proteinValues.end.round()}  g")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
