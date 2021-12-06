import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class Transfer extends GetxService {
  Interpreter? interpreter;

  Future<void> loadModel() async {
    if (GetPlatform.isAndroid) {
      final GpuDelegateV2 gpuDelegateV2 = GpuDelegateV2(
        options: GpuDelegateOptionsV2(
          isPrecisionLossAllowed: false,
          inferencePreference: TfLiteGpuInferenceUsage.fastSingleAnswer,
          inferencePriority1: TfLiteGpuInferencePriority.minLatency,
          inferencePriority2: TfLiteGpuInferencePriority.auto,
          inferencePriority3: TfLiteGpuInferencePriority.auto,
        ),
      );
      final interpreterOptions = InterpreterOptions()
        ..addDelegate(gpuDelegateV2);
      interpreter = await Interpreter.fromAsset(
        'assets/model/lite-model_zero-dce_1.tflite',
        options: interpreterOptions,
      );
    }
  }

  runModel(img.Image loadImage) async {

    final modelImage = img.copyResize(loadImage, width: 400, height: 600);
    final input = Float32List.fromList(
      modelImage.getBytes().map((byte) => byte / 255.0).toList(),
    );
    var outputsForPrediction = [
      List.generate(
        400,
        (index) => List.generate(
          400,
          (index) => List.generate(3, (index) => 0.0),
        ),
      )
    ];

    interpreter!.run(input.buffer, outputsForPrediction);
    // outputsForPrediction = convertArrayToImage(outputsForPrediction, 400);
  }

  img.Image convertArrayToImage(
      List<List<List<List<double>>>> imageArray, int height, int width) {
    img.Image image = img.Image.rgb(width, height);
    for (var x = 0; x < imageArray[0].length; x++) {
      for (var y = 0; y < imageArray[0][0].length; y++) {
        var r = (imageArray[0][x][y][0] * 255).toInt();
        var g = (imageArray[0][x][y][1] * 255).toInt();
        var b = (imageArray[0][x][y][2] * 255).toInt();
        image.setPixelRgba(x, y, r, g, b);
      }
    }
    return image;
  }

  @override
  void onClose() {
    interpreter?.close();
    super.onClose();
  }
}
