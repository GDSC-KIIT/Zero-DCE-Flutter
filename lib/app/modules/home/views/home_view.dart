import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:zero_d_c_e_flutter/app/modules/home/views/components/camera_preview.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final barHeight =
        MediaQuery.of(context).padding.top + AppBar().preferredSize.height;
    return Material(
      child: SlidingUpPanel(
        maxHeight: MediaQuery.of(context).size.height,
        minHeight: barHeight,
        panel: Scaffold(
          appBar: AppBar(
            title: Text('Gallery'),
            centerTitle: true,
          ),
        ),
        collapsed: Container(
            color: Colors.black,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 30, right: 30),
            child: FaIcon(FontAwesomeIcons.chevronUp, color: Colors.white)),
        body: Container(
          color: Colors.black,
          child: SafeArea(
            child: CameraPreviewWidget(),
          ),
        ),
      ),
    );
  }
}
