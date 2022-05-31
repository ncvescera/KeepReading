import 'package:flutter/material.dart';
import 'package:keep_reading/API/update_manager.dart';
import 'package:keep_reading/page/about_page.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.appName,
    required this.deleteFile,
    this.showMenuButton = true,
    this.deleteEnabled = true,
    this.updateEnabled = true,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  final String appName;
  final bool showMenuButton;
  final bool deleteEnabled;
  final bool updateEnabled;
  final Future<bool> Function() deleteFile;

  @override
  final Size preferredSize; // default is 56.0

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  //**
  //  * Delete the manual and show a snackbar
  //  * Execute the passed function (delete file and update status) and if successful, show a snackbar
  //  * void
  // */
  void _deleteFile(
      BuildContext context, Future<bool> Function() deleteCall) async {
    bool result = await deleteCall(); // true if file was deleted

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Deleted Manual Successfully 👍"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Manual to Delete 🙃"),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          const Text('KeepReading '),
          Image.asset('assets/icon/icon.png', width: 30, height: 30),
        ],
      ),
      actions: (widget.showMenuButton)
          ? [
              PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case 'remove':
                      _deleteFile(context, widget.deleteFile);
                      break;
                    case 'update':
                      UpdateManager.checkForUpdates(context);
                      break;
                    case 'about':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutPage(),
                        ),
                      );
                      break;
                    default:
                      return;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    enabled: widget.deleteEnabled,
                    value: 'remove',
                    child: Row(
                      children: const [
                        Text('Remove Manual '),
                        Icon(Icons.delete, color: Colors.red),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    enabled: widget.updateEnabled,
                    value: 'update',
                    child: Row(
                      children: const [
                        Text('Update Check '),
                        Icon(Icons.cloud_sync_sharp, color: Colors.blue),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'about',
                    child: Row(
                      children: const [
                        Text('About '),
                        Icon(Icons.info, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              )
            ]
          : [],
    );
  }
}
