import 'package:get/get.dart';
import 'package:zero_d_c_e_flutter/app/services/camera_service.dart';

class LifeCycleService extends SuperController {
  _resumeCamera() {
    final camService = Get.find<CameraService>();
    camService.cameraState.value = CameraState.loading;
    if (camService.cameraController != null) {
      if (camService.cameraController!.value.isPreviewPaused)
        camService.cameraController!.resumePreview();
    } else {
      // camService.initCamera();
    }
    camService.cameraState.value = CameraState.ready;
  }

  _pauseCamera() {
    final camService = Get.find<CameraService>();
    camService.cameraController?.pausePreview();
    camService.cameraState.value = CameraState.stopped;
  }

  @override
  void onDetached() {
    // return _pauseCamera();
  }

  @override
  void onInactive() {
    // return _pauseCamera();
  }

  @override
  void onPaused() => _pauseCamera();

  @override
  void onResumed() {
    _resumeCamera();
  }
}
