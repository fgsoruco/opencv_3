import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:opencv_3/factory/utils.dart';

import '../pathfrom.dart';

class DistanceTransformFactory {
  static const platform = const MethodChannel('opencv_3');

  static Future<Uint8List?> distanceTransform({
    required CVPathFrom pathFrom,
    required String pathString,
    required int distanceType,
    required int maskSize,
  }) async {
    File _file;
    Uint8List _fileAssets;

    Uint8List? result;
    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        result = await platform.invokeMethod('distanceTransform', {
          "pathType": 1,
          "pathString": pathString,
          "data": Uint8List(0),
          'distanceType': distanceType,
          'maskSize': maskSize
        });
        break;
      case CVPathFrom.URL:
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod('distanceTransform', {
          "pathType": 2,
          "pathString": '',
          "data": await _file.readAsBytes(),
          'distanceType': distanceType,
          'maskSize': maskSize
        });

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod('distanceTransform', {
          "pathType": 3,
          "pathString": '',
          "data": _fileAssets,
          'distanceType': distanceType,
          'maskSize': maskSize
        });
        break;
    }

    return result;
  }
}
