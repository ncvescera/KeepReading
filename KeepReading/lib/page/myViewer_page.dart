import 'package:flutter/material.dart';
import 'package:keep_reading/widget/appbar.dart';
import 'package:pdfx/pdfx.dart';

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
  List<Image> pages = [];
  bool loaded = false;
  late PageController _controller;

  void prova(String filePath) async {
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

    setState(() {
      this.pages = pages;
      loaded = true;
    });
  }

  @override
  void initState() {
    _controller = PageController();
    prova(widget.filePath);
    super.initState();
  }

  @override
  void dispose() {
    pages.clear();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(appName: widget.appName, deleteFile: widget.deleteFile),
      body: Center(
        child: (loaded)
            ? PhotoViewGallery.builder(
                key: widget.key,
                pageController: _controller,
                itemCount: pages.length,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: pages[index].image,
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: Theme.of(context).canvasColor,
                ),
                enableRotation: true,
                loadingBuilder: (context, event) => const Center(
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : const CircularProgressIndicator(),
      ),
      bottomNavigationBar: (loaded)
          ? Container(
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
                          _controller.jumpToPage(5); // normal wires
                        },
                      ),
                      IconButton(
                        icon: Image.asset(
                            'assets/button_icons/button.png'), // button
                        onPressed: () {
                          _controller.jumpToPage(6);
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/simbol.png'),
                        onPressed: () {
                          _controller.jumpToPage(7); // icons
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/saymon.png'),
                        onPressed: () {
                          _controller.jumpToPage(8); // Simon says
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/text.png'),
                        onPressed: () {
                          _controller.jumpToPage(9); // screen words
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/number.png'),
                        onPressed: () {
                          _controller.jumpToPage(11); // screen numbers
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/morse.png'),
                        onPressed: () {
                          _controller.jumpToPage(12); // morse
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/complex.png'),
                        onPressed: () {
                          _controller.jumpToPage(13); // complex wires
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/cross.png'),
                        onPressed: () {
                          _controller.jumpToPage(14); // crossed wires
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/maze.png'),
                        onPressed: () {
                          _controller.jumpToPage(15); // maze
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/pass.png'),
                        onPressed: () {
                          _controller.jumpToPage(16); // password
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/knob.png'),
                        onPressed: () {
                          _controller.jumpToPage(20); // knobs
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
