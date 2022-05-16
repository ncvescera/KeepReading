import 'package:flutter/material.dart';
import 'package:keep_reading/API/pdf_manager.dart';
import 'package:keep_reading/widget/appbar.dart';
import 'package:keep_reading/widget/bottom_navication_bar.dart';
import 'package:keep_reading/widget/pdf_gallery.dart';

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

  //**
  //  * Used as callbak for the preloadPdfPages function
  //  * void
  // */
  void updatePages(List<Image> pages) {
    setState(() {
      this.pages = pages;
      loaded = true;
    });
  }

  //**
  //  * Used as callbak for the BottomBar Widget jumpToPage function
  //  * Jumps to the given page (if exists)
  //  * void
  // */
  void _jumpToPage(int page) {
    _controller
        .jumpToPage(page - 1); // -1 because the page numbers are shifted by 1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: MyAppBar(
        appName: widget.appName,
        deleteFile: widget.deleteFile,
        deleteEnabled: loaded,
        updateEnabled: loaded,
      ),
      body: Center(
        child: (loaded)
            ? PDFGallery(
                controller: _controller,
                pages: pages,
              )
            : const CircularProgressIndicator(),
      ),
      bottomNavigationBar:
          (loaded) ? MyBottomNavigationBar(jumpToPage: _jumpToPage) : null,
    );
  }
}
