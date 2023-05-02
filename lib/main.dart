import 'package:fitmate/bloc/api/api_bloc.dart';
import 'package:fitmate/bloc/barcode/barcode_bloc.dart';
import 'package:fitmate/bloc/internet/internet_cubit.dart';
import 'package:fitmate/screen/screens.dart';
import 'package:fitmate/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/search/search_bloc.dart';
import 'firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.,
  // );

  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path:
            'assets/translations', // <-- change the path of the translation files
        fallbackLocale: const Locale('en', 'US'),
        assetLoader: const CodegenLoader(),
        child: const MyApp()),
  );
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
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
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
            BlocProvider<SearchBloc>(
              create: (context) => SearchBloc(),
            ),
          ],
          child: const Screens(),
        ));
  }
}
