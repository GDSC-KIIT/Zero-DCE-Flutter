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
          child: Container(
            height: MediaQuery.of(context).size.height -
                (MediaQuery.of(context).padding.top +
                    AppBar().preferredSize.height +
                    MediaQuery.of(context).padding.top),
            color: Colors.white,
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
                return CameraPreview(cameraController);
              } else {
                throw Exception('Unknown camera state');
              }
            }),
          ),
        ),
        Container(
          height: AppBar().preferredSize.height,
          width: double.infinity,
          // color: Colors.black,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FaIcon(FontAwesomeIcons.cog, color: Colors.white), 
              FaIcon(FontAwesomeIcons.bolt, color: Colors.white), 
            ],
          ),
        ),
      ],
    );
  }
}
