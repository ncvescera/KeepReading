import 'package:flutter/material.dart';
import 'package:keep_reading/API/pdf_manager.dart';
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
  late PageController _controller;

  List<Image> pages = [];
  bool loaded = false;

  void updatePages(List<Image> pages) {
    setState(() {
      this.pages = pages;
      loaded = true;
    });
  }

  @override
  void initState() {
    _controller = PageController();
    preloadPdfPages(widget.filePath, updatePages);
    super.initState();
  }

  @override
  void dispose() {
    pages.clear();
    _controller.dispose();
    super.dispose();
  }

  void _jumpToPage(int page) {
    _controller
        .jumpToPage(page - 1); // -1 because the page numbers are shifted by 1
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
                          _jumpToPage(5); // normal wires
                        },
                      ),
                      IconButton(
                        icon: Image.asset(
                            'assets/button_icons/button.png'), // button
                        onPressed: () {
                          _jumpToPage(6);
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/simbol.png'),
                        onPressed: () {
                          _jumpToPage(7); // icons
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/saymon.png'),
                        onPressed: () {
                          _jumpToPage(8); // Simon says
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/text.png'),
                        onPressed: () {
                          _jumpToPage(9); // screen words
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/number.png'),
                        onPressed: () {
                          _jumpToPage(11); // screen numbers
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/morse.png'),
                        onPressed: () {
                          _jumpToPage(12); // morse
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/complex.png'),
                        onPressed: () {
                          _jumpToPage(13); // complex wires
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/cross.png'),
                        onPressed: () {
                          _jumpToPage(14); // crossed wires
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/maze.png'),
                        onPressed: () {
                          _jumpToPage(15); // maze
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/pass.png'),
                        onPressed: () {
                          _jumpToPage(16); // password
                        },
                      ),
                      IconButton(
                        icon: Image.asset('assets/button_icons/knob.png'),
                        onPressed: () {
                          _jumpToPage(20); // knobs
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
