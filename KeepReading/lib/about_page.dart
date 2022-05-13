import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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

  void _getAppVersion() {
    PackageInfo.fromPlatform().then((package) => setState(() {
          version = package.version;
        }));
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
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  children: [
                    const TextSpan(
                      text: 'For more info, please visit: ',
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (!await launchUrl(_url,
                              mode: LaunchMode.externalApplication)) {
                            throw 'Could not launch $_url';
                          }
                        },
                      text: 'GitHub Repo',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
