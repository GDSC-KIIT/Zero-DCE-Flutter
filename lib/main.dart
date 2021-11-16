import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/services/app_lifecycle.dart';
import 'app/services/camera_service.dart';

void main() async {
  await init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Zero DCE",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(CameraService());
  Get.put(LifeCycleService());
}
