import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About this App 🪧'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/icon/icon.png',
              ),
              const Text(
                'Keep Reading',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'v 0.5.0\n\n',
                textAlign: TextAlign.center,
                style: TextStyle(
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
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Keep Reading',
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
                      text: '  PDF Manual. ',
                    ),
                    TextSpan(
                      text:
                          'It helps you to jump directly to a specific section of the maual with just a tap  🚀!',
                    ),
                    TextSpan(
                      text: '\n\n\n\n',
                    ),
                    TextSpan(
                      text: 'For more info, please visit: ',
                    ),
                    TextSpan(
                      text: 'GitHub Repo',
                      style: TextStyle(
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
