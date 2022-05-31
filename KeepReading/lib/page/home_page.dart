import 'package:flutter/material.dart';
import 'package:keep_reading/API/file_manager.dart';
import 'package:keep_reading/API/update_manager.dart';
import 'package:keep_reading/main.dart';
import 'package:keep_reading/page/nofile_page.dart';
import 'package:keep_reading/page/pdfviewer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.appName,
  }) : super(key: key);

  final String appName;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _filePath = "";

  // at start is a CircularProgressIndicator then check if file exists
  // and it can be a PDFViewerPage or NoFilePage
  Widget _body = const CircularProgressIndicator();

  @override
  void initState() {
    isFileSaved();
    super.initState();
  }

  //**
  // * Set the state for display pdf reader
  // * The file is present in the local storage and _body = PDFViewer
  // * void
  // */
  void setStateFile(String path) {
    setState(() {
      _filePath = path;

      _body = PDFViewer(
        appName: appName,
        deleteFile: deleteFile,
        filePath: _filePath,
        updateCallback: _checkUpdateOnStart,
      );
    });
  }

  //**
  // * Set the state for display pdf selector page
  // * The file is NOT present in the local storage and _body = NoFilePage
  // * void
  // */
  void setStateNoFile() {
    setState(() {
      _filePath = "";

      _body = NoFilePage(
        appName: appName,
        notifyParent: fileLoaded,
        deleteFile: deleteFile,
        updateCallback: _checkUpdateOnStart,
      );
    });
  }

  //**
  //  * Notify that the file has been loaded
  //  * Updates the state of the widget
  //  * Passed to the child widgets
  // */
  void fileLoaded() {
    FileManager.getFilePath().then((path) {
      setStateFile(path);
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
      setStateNoFile();
    }

    return result;
  }

  //**
  //  * Check if the file exists in private storage
  //  * if so update the state of the widget
  //  * void
  // */
  void isFileSaved() async {
    final bool result = await FileManager.existsManual();

    (result) ? fileLoaded() : setStateNoFile();
  }

  //**
  //  * Check if the app has an update
  //  * only on the first time the app is opened
  //  * void
  // */
  void _checkUpdateOnStart() async {
    if (!UpdateManager.reCheckingUpdate &&
        await UpdateManager.isUpdateAvailable()) {
      UpdateManager.showNewUpdateMessage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body;
  }
}
