import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PDFGallery extends StatelessWidget {
  const PDFGallery({
    Key? key,
    required this.controller,
    required this.pages,
  }) : super(key: key);

  final PageController controller;
  final List<Image> pages;

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery.builder(
      key: key,
      pageController: controller,
      itemCount: pages.length,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: pages[index].image,
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 2,
        );
      },
      scrollPhysics: const BouncingScrollPhysics(),
      backgroundDecoration: const BoxDecoration(
        color: Colors.grey,
      ),
      enableRotation: false, // rotate the page
      loadingBuilder: (context, event) => const Center(
        child: SizedBox(
          width: 30.0,
          height: 30.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
