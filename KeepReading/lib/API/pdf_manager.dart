import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

void preloadPdfPages(String filePath, Function callbak) async {
  final document = await PdfDocument.openFile(filePath); // Pages start at 1
  final totalPages = document.pagesCount;

  List<Image> pages = <Image>[];

  for (int i = 1; i <= totalPages; i++) {
    PdfPage page = await document.getPage(i);

    var pageImage = await page.render(
      // rendered image width resolution, required
      width: page.width * 2,
      // rendered image height resolution, required
      height: page.height * 2,

      // Rendered image compression format, also can be PNG, WEBP*
      // Optional, default: PdfPageImageFormat.PNG
      // Web not supported
      format: PdfPageImageFormat.png,

      // Image background fill color for JPEG
      // Optional, default '#ffffff'
      // Web not supported
      backgroundColor: '#ffffff',

      // Crop rect in image for render
      // Optional, default null
      // Web not supported
      //cropRect: Rect.fromLTRB(left, top, right, bottom),
    );

    if (pageImage != null) {
      pages.add(
        Image(
          image: MemoryImage(pageImage.bytes),
        ),
      );
    }

    await page.close();
  }

  await document.close();

  callbak(pages);
}
