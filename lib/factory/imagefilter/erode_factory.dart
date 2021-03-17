import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:opencv_3/factory/pathfrom.dart';
import 'package:opencv_3/factory/utils.dart';

///Class for process [Erode]
class ErodeFactory {
  static const platform = const MethodChannel('opencv_3');

  static Future<Uint8List?> erode({
    required CVPathFrom pathFrom,
    required String pathString,
    required List<double> kernelSize,
  }) async {
    File _file;
    Uint8List _fileAssets;

    Uint8List? result;
    List<double> kernelSizeTemp = Utils.verKernelSize(kernelSize);

    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        result = await platform.invokeMethod(
          'erode',
          {
            "pathType": 1,
            'pathString': pathString,
            "data": Uint8List(0),
            'kernelSize': kernelSizeTemp,
          },
        );
        break;
      case CVPathFrom.URL:
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod(
          'erode',
          {
            "pathType": 2,
            "pathString": '',
            "data": await _file.readAsBytes(),
            'kernelSize': kernelSizeTemp,
          },
        );

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod(
          'erode',
          {
            "pathType": 3,
            "pathString": '',
            "data": _fileAssets,
            'kernelSize': kernelSizeTemp,
          },
        );
        break;
    }
    return result;
  }
}
