import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep_reading/page/home_mage.dart';

const appName = 'KeepReading ';
const barColor = Color.fromARGB(255, 190, 18, 6);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: barColor,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: barColor, // Navigation bar
            statusBarColor: barColor, // Status bar
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          brightness: Brightness.light,
        ),
      ),
      home: const HomePage(appName: appName),
    );
  }
}
