import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Storage {
  static Future<List<Directory>> getAndroidStorageList() async {
    List<Directory> storages = (await getExternalStorageDirectories())!;
    if (storages.isNotEmpty) {
      storages = storages.map((Directory e) {
        final List<String> splitedPath = e.path.split("/");
        return Directory(splitedPath
            .sublist(
                0, splitedPath.indexWhere((element) => element == "Android"))
            .join("/"));
      }).toList();
    } else {
      return [];
    }
    return storages;
  }

  static Future<void> saveFile(XFile imgFile) async {
    if (GetPlatform.isAndroid) {
      try {
        final _rootDir = await getAndroidStorageList();
        final _picDir = Directory(_rootDir.first.path + '/Pictures/ZeroDCE');

        final _fileName = "img_" "${DateTime.now().millisecondsSinceEpoch}_" +
            DateFormat('dd-MM-yyyy').format(DateTime.now());
        if (!(await _picDir.exists())) await _picDir.create();
        final _file = File(_picDir.path + '/$_fileName.jpg');
        if (await _file.exists()) {
          await _file.delete();
          await _file.create();
        } else {
          await _file.create();
        }
        await imgFile.saveTo(_file.path);
      } catch (e) {
        Get.snackbar('Error', '$e');
      }
    } else {
      throw Exception('No implementation for iOS');
    }
  }

  static Future<List<File>> getImages() async {
    if (GetPlatform.isAndroid) {
      final _rootDir = await getAndroidStorageList();
      final _picDir = Directory(_rootDir.first.path + '/Pictures/ZeroDCE');
      if (await _picDir.exists()) {
        try {
          var _files = await _picDir.list().toList();
          _files.removeWhere((element) => element is! File);
          return List.generate(
            _files.length,
            (index) => _files[index] as File,
            growable: false,
          );
        } catch (e) {
          Get.snackbar('Error', '$e');
        }
      }
    }
    return const [];
  }
}
