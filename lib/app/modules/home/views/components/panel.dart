import 'dart:io';
import 'package:flutter/material.dart';
import 'package:zero_d_c_e_flutter/app/global/widgets/gallery_view.dart';
import 'package:zero_d_c_e_flutter/app/utils/storage_utils.dart';

class GalleryPanel extends StatelessWidget {
  const GalleryPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Storage.getImages();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<File>>(
        future: Storage.getImages(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            // return Container();
            return Container(
                child: GalleryView(
              imageFiles: snapshot.data!,
              key: UniqueKey(),
            ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
