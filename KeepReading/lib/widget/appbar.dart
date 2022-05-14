import 'package:flutter/material.dart';
import 'package:keep_reading/page/about_page.dart';

class AppBarGenerator {
  static mainAppBar(BuildContext context, String appName, Function deleteFile) {
    return AppBar(
      title: Row(
        children: [
          const Text('KeepReading '),
          Image.asset('assets/icon/icon.png', width: 30, height: 30),
        ],
      ),
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            switch (value) {
              case 'remove':
                deleteFile();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Deleted Manual Successfully 👍"),
                    duration: Duration(seconds: 1),
                  ),
                );
                break;
              case 'about':
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
                break;
              default:
                return;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              value: 'remove',
              child: Row(
                children: const [
                  Text('Remove Manual '),
                  Icon(Icons.delete, color: Colors.red),
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
      ],
    );
  }
}
