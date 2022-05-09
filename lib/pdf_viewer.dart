import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                icon: const Icon(Icons.home),
                onPressed: () {
                  controller.jumpToPage(5); // normal wires
                },
              ),
              IconButton(
                icon: const Icon(Icons.search), // button
                onPressed: () {
                  controller.jumpToPage(6);
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.jumpToPage(7); // icons
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.jumpToPage(8); // Simon says
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.jumpToPage(9); // screen words
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.jumpToPage(11); // screen numbers
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.jumpToPage(12); // morse
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.jumpToPage(13); // complex wires
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.jumpToPage(14); // crossed wires
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.jumpToPage(15); // maze
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  controller.jumpToPage(16); // password
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
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
