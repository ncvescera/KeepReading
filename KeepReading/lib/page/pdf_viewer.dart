import 'package:flutter/material.dart';
import 'package:keep_reading/widget/appbar.dart';
import 'package:pdfx/pdfx.dart';

class PDFViewer extends StatelessWidget {
  const PDFViewer({
    Key? key,
    required this.appName,
    required this.deleteFile,
    required this.filePath,
  }) : super(key: key);

  final String appName;
  final Function deleteFile;
  final String filePath;

  @override
  Widget build(BuildContext context) {
    PdfController controller = PdfController(
      document: PdfDocument.openFile(filePath),
    );

    return Scaffold(
      appBar: AppBarGenerator.mainAppBar(context, appName, deleteFile),
      body: Center(
        child: PdfView(
          // this shit trows a HUGE exception, but it works... so :D
          // the problem is the PdfView :/ PdfViewPinch works fine
          controller: controller,
          backgroundDecoration: const BoxDecoration(
            color: Colors.grey,
          ),
          pageSnapping: false,
          renderer: (PdfPage page) => page.render(
            width: page.width * 2,
            height: page.height * 2,
            format: PdfPageImageFormat.png,
            backgroundColor: '#FFFFFF',
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 6.0,
            ),
          ],
        ),
        child: BottomAppBar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/button_icons/wires.png'),
                  onPressed: () {
                    controller.jumpToPage(5); // normal wires
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/button.png'), // button
                  onPressed: () {
                    controller.jumpToPage(6);
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/simbol.png'),
                  onPressed: () {
                    controller.jumpToPage(7); // icons
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/saymon.png'),
                  onPressed: () {
                    controller.jumpToPage(8); // Simon says
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/text.png'),
                  onPressed: () {
                    controller.jumpToPage(9); // screen words
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/number.png'),
                  onPressed: () {
                    controller.jumpToPage(11); // screen numbers
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/morse.png'),
                  onPressed: () {
                    controller.jumpToPage(12); // morse
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/complex.png'),
                  onPressed: () {
                    controller.jumpToPage(13); // complex wires
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/cross.png'),
                  onPressed: () {
                    controller.jumpToPage(14); // crossed wires
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/maze.png'),
                  onPressed: () {
                    controller.jumpToPage(15); // maze
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/pass.png'),
                  onPressed: () {
                    controller.jumpToPage(16); // password
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/knob.png'),
                  onPressed: () {
                    controller.jumpToPage(20); // knobs
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
