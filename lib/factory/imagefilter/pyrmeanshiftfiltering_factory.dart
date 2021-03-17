import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:opencv_3/factory/pathfrom.dart';
import 'package:opencv_3/factory/utils.dart';

///Class for process [PyrMeanShiftFiltering]
class PyrMeanShiftFilteringFactory {
  static const platform = const MethodChannel('opencv_3');

  static Future<Uint8List?> pyrMeanShiftFiltering({
    required CVPathFrom pathFrom,
    required String pathString,
    required double spatialWindowRadius,
    required double colorWindowRadius,
  }) async {
    File _file;
    Uint8List _fileAssets;

    Uint8List? result;
    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        result = await platform.invokeMethod(
          'pyrMeanShiftFiltering',
          {
            "pathType": 1,
            'pathString': pathString,
            "data": Uint8List(0),
            'spatialWindowRadius': spatialWindowRadius,
            'colorWindowRadius': colorWindowRadius,
          },
        );
        break;
      case CVPathFrom.URL:
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod(
          'pyrMeanShiftFiltering',
          {
            "pathType": 2,
            "pathString": '',
            "data": await _file.readAsBytes(),
            'spatialWindowRadius': spatialWindowRadius,
            'colorWindowRadius': colorWindowRadius,
          },
        );

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod(
          'pyrMeanShiftFiltering',
          {
            "pathType": 3,
            "pathString": '',
            "data": _fileAssets,
            'spatialWindowRadius': spatialWindowRadius,
            'colorWindowRadius': colorWindowRadius,
          },
        );
        break;
    }
    return result;
  }
}
