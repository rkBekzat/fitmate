import 'package:fitmate/bloc/api/api_bloc.dart';
import 'package:fitmate/bloc/barcode/barcode_bloc.dart';
import 'package:fitmate/bloc/internet/internet_cubit.dart';
import 'package:fitmate/screen/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.,
  // );

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fitmate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ru'),
        ],
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
          child: const Screens(),
        ));
  }
}
