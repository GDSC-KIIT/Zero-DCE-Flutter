import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:zero_d_c_e_flutter/app/services/camera_service.dart';

class Tools {
  static Widget bottomTools(CameraService camService, double height) {
    return Container(
      height: height,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.all(12.0),
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
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(Radius.circular(35))),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
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
    );
  }

  static Widget topTools(CameraService camService) {
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
