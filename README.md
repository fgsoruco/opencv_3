<style>
.center {
  display: block;
  margin-left: auto;
  margin-right: auto;
  width: 50%;
}
</style>

<p align="center"><img src="display/cover_1.gif"/></p>

<h1 align="center">OpenCV_3</h1>

<p align="center">This package contains the implementation of OpenCV modules, the version used is 3.4.5 for both android and ios platforms.</p><br>

<p align="center">
  <a href="https://flutter.dev">
    <img src="display/Platform-Flutter.png"
      alt="Platform" />
  </a>
  <a href="https://pub.dartlang.org/packages/opencv_3">
    <img src="display/nullsafety-0.0.1.png"
      alt="Platform" />
  </a>
  <a href="https://pub.dartlang.org/packages/opencv_3">
    <img src="display/pub-version.png"
      alt="Pub Package" />
  </a>
  <br>
  <a href="https://opensource.org/licenses/BSD-3-Clause">
    <img src="display/animated-bsd.png"
      alt="License: BSD-3-Clause" />
  </a>
  <a href="https://paypal.me/fgsoruco">
    <img src="display/donate.png"
      alt="Donate" />
  </a>
</p><br>
<p align="center">
    <a href="https://github.com/fgsoruco/opencv_3/master/README-es.md">Español</a>
    | <a href="https://github.com/fgsoruco/opencv_3/master/README-pt.md">Portugués</a>
</p>

---


# Table of contents

- [About this version](#about-this-version)
- [Installing](#installing)
- [How to use](#how-to-use)
- [Examples](#module:-image-filtering)
  - [Image Filtering](#module:-image-filtering)
  - [Miscellaneous Image Transformations](#module:-miscellaneous-image-transformations)
  - [Color Space Conversions](#module:-color-space-conversions)
  - [Color Maps](#module:-color-maps)
- [Bugs or Requests](#bugs-or-requests)
- [Donate](#donate)


# About this version

## Compatibility
* It is developed for the integration of the OpenCV artificial vision library in its version 3.4.5
* It is compatible with Android and iOS.
* Easy integration with popular flutter packages like [image_picker](https://pub.dev/packages/image_picker) was kept in mind, to process images from gallery or camera, you can see the implementation example [here](example).
* The implemented OpenCV modules are the following:
  * __Image Processing__
    * Image Filtering
      * _bilateralFilter_
      * _blur_
      * _boxFilter_
      * _dilate_
      * _erode_
      * _filter2D_
      * _gaussianBlur_
      * _laplacian_
      * _medianBlur_
      * _morphologyEx_
      * _pyrDown_
      * _pyrMeanShiftFiltering_
      * _pyrUp_
      * _scharr_
      * _sobel_
      * _sqrBoxFilter_
    * Miscellaneous Image Transformations
      * _adaptiveThreshold_
      * _distanceTransform_
      * _threshold_
    * Color Space Conversions
      * _cvtColor_
    * ColorMaps in OpenCV
      * _applyColorMap_
   



## Image processing
* All processing is through the image string path.
* Images in flutter through the asset folder configured in the pubspect.yaml file. __Default__
* Images in URLs.
* Images from gallery or camera using [image_picker](https://pub.dev/packages/image_picker)

## Syntax
* Similar to Python for method calls and image processing constants for example 
  * `Cv2.ctvColor` 
  * `Cv2.COLOR_BGR2GRAY`

## Coming soon
* Implementation of more OpenCV modules, is working on it.
* Processing of videos and animated gif, is working on it.


# Installing

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  opencv_3: ^0.0.1
```

### 2. Install it

You can install packages from the command line:


with `Flutter`:

```
$ flutter pub get
```

### 3. Import it

Now in your `Dart` code, you can use:

```dart
import 'package:opencv_3/Cv2.dart';
```

# How to use

## Pre requirements
1. If you are going to work with the asset path, flutter does not require permissions in Andorid and iOS.
2. If you want to work with images from URLs, no configuration is required.
3. If the [image_picker](https://pub.dev/packages/image_picker) package is to be used to work with images from the camera and gallery, follow your permission settings for [Android and iOS](https://pub.dev/packages/image_picker#installation).


## Classes
`Cv2`: Class that contains the implementation of OpenCV modules

`CVPathFrom`: Allows you to configure the path to process the images
* `URL` (___static constant___) configure opencv for web images
* `GALLERY_CAMERA` (___static constant___) configure opencv for images obtained from the image_picker package
* `ASSETS` (___static constant___) configure opencv for flutter images in pubspect.yaml --> assets/test.jpg


## Module: Image Filtering
<h2 align="center">Imagen original</h2>
<img src="display/Test.JPG" class = "center" height = "300px">
<h5 align="center">
<i>from my <a href="https://www.behance.net/gallery/114930481/Jujuy"> behance </a> acount</h5></i>
  

Some examples

## Bilateral Filter
Must be called within a __async__ function

<img src="display/bilateralFilter.JPG" align = "right" height = "300px">

```dart

Uint8List _byte = await Cv2.bilateralFilter(
        pathFrom: CVPathFrom.ASSETS,
        pathString: 'assets/Test.JPG',
        diameter: 20,
        sigmaColor: 75,
        sigmaSpace: 75,
        borderType: Cv2.BORDER_DEFAULT,
      );

      setState(() {
        _byte;
      });

```

Show result in an image widget
```dart
Image.memory(
      _byte,
      width: 300,
      height: 300,
      fit: BoxFit.fill,
    )
```

**Note:** If you want to process an image from the web you must configure `pathFrom: CVPathFrom.URL` replace in `pathString` with a URL, for example. `pathString: 'https://mir-s3-cdn-cf.behance.net/project_modules/fs/313f8e114930481.6044f05fcd866.jpeg'`


## Dilate

<img src="display/dilate.JPG" align = "right" height = "300px">

```dart


Uint8List _byte = await Cv2.dilate(
        pathFrom: CVPathFrom.ASSETS,
        pathString: 'assets/Test.JPG',
        kernelSize: [3, 3],
      );

      setState(() {
        _byte;
      });




```

## Filter2D

<img src="display/filter2D.JPG" align = "right" height = "300px">

```dart

Uint8List _byte = await Cv2.filter2D(
        pathFrom: CVPathFrom.URL,
        pathString:
          'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/634dba114930481.6044f05fcb2dd.jpeg',
        outputDepth: -1,
        kernelSize: [2, 2],
      );

      setState(() {
        _byte;
      });

```


## Median Blur

<img src="display/medianBlur.JPG" align = "right" height = "300px">

```dart


Uint8List _byte = await Cv2.medianBlur(
        pathFrom: CVPathFrom.URL,
        pathString:
          'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/16fe9f114930481.6044f05fca574.jpeg',
        kernelSize: 19,
      );

      setState(() {
        _byte;
      });

```

## MorphologyEx

<img src="display/morphologyEx.JPG" align = "right" height = "300px">

```dart


Uint8List _byte = await Cv2.morphologyEx(
        pathFrom: CVPathFrom.URL,
        pathString:
          'https://mir-s3-cdn-cf.behance.net/project_modules/fs/c7da51114930481.6044f05fcc76a.jpeg',
        operation: Cv2.MORPH_TOPHAT,
        kernelSize: [5, 5],
      );

      setState(() {
        _byte;
      });
```

## PyrMeanShiftFiltering

<img src="display/pyrMeanShiftFiltering.JPG" align = "right" height = "300px">

```dart



Uint8List _byte = await Cv2.pyrMeanShiftFiltering(
        pathFrom: CVPathFrom.ASSETS,
        pathString: 'assets/Test.JPG',
        spatialWindowRadius: 20,
        colorWindowRadius: 20,
      );

      setState(() {
        _byte;
      });


```

## Scharr

<img src="display/scharr.JPG" align = "right" height = "300px">

```dart


Uint8List _byte = await Cv2.scharr(
        pathFrom: CVPathFrom.ASSETS,
        pathString: 'assets/Test.JPG',
        depth: Cv2.CV_SCHARR,
        dx: 0,
        dy: 1,
      );

      setState(() {
        _byte;
      });


```


## Module: Miscellaneous Image Transformations

## Threshold

<img src="display/threshold.JPG" align = "right" height = "300px">

```dart


Uint8List _byte = await Cv2.threshold(
        pathFrom: CVPathFrom.ASSETS,
        pathString: 'assets/Test.JPG',
        thresholdValue: 150,
        maxThresholdValue: 200,
        thresholdType: Cv2.THRESH_BINARY,
      );

      setState(() {
        _byte;
      });


```

## AdaptiveThreshold

<img src="display/adaptiveThreshold.JPG" align = "right" height = "300px">

```dart


Uint8List _byte = await Cv2.adaptiveThreshold(
        pathFrom: CVPathFrom.ASSETS,
        pathString: 'assets/Test.JPG',
        maxValue: 125,
        adaptiveMethod: Cv2.ADAPTIVE_THRESH_MEAN_C,
        thresholdType: Cv2.THRESH_BINARY,
        blockSize: 11,
        constantValue: 12,
      );

      setState(() {
        _byte;
      });


```

## Module: Color Space Conversions

## CvtColor

<img src="display/cvtColor.JPG" align = "right" height = "300px">

```dart


Uint8List _byte = await Cv2.cvtColor(
        pathFrom: CVPathFrom.ASSETS,
        pathString: 'assets/Test.JPG',
        outputType: Cv2.COLOR_BGR2GRAY,
      );

      setState(() {
        _byte;
      });


```

## Module: Color Maps

## ApplyColorMap

<img src="display/applyColorMap.JPG" align = "right" height = "300px">

```dart


Uint8List _byte = await Cv2.applyColorMap(
        pathFrom: CVPathFrom.URL,
        pathString:
          'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/16fe9f114930481.6044f05fca574.jpeg',
        colorMap: Cv2.COLORMAP_JET,
      );

      setState(() {
        _byte;
      });


```

## Bugs or Requests
Please file feature requests and bugs at the [issue tracker](https://github.com/fgsoruco/opencv_3/issues).


## Donate
To give you a better solution.

[![ko-fi](display/donate-coffee.png)](https://paypal.me/fgsoruco)

* `BTC`: bc1qhy5uer94d4xvp2wgtfg5l6s6jk8gwj6d0ufqvh
* `BNB`: bnb17z7dqeeyrkhq2l9mx6p3hg6ewvshrpkqqzcpr9
* `ETH`: 0xb76D1F1f97eBf5B2096D5449cB3DDD2096CCB4b3
