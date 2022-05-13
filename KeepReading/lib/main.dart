import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keep_reading/pdf_viewer.dart';

const appName = 'KeepReading ';

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
          color: Colors.red,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.red, // Navigation bar
            statusBarColor: Colors.red, // Status bar
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          brightness: Brightness.light,
        ),
      ),
      home: const PDFViewer(appName: appName),
    );
  }
}
