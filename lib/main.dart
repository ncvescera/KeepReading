import 'package:flutter/material.dart';
import 'package:my_app/pdf_viewer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final appName = 'Keep Reading 💣';

  @override
  Widget build(BuildContext context) {
    PDFViewer pdfviewer = PDFViewer();

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
          //accentColor: Colors.accents[10],
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(appName),
        ),
        body: Container(
          child: pdfviewer,
        ),
        bottomNavigationBar: BottomAppBar(
          //color: Color.fromARGB(255, 75, 162, 206),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  pdfviewer.jumpToPage(10);
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  pdfviewer.jumpToPage(20);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
