import 'package:easy_localization/easy_localization.dart';
import 'package:fitmate/bloc/api/api_bloc.dart';
import 'package:fitmate/bloc/search/search_bloc.dart';
import 'package:fitmate/screen/scanner.dart';
import 'package:fitmate/translations/locale_keys.g.dart';
import 'package:fitmate/util/theme_button.dart';
import 'package:flutter/material.dart';
import 'package:fitmate/screen/search.dart';
import 'package:fitmate/screen/filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ScreensState createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  List<Widget> pages = [
    const Home(),
    // const about(),
    const BarcodeScannerWidget(),
  ];

  int index = 0;

  void choose(int selectedIndex) {
    setState(() {
      index = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiBloc = context.read<ApiBloc>();
    final searchBloc = context.read<SearchBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text("Fitmate"), actions: [
        index == 0
            ? Row(
                children: [
                  const ThemeButton(),
                  const SizedBox(width: 15),
                  IconButton(
                    onPressed: () {
                      if (context.locale == const Locale('ru')) {
                        context.setLocale(const Locale('en'));
                      } else {
                        context.setLocale(const Locale('ru'));
                      }
                    },
                    icon: const Icon(Icons.language),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                    value: searchBloc,
                                    child: const SearchPage(),
                                  )),
                        );
                      },
                      icon: const Icon(Icons.search)),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                    value: apiBloc,
                                    child: const FilterPage(),
                                  )),
                        );
                      },
                      // ignore: prefer_const_constructors
                      icon: Icon(Icons.filter_alt_outlined)),
                  const SizedBox(
                    width: 20,
                  )
                ],
              )
            : Container()
      ]),
      body: pages.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_max_outlined),
              label: LocaleKeys.home.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.camera_alt_outlined),
              label: LocaleKeys.scanner.tr()),
        ],
        currentIndex: index,
        selectedItemColor: Colors.blue,
        onTap: choose,
      ),
    );
  }
}
