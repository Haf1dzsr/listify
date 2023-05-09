import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:listify/firebase_options.dart';
import 'package:listify/provider/shopping_item_provider.dart';
import 'package:listify/provider/shopping_plan_provider.dart';
import 'package:listify/views/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShoppingPlanProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShoppingItemProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const SplashScreen(),
      ),
    );
  }
}
