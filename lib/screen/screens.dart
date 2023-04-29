import 'package:fitmate/bloc/search/search_bloc.dart';
import 'package:fitmate/screen/scanner.dart';
import 'package:flutter/material.dart';
import 'package:fitmate/screen/search.dart';
import 'package:fitmate/screen/filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../bloc/api/api_bloc.dart';
import 'home.dart';

class Screens extends StatefulWidget {
  const Screens({Key? key}) : super(key: key);

  @override
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
    return Scaffold(
      appBar: AppBar(
          title: const Text("Fitmate"),
          actions: [
            index == 0 ? Row(
              children: [
                IconButton(
                    onPressed: () {
                      final searchBloc = context.read<ApiBloc>();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            BlocProvider<SearchBloc>(
                              create: (context) => SearchBloc(),
                              child: SearchPage(),
                            )),
                      );
                    },
                    icon: Icon(Icons.search)),
                SizedBox(width: 15,),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FilterPage()),
                      );
                    },
                    icon: Icon(Icons.filter_alt_outlined)),
                SizedBox(width: 20,)
              ],
            ) : Container()
          ]
      ),
      body: pages.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_max_outlined), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined), label: 'scanner'),
        ],
        currentIndex: index,
        selectedItemColor: Colors.blue,
        onTap: choose,
      ),
    );
  }
}
