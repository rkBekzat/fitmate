import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme/theme_cubit.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({super.key, required this.name, required this.image});

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    var displayName = name;
    // If the name has more than 20 chars, display only first 20 chars
    if (name.length > 20) {
      displayName = "${name.substring(0, 20)}...";
    }
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/images/default_product.png",
                    image: image,
                    fit: BoxFit.contain,
                    imageErrorBuilder: (context, object, stacktrace) {
                      return Image.asset("assets/images/default_product.png",
                          fit: BoxFit.contain,
                          color:
                              themeCubit.isDark ? Colors.white : Colors.black);
                    },
                  ))),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(displayName)],
            ),
          )
        ],
      ),
    );
  }
}
