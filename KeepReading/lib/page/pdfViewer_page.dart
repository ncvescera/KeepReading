import 'package:flutter/material.dart';
import 'package:keep_reading/widget/appbar.dart';
import 'package:pdfx/pdfx.dart';
import 'package:performance/performance.dart';

class PDFViewer extends StatefulWidget {
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
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openFile(widget.filePath),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /* PdfController controller = PdfController(
      document: PdfDocument.openFile(widget.filePath),
    ); */

    return Scaffold(
      appBar: MyAppBar(appName: widget.appName, deleteFile: widget.deleteFile),
      body: Center(
        child: CustomPerformanceOverlay(
          enabled: false,
          child: PdfView(
            // this shit trows a HUGE exception, but it works... so :D
            // the problem is the PdfView :/ PdfViewPinch works fine
            builders: PdfViewBuilders<DefaultBuilderOptions>(
              options: const DefaultBuilderOptions(),
              documentLoaderBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              pageLoaderBuilder: (_) =>
                  const Center(child: CircularProgressIndicator()),
              //pageBuilder: _pageBuilder,
            ),
            controller: _pdfController,
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
                    _pdfController.jumpToPage(5); // normal wires
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/button.png'), // button
                  onPressed: () {
                    _pdfController.jumpToPage(6);
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/simbol.png'),
                  onPressed: () {
                    _pdfController.jumpToPage(7); // icons
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/saymon.png'),
                  onPressed: () {
                    _pdfController.jumpToPage(8); // Simon says
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/text.png'),
                  onPressed: () {
                    _pdfController.jumpToPage(9); // screen words
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/number.png'),
                  onPressed: () {
                    _pdfController.jumpToPage(11); // screen numbers
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/morse.png'),
                  onPressed: () {
                    _pdfController.jumpToPage(12); // morse
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/complex.png'),
                  onPressed: () {
                    _pdfController.jumpToPage(13); // complex wires
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/cross.png'),
                  onPressed: () {
                    _pdfController.jumpToPage(14); // crossed wires
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/maze.png'),
                  onPressed: () {
                    _pdfController.jumpToPage(15); // maze
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/pass.png'),
                  onPressed: () {
                    _pdfController.jumpToPage(16); // password
                  },
                ),
                IconButton(
                  icon: Image.asset('assets/button_icons/knob.png'),
                  onPressed: () {
                    _pdfController.jumpToPage(20); // knobs
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
