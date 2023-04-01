import 'package:fitmate/screen/about.dart';
import 'package:fitmate/screen/home.dart';
import 'package:fitmate/screen/scanner.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  List<Widget> pages = [
    home(),
    about(),
    scanner(),
  ];

  int index = 0;
  // This widget is the root of your application.

  void choose(int selectedIndex){
    setState(() {
      index = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitmate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Fitmate"),
        ),
        body: pages.elementAt(index),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_max_outlined),
              label: 'home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
              label: 'about',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt_outlined),
              label: 'scanner'
            ),
          ],
          currentIndex: index,
          selectedItemColor: Colors.blue,
          onTap: choose,
        ),
      )
    );
  }
}
