import 'package:pdfx/pdfx.dart';

import 'file_manager.dart';

Future<List<PdfPageImage>> preRenderPDF(String filePath) async {
  //final String filePath = await FileManager.getFilePath();
  final document = await PdfDocument.openFile(filePath); // Pages start at 1
  final totalPages = document.pagesCount;

  List<PdfPageImage> pages = <PdfPageImage>[];

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
      pages.add(pageImage);
    }

    await page.close();
  }

  return pages;
}
/*

import 'dart:ui';

import 'package:pdf_render/pdf_render.dart';
import 'package:image/image.dart' as imglib;

Future<List<Image>> prova(String filePath) async {
  final doc = await PdfDocument.openFile(filePath);
  final pages = doc.pageCount;
  List<imglib.Image> images = [];

// get images from all the pages
  for (int i = 1; i <= pages; i++) {
    var page = await doc.getPage(i);
    var imgPDF = await page.render();
    var img = await imgPDF.createImageDetached();
    var imgBytes = await img.toByteData(format: ImageByteFormat.png);

    if (imgBytes == null) {
      continue;
    }

    var libImage = imglib.decodeImage(imgBytes.buffer
        .asUint8List(imgBytes.offsetInBytes, imgBytes.lengthInBytes));

    if (libImage != null) {
      images.add(libImage);
    }
  }

  return images

// stitch images
  /* int totalHeight = 0;
  images.forEach((e) {
    totalHeight += e.height;
  });
  int totalWidth = 0;
  images.forEach((element) {
    totalWidth = totalWidth < element.width ? element.width : totalWidth;
  });
  final mergedImage = imglib.Image(totalWidth, totalHeight);
  int mergedHeight = 0;
  images.forEach((element) {
    imglib.copyInto(mergedImage, element,
        dstX: 0, dstY: mergedHeight, blend: false);
    mergedHeight += element.height;
  });

// Save image as a file
  final documentDirectory = await getExternalStorageDirectory();
  File imgFile = new File('${documentDirectory.path}/abc.jpg');
  new File(imgFile.path).writeAsBytes(imglib.encodeJpg(mergedImage)); */
}
 */