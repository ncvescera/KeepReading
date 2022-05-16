import 'package:flutter/material.dart';
import 'package:keep_reading/API/update_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

// needed a StateFull widget because _packageInfo needs to be inizialized and loaded.
// it seems that packageInfo cant be loaded without an async function.
class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String version = "";
  final Uri _url = Uri.parse('https://github.com/ncvescera/KeepReading');

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  void _getAppVersion() async {
    final String appversion = await UpdateManager.getAppVersion();
    setState(() {
      version = appversion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About this App'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon/icon.png',
              ),
              const Text(
                'KeepReading',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'v $version\n\n',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  children: [
                    TextSpan(
                      text: 'KeepReading',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '  is a Cross-Platform App wrapper for the ',
                    ),
                    TextSpan(
                      text: 'Keep Talking and Nobody Explodes',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    TextSpan(
                      text: '  PDF Manual.\n',
                    ),
                    TextSpan(
                      text:
                          'It helps you to jump directly to a specific section of the maual with just a tap  🚀!',
                    ),
                  ],
                ),
              ),
              const Text(
                '\n\n\n\n',
              ),
              const Text(
                'For more info, please visit: ',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (!await launchUrl(_url,
                      mode: LaunchMode.externalApplication)) {
                    throw 'Could not launch $_url';
                  }
                },
                child: const Text(
                  'GitHub Repo',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
