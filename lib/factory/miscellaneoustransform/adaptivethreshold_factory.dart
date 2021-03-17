import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:opencv_3/factory/utils.dart';

import '../pathfrom.dart';

class AdaptiveThresholdFactory {
  static const platform = const MethodChannel('opencv_3');

  static Future<Uint8List?> adaptiveThreshold({
    required CVPathFrom pathFrom,
    required String pathString,
    required double maxValue,
    required int adaptiveMethod,
    required int thresholdType,
    required int blockSize,
    required double constantValue,
  }) async {
    File _file;
    Uint8List _fileAssets;

    Uint8List? result;
    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        result = await platform.invokeMethod('adaptiveThreshold', {
          "pathType": 1,
          "pathString": pathString,
          "data": Uint8List(0),
          'maxValue': maxValue,
          'adaptiveMethod': adaptiveMethod,
          'thresholdType': thresholdType,
          'blockSize': blockSize,
          'constantValue': constantValue,
        });
        break;
      case CVPathFrom.URL:
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod('adaptiveThreshold', {
          "pathType": 2,
          "pathString": '',
          "data": await _file.readAsBytes(),
          'maxValue': maxValue,
          'adaptiveMethod': adaptiveMethod,
          'thresholdType': thresholdType,
          'blockSize': blockSize,
          'constantValue': constantValue
        });

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod('adaptiveThreshold', {
          "pathType": 3,
          "pathString": '',
          "data": _fileAssets,
          'maxValue': maxValue,
          'adaptiveMethod': adaptiveMethod,
          'thresholdType': thresholdType,
          'blockSize': blockSize,
          'constantValue': constantValue
        });
        break;
    }

    return result;
  }
}
