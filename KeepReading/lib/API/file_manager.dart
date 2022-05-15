import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static const String _fileName = 'manual.pdf';

  //**
  //  * Returns the path of the manual
  //  * String
  // */
  static Future<String> getFilePath() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  //**
  //  * Try to delete the manual
  //  * void
  // */
  static void deleteManual() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$_fileName');

    try {
      await file.delete();
    } catch (e) {
      return;
    }
  }

  //**
  //  * Return True if the manual exists in the private memory
  //  * bool
  // */
  static Future<bool> existsManual() async {
    final Directory directory = await getApplicationDocumentsDirectory();

    final String file = '${directory.path}/$_fileName';

    return await File(file).exists();
  }

  //**
  //  * Return the that the user has selected (only ONE PDF)
  //  * Could be null if the user has not selected anything
  //  * File?
  // */
  static Future<File?> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) {
      return null;
    }

    return File(result.files.single.path!);
  }

  //**
  //  * Try to save given file to the private memory
  //  * If success return TRUE else FALSE
  //  * bool
  // */
  static Future<bool> _saveFile(File? file) async {
    if (file == null) {
      return false;
    }

    final Directory directory = await getApplicationDocumentsDirectory();

    final String newPath = '${directory.path}/$_fileName';
    await file.copy(newPath);

    return true;
  }

  //**
  //  * Let the user select a file and save it to the private memory
  //  * If success return TRUE else FALSE
  //  * bool
  // */
  static Future<bool> pickAndSave() async {
    File? file = await _pickFile();

    if (file == null) {
      return false;
    }

    return await _saveFile(file);
  }
}
