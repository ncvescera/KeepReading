import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

const String _document = 'manual.pdf';

class PDFViewer extends StatelessWidget {
  PDFViewer({Key? key}) : super(key: key);

  final PdfViewerController controller = PdfViewerController();

  void jumpToPage(int page) {
    controller.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.asset(
      'assets/$_document',
      controller: controller,
    );
  }
}
