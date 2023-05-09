import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:listify/views/screens/splash_screen/splash_screen.dart';

void main() {
  group('Splash Screen test', () {
    testWidgets('Test whether the SplashScreen is rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SplashScreen(),
      ));
      expect(find.byType(SplashScreen), findsOneWidget);
    });

    // App Bar title Test
    testWidgets('Test whether the description is exist',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
      expect(find.text('Listify'), findsOneWidget);
      expect(find.text('Your Friendly Shopping List App'), findsOneWidget);
    });
  });
}
