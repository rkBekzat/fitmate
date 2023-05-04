import 'package:fitmate/bloc/api/api_bloc.dart';
import 'package:fitmate/bloc/barcode/barcode_bloc.dart';
import 'package:fitmate/bloc/internet/internet_cubit.dart';
import 'package:fitmate/screen/screens.dart';
import 'package:fitmate/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitmate/bloc/search/search_bloc.dart';
import 'package:fitmate/bloc/theme/theme_cubit.dart';
import 'firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:easy_localization/easy_localization.dart';
import 'api/api.dart';
import 'package:get_it/get_it.dart';

void main() async {
  GetIt.instance.registerSingleton<ApiHelper>(ApiHelper());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (_) => ThemeCubit(),
          ),
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
        child: EasyLocalization(
            supportedLocales: const [Locale('en'), Locale('ru')],
            path: 'assets/translations',
            fallbackLocale: const Locale('en', 'US'),
            assetLoader: const CodegenLoader(),
            child: const MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen:true);
    return MaterialApp(
        title: 'Fitmate',
        debugShowCheckedModeBanner: false,
        theme: theme.isDark ? ThemeData.dark() : ThemeData.light(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const Screens());
  }
}
