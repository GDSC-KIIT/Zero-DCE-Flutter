import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zero_d_c_e_flutter/app/services/camera_service.dart';

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: MediaQueryData.fromWindow(window).padding.bottom +
              AppBar().preferredSize.height +
              MediaQueryData.fromWindow(window).padding.top,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Positioned.fill(
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
                      return CameraPreview(
                        cameraController,
                        child: Stack(
                          children: [],
                        ),
                      );
                    } else {
                      throw Exception('Unknown camera state');
                    }
                  }),
                ),
              ),
              topTools(),
              bottomTools(),
            ],
          ),
        ),
      ],
    );
  }

  Widget bottomTools() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.fileImage, color: Colors.white)),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: new Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.all(Radius.circular(35))),
                child: Material(
                  color: Colors.transparent,
                  child: new InkWell(
                    borderRadius: BorderRadius.circular(35),
                    onTap: camService.shootPhoto,
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () => camService.switchCamera(),
                icon: FaIcon(FontAwesomeIcons.sync, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget topTools() {
    return Positioned(
      right: 0,
      top: 0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                backgroundColor: Colors.black.withOpacity(.5),
                child: FaIcon(FontAwesomeIcons.cog, color: Colors.white)),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(.5),
                child: Obx(
                  () => IconButton(
                      onPressed: () => camService.toggleFlash(),
                      icon: FaIcon(
                        FontAwesomeIcons.bolt,
                        color:
                            camService.flash.value ? Colors.white : Colors.grey,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
