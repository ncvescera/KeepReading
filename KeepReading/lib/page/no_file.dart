import 'package:flutter/material.dart';
import 'package:keep_reading/API/file_manager.dart';
import 'package:keep_reading/widget/appbar.dart';

class NoFilePage extends StatelessWidget {
  const NoFilePage(
      {Key? key, required this.notifyParent, required this.deleteFile})
      : super(key: key);

  final Function notifyParent;
  final Function deleteFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 224, 224, 1.0),
      appBar: AppBarGenerator.mainAppBar(context, 'KeepReading ', deleteFile),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/button_icons/noFile.png',
                width: 300,
                height: 300,
              ),
              const Text('No Manual Found !' '\n',
                  style: TextStyle(
                    fontSize: 24,
                  )),
              ElevatedButton(
                onPressed: () async {
                  bool result = await pickAndSave();

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
                child: const Text('Choose a file'),
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
