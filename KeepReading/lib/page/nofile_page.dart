import 'package:flutter/material.dart';
import 'package:keep_reading/API/file_manager.dart';
import 'package:keep_reading/widget/appbar.dart';

class NoFilePage extends StatelessWidget {
  const NoFilePage({
    Key? key,
    required this.appName,
    required this.notifyParent,
    required this.deleteFile,
    required this.updateCallback,
  }) : super(key: key);

  final String appName;
  final Function notifyParent;
  final Function deleteFile;
  final Function updateCallback;

  @override
  Widget build(BuildContext context) {
    updateCallback();

    return Scaffold(
      //backgroundColor: const Color.fromRGBO(224, 224, 224, 1.0),
      appBar: MyAppBar(
        appName: appName,
        deleteFile: deleteFile,
        deleteEnabled: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/button_icons/noFile2.png',
                width: 300,
                height: 300,
              ),
              const Text(
                'No Manual Found !' '\n',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  bool result = await FileManager.pickAndSave();

                  if (result) {
                    notifyParent();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Uploaded Manual Successfully 👍"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Choose a file '),
                    Icon(Icons.upload),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  padding: const EdgeInsets.all(12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
