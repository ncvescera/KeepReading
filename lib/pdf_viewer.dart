import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

const String _document = 'manual.pdf';

class PDFViewer extends StatelessWidget {
  const PDFViewer({Key? key, required this.appName}) : super(key: key);

  final String appName;

  @override
  Widget build(BuildContext context) {
    final PdfViewerController controller = PdfViewerController();

    return Scaffold(
      appBar: AppBar(
        title: Text(appName),
      ),
      body: Center(
        child: SfPdfViewer.asset(
          'assets/$_document',
          controller: controller,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        //color: Color.fromARGB(255, 75, 162, 206),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              IconButton(
                icon: Image.asset('assets/icons/wires.png'),
                onPressed: () {
                  controller.jumpToPage(5); // normal wires
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/button.png'), // button
                onPressed: () {
                  controller.jumpToPage(6);
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/simbol.png'),
                onPressed: () {
                  controller.jumpToPage(7); // icons
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/saymon.png'),
                onPressed: () {
                  controller.jumpToPage(8); // Simon says
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/text.png'),
                onPressed: () {
                  controller.jumpToPage(9); // screen words
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/number.png'),
                onPressed: () {
                  controller.jumpToPage(11); // screen numbers
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/morse.png'),
                onPressed: () {
                  controller.jumpToPage(12); // morse
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/complex.png'),
                onPressed: () {
                  controller.jumpToPage(13); // complex wires
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/cross.png'),
                onPressed: () {
                  controller.jumpToPage(14); // crossed wires
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/maze.png'),
                onPressed: () {
                  controller.jumpToPage(15); // maze
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/pass.png'),
                onPressed: () {
                  controller.jumpToPage(16); // password
                },
              ),
              IconButton(
                icon: Image.asset('assets/icons/knob.png'),
                onPressed: () {
                  controller.jumpToPage(20); // knobs
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
