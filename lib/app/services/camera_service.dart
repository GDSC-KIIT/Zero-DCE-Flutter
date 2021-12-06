import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:zero_d_c_e_flutter/app/utils/storage_utils.dart';

enum CameraState { stopped, loading, ready }

class CameraService extends GetxService {
  CameraController? cameraController;
  late final List<CameraDescription> cameras;
  final cameraState = Rx<CameraState>(CameraState.stopped);
  int _currentSeletedCamera = 0;
  final flash = false.obs;

  @override
  void onInit() {
    _initCamera();
    super.onInit();
  }

  Future<void> _initCamera() async {
    cameraState.value = CameraState.loading;
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );
    await cameraController!.initialize();
    cameraState.value = CameraState.ready;
  }

  Future<void> switchCamera() async {
    cameraState.value = CameraState.loading;
    _currentSeletedCamera = (_currentSeletedCamera + 1) % cameras.length;
    cameraController = CameraController(
      cameras[_currentSeletedCamera],
      ResolutionPreset.high,
    );
    await cameraController!.initialize();
    cameraState.value = CameraState.ready;
  }

  void resumeCameraPreview() => cameraController?.resumePreview();
  void pauseCameraPreview() => cameraController?.pausePreview();

  Future<void> shootPhoto() async {
    final XFile? imgFile = await cameraController?.takePicture();
    if (imgFile != null) {
      Storage.saveFile(imgFile);
    }
  }

  void toggleFlash() {
    if (flash.value) {
      cameraController?.setFlashMode(FlashMode.always);
      flash.value = false;
    } else {
      cameraController?.setFlashMode(FlashMode.off);
      flash.value = true;
    }
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
