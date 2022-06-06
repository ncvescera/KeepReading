import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class UpdateManager {
  static final Uri _latestReleaseURL = Uri.parse(
      'https://api.github.com/repos/ncvescera/KeepReading/releases/latest');

  static Uri _updateUrl = Uri.parse('');
  static bool reCheckingUpdate = false;

  //**
  //  * Return the app version from pubspec.yaml
  //  * String
  // */
  static Future<String> getAppVersion() async {
    PackageInfo package = await PackageInfo.fromPlatform();

    return package.version;
  }

  //**
  //  * Try to launch the given url in external browser
  //  * Return true if the url was opened successfully else false
  //  * bool
  // */
  static Future<bool> openUrl(Uri url) async {
    bool result = false;

    // menage the possible exception
    try {
      result = await launchUrl(url, mode: LaunchMode.externalApplication);
      debugPrint('Launched $url');
    } catch (e) {
      debugPrint('Could not launch url: $url');
    }

    return result;
  }

  static Future<bool> isUpdateAvailable() async {
    reCheckingUpdate = true; // called first time when update check in bg

    // get the latest release from GitHub data
    final http.Response response = await http.get(_latestReleaseURL);
    final Map<String, dynamic> responseJson = json.decode(response.body);

    // get the latest release version, url and currentVersion
    final String gitHubLastReleaseVersion =
        responseJson['tag_name'].substring(1);
    final String currentVersion = await getAppVersion();
    _updateUrl = Uri.parse(
        responseJson['html_url']); // get the url of the latest release

    debugPrint('Current ver: $currentVersion');
    debugPrint('Github ver: $gitHubLastReleaseVersion');

    // already up to date
    if (currentVersion.compareTo(gitHubLastReleaseVersion) >= 0) {
      return false;
    }

    return true;
  }

  static void showUpdatedMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("You are on the latest version ❤️"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static void showNewUpdateMessage(BuildContext context) {
    showDialog(
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
                openUrl(_updateUrl);
              },
            ),
          ],
        );
      },
    );
  }

  //**
  //  * Check for a new version of the app in the github repository
  //  * If a new version is available, show a dialog asking the user "New update y/n"
  //  * and open the url to the release page.
  //  * void
  // */
  static Future<void> checkForUpdates(BuildContext context) async {
    (await isUpdateAvailable())
        ? showNewUpdateMessage(context)
        : showUpdatedMessage(context);
  }
}
