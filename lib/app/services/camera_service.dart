import 'package:camera/camera.dart';
import 'package:get/get.dart';

enum CameraState {stopped, loading, ready}

class CameraService extends GetxService {
  CameraController? cameraController;
  late final List<CameraDescription> cameras;
  final cameraState = Rx<CameraState>(CameraState.stopped);

  @override
  void onInit() {
    initCamera();
    super.onInit();
  }

  Future<void> initCamera() async {
    cameraState.value = CameraState.loading;
    cameras = await availableCameras();
    cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );
    await cameraController!.initialize();
    cameraState.value = CameraState.ready;
  }

  resumeCameraPreview() => cameraController?.resumePreview();
  pauseCameraPreview() => cameraController?.pausePreview();

  @override
  void onClose() {
    super.onClose();
  }
}
