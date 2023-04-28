import 'package:flutter/material.dart';

import '../screen/filter.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            // Open a filter page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FilterPage()),
            );
          },
          child: Text('Filters'),
        ),
      ],
    );
  }
}
