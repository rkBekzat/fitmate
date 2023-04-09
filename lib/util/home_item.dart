import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    required this.name,
    required this.image
});

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    var displayName = name;
    // If the name has more than 20 chars, display only first 20 chars
    if(name.length > 20 ){
      displayName = "${name.substring(0, 20)}...";
    }
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.network(image, fit:BoxFit.contain)
              )
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(displayName)
              ],
            ),
          )
        ],
      ),
    );
  }
}
