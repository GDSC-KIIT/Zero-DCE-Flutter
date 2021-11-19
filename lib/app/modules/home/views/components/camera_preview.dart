import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_d_c_e_flutter/app/services/camera_service.dart';
import 'tools.dart';

class CameraPreviewWidget extends StatelessWidget {
  const CameraPreviewWidget({
    Key? key,
  }) : super(key: key);

  CameraService get camService => Get.find<CameraService>();

  CameraController get cameraController {
    final k = camService.cameraController;
    if (k != null) {
      return k;
    } else {
      throw Exception('CameraController is null');
    }
  }

  double camHeight(MediaQueryData _data) =>
      _data.size.height -
      (_data.padding.bottom +
          (_data.padding.top * 2) +
          AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: camHeight(MediaQueryData.fromWindow(window)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Obx(() {
          if (camService.cameraState == CameraState.stopped) {
            return Container(
              child: Center(
                  child: CircleAvatar(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt_outlined),
                ),
              )),
            );
          } else if (camService.cameraState == CameraState.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (camService.cameraState == CameraState.ready) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: CameraPreview(
                      cameraController,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Icon(Icons.star, color: Colors.yellow),
                      ),
                    ),
                  ),
                ),
                Tools.topTools(camService),
                Tools.bottomTools(
                  camService,
                  camHeight(MediaQueryData.fromWindow(window)),
                )
              ],
            );
          } else {
            throw Exception('Unknown camera state');
          }
        }),
      ),
    );
  }
}
