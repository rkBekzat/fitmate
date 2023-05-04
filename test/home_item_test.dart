import 'package:fitmate/bloc/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitmate/util/home_item.dart';


void main() {

  group('HomeItem', (){
    testWidgets('HomeItem should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<ThemeCubit>(
              create: (_) => ThemeCubit(),
              child: const MaterialApp(home: Scaffold(
                  body: HomeItem(
                      name: 'Product Name',
                      image: 'https://images.openfoodfacts.org/images/products/460/711/789/2113/front_ru.28.400.jpg')))));

      // Verify that the Card widget is present
      expect(find.byType(Card), findsOneWidget);

      // Verify that the image is displayed
      expect(find.byType(FadeInImage), findsOneWidget);

      // Verify that the display name is correct
      expect(find.text('Product Name'), findsOneWidget);
    });


    testWidgets('HomeItem should truncate name if it is longer than 20 chars',
            (WidgetTester tester) async {
          await tester.pumpWidget(BlocProvider<ThemeCubit>(
              create: (_) => ThemeCubit(),
              child: const MaterialApp(home: Scaffold(
                  body: HomeItem(
                      name: 'Product Name That Is Longer Than 20 Characters',
                      image: 'https://images.openfoodfacts.org/images/products/460/711/789/2113/front_ru.28.400.jpg')))));

          // Verify that the display name is truncated
          expect(find.text('Product Name That Is...'), findsOneWidget);
        });


    testWidgets('HomeItem should display default image when image URL is invalid',
            (WidgetTester tester) async {
          await tester.pumpWidget(BlocProvider<ThemeCubit>(
              create: (_) => ThemeCubit(),
              child: const MaterialApp(home: Scaffold(
                  body: HomeItem(
                      name: 'Product Name',
                      image: 'blah blah blah incorrect image link')))));

          // Verify that the default image is displayed
          expect(find.byWidgetPredicate(
                  (widget) => widget is Image && widget.image is AssetImage &&
                  (widget.image as AssetImage).assetName == 'assets/images/default_product.png'), findsOneWidget);
        });
  });
}
