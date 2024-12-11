import 'package:covid_appdart/View/splashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme:
            ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
        darkTheme:
            ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
  }
}
