import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewPhotos extends StatelessWidget {
  final int imageIndex;
  final List<File> imageList;
  final String heroTitle;

  const ViewPhotos({
    Key? key,
    required this.imageIndex,
    required this.imageList,
    required this.heroTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = imageIndex.obs;
    final pageController = PageController(initialPage: imageIndex);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Obx(
          () => Text(
            "${currentIndex.value + 1} out of ${imageList.length}",
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        centerTitle: true,
        leading: Container(),
        backgroundColor: Colors.black,
      ),
      body: Container(
          child: Stack(
        children: [
          PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            pageController: pageController,
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(imageList[index]),
                heroAttributes:
                    PhotoViewHeroAttributes(tag: "photo$imageIndex"),
              );
            },
            onPageChanged: (index) => currentIndex.value = index,
            itemCount: imageList.length,
            loadingBuilder: (context, progress) => Center(
              child: Container(
                width: 60.0,
                height: 60.0,
                child: (progress == null ||
                        progress.cumulativeBytesLoaded == null ||
                        progress.expectedTotalBytes == null)
                    ? CircularProgressIndicator()
                    : CircularProgressIndicator(
                        value: progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!,
                      ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
