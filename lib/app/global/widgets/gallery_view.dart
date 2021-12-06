import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'view_photo.dart';

class GalleryView extends StatelessWidget {
  final List<File> imageFiles;
  final int crossAxisCount;
  const GalleryView({
    required Key key,
    required this.imageFiles,
    this.crossAxisCount = 3,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: imageFiles.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) {
                              return ViewPhotos(
                                imageIndex: index,
                                imageList: imageFiles,
                                heroTitle: "image$index",
                              );
                            },
                            fullscreenDialog: true));
                  },
                  child: Container(
                    child: Hero(
                      tag: "photo$index",
                      // child: imageThumbnailView(index),
                      child: Image.file(
                        imageFiles[index],
                      ),
                    ),
                  ),
                );
              }),
        ),
      );

  Widget imageThumbnailView(Uint8List bytes) => FadeInImage(
        fit: BoxFit.cover,
        fadeInDuration: Duration(milliseconds: 150),
        placeholder: MemoryImage(bytes),
        image: ResizeImage(
          MemoryImage(bytes),
          allowUpscaling: false,
        ),
      );

  Future<Uint8List> imgToBytes(File img) async => await img.readAsBytes();
}
