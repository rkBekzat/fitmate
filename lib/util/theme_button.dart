import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fitmate/bloc/theme/theme_cubit.dart';

class ThemeButton extends StatefulWidget {
  const ThemeButton({Key? key}) : super(key: key);

  @override
  State<ThemeButton> createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton> {
  @override
  Widget build(BuildContext context) {
    ThemeCubit themeCubit = BlocProvider.of<ThemeCubit>(context, listen: true);
    return IconButton(
        onPressed: () {
          setState(() {
            themeCubit.changeTheme();
          });
        },
        icon: Icon(themeCubit.isDark ? Icons.wb_sunny : Icons.brightness_2));
  }
}
