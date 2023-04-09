import 'package:fitmate/bloc/api/api_bloc.dart';
import 'package:fitmate/bloc/barcode/barcode_bloc.dart';
import 'package:fitmate/bloc/internet/internet_cubit.dart';
import 'package:fitmate/screen/home.dart';
import 'package:fitmate/screen/scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp

  ({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  List<Widget> pages = [
    const Home(),
    // const about(),
    const BarcodeScannerWidget(),
  ];

  int index = 0;

  // This widget is the root of your application.

  void choose(int selectedIndex) {
    setState(() {
      index = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fitmate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<InternetCubit>(
              create: (_) => InternetCubit(),
            ),
            BlocProvider<BarcodeBloc>(
              create: (context) => BarcodeBloc(),
            ),
            BlocProvider<ApiBloc>(
                create: (context) => ApiBloc(),
            ),
          ],
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Fitmate"),
            ),
            body: pages.elementAt(index),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_max_outlined),
                    label: 'home'
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
          ),
        )
    );
  }
}
