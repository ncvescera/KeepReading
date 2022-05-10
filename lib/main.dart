import 'package:flutter/material.dart';
import 'package:keep_reading/pdf_viewer.dart';

const appName = 'Keep Reading ';

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
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          //accentColor: Colors.accents[10],
        ),
      ),
      home: const PDFViewer(appName: appName),
    );
  }
}
