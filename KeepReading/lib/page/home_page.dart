import 'package:flutter/material.dart';
import 'package:keep_reading/API/file_manager.dart';
import 'package:keep_reading/main.dart';
import 'package:keep_reading/page/noFile_page.dart';
import 'package:keep_reading/page/pdfviewer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.appName}) : super(key: key);

  final String appName;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool fileExists = false;
  String filePath = "";

  //**
  //  * Notify that the file has been loaded
  //  * Updates the state of the widget
  //  * Passed to the child widgets
  // */
  void fileLoaded() {
    FileManager.getFilePath().then((path) {
      setState(() {
        fileExists = true;
        filePath = path;
      });
    });
  }

  //**
  //  * Delete the manual and update the state of the widget
  //  * Return True if the file was deleted successfully else false
  //  * bool
  // */
  Future<bool> deleteFile() async {
    bool result = await FileManager.deleteManual();

    if (result) {
      setState(() {
        fileExists = false;
        filePath = "";
      });
    }

    return result;
  }

  void isFileSaved() async {
    final bool result = await FileManager.existsManual();

    if (result) {
      fileLoaded();
    }
  }

  @override
  void initState() {
    isFileSaved();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (fileExists)
        ? PDFViewer(
            appName: appName,
            deleteFile: deleteFile,
            filePath: filePath,
          )
        : NoFilePage(
            appName: appName,
            notifyParent: fileLoaded,
            deleteFile: deleteFile,
          );
  }
}
