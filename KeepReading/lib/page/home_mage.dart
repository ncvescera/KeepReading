import 'package:flutter/material.dart';
import 'package:keep_reading/API/file_manager.dart';
import 'package:keep_reading/main.dart';
import 'package:keep_reading/page/about_page.dart';
import 'package:keep_reading/page/no_file.dart';
import 'package:keep_reading/page/pdf_viewer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.appName}) : super(key: key);

  final String appName;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool fileExists = false;

  void fileLoaded() {
    setState(() {
      fileExists = true;
    });
  }

  void deleteFile() {
    deleteManual();
    setState(() {
      fileExists = false;
    });
  }

  void checkFile() async {
    final bool result = await existsManual();

    if (result) {
      fileLoaded();
    }
  }

  @override
  void initState() {
    checkFile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (fileExists)
        ? PDFViewer(
            appName: appName,
            deleteFile: deleteFile,
          )
        : NoFilePage(
            notifyParent: fileLoaded,
            deleteFile: deleteFile,
          );
  }
}
