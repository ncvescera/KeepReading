import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UpdateManager {
  static final Uri _latestReleaseURL = Uri.parse(
      'https://api.github.com/repos/ncvescera/KeepReading/releases/latest');

  //**
  //  * Return the app version from pubspec.yaml
  //  * String
  // */
  static Future<String> getAppVersion() async {
    PackageInfo package = await PackageInfo.fromPlatform();

    return package.version;
  }

  static Future<void> checkForUpdates(BuildContext context) async {
    // get the latest release from GitHub data
    final http.Response response = await http.get(_latestReleaseURL);
    final Map<String, dynamic> responseJson = json.decode(response.body);

    // get the latest release version, url and currentVersion
    final String gitHubLastReleaseVersion =
        responseJson['tag_name'].substring(1);
    final Uri updateUrl = Uri.parse(responseJson['html_url']);
    final String currentVersion = await getAppVersion();

    // alredy up to date
    if (currentVersion.compareTo(gitHubLastReleaseVersion) >= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You are on the latest version ❤️"),
          duration: Duration(seconds: 2),
        ),
      );

      return;
    }

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update available 💪'),
          content: const Text(
            'An update is available. Do you want to update?\n\nYou are going to be redirected to github.com',
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('No'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop();

                // open github
                if (!await launchUrl(updateUrl,
                    mode: LaunchMode.externalApplication)) {
                  throw 'Could not launch $updateUrl';
                }
              },
            ),
          ],
        );
      },
    );
  }
}
