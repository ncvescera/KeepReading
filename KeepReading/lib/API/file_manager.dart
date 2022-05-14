import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

const String fileName = 'manual.pdf';

void deleteManual() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/$fileName');
  file.delete();
}

Future<bool> existsManual() async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String path = directory.path;

  final String file = '$path/${fileName}';

  return await File(file).exists();
}

Future<File?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );

  if (result == null) {
    return null;
  }

  return File(result.files.single.path!);
}

Future<bool> saveFile(File? file) async {
  if (file == null) {
    return false;
  }

  final Directory directory = await getApplicationDocumentsDirectory();
  final String path = directory.path;

  final String newPath = '$path/${fileName}';
  await file.copy(newPath);

  return true;
}

Future<bool> pickAndSave() async {
  File? file = await pickFile();

  if (file == null) {
    return false;
  }

  return await saveFile(file);
}
