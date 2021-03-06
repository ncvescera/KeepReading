import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:keep_reading/API/pdf_manager.dart';
import 'package:keep_reading/widget/appbar.dart';
import 'package:keep_reading/widget/bottom_navigation_bar.dart';
import 'package:keep_reading/widget/pdf_gallery.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({
    Key? key,
    required this.appName,
    required this.deleteFile,
    required this.filePath,
    required this.updateCallback,
  }) : super(key: key);

  final String appName;
  final String filePath;
  final Future<bool> Function() deleteFile;
  final void Function() updateCallback;

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  late PageController _controller;
  List<Image> _pages = [];
  bool _loaded = false;

  @override
  void initState() {
    _controller = PageController();
    preloadPdfPages(widget.filePath, updatePages);
    super.initState();
  }

  @override
  void dispose() {
    _pages.clear();
    _controller.dispose();
    super.dispose();
  }

  //**
  //  * Used as callback for the preloadPdfPages function
  //  * void
  // */
  void updatePages(List<Image> pages) async {
    setState(() {
      _pages = pages;
      _loaded = true;
    });

    // perform the update check after setState is executed
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      debugPrint('After setState !');
      widget.updateCallback();
    });
  }

  //**
  //  * Used as callback for the BottomBar Widget jumpToPage function
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
        showMenuButton: _loaded,
        deleteEnabled: _loaded,
        updateEnabled: _loaded,
      ),
      body: Center(
        child: (_loaded)
            ? PDFGallery(
                controller: _controller,
                pages: _pages,
              )
            : const CircularProgressIndicator(),
      ),
      bottomNavigationBar:
          (_loaded) ? MyBottomNavigationBar(jumpToPage: _jumpToPage) : null,
    );
  }
}
