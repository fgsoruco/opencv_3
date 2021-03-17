#import "Opencv3Plugin.h"

@implementation Opencv3Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"opencv_3"
            binaryMessenger:[registrar messenger]];
  Opencv3Plugin* instance = [[Opencv3Plugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {

  // Note: this method is invoked on the UI thread.
  if ([@"getVersion" isEqualToString:call.method]) {
      result([NSString stringWithFormat:@"%s", cv::getVersionString().c_str()]);
  }
  //Module: Image Filtering
  else if ([@"bilateralFilter" isEqualToString:call.method]) {
  
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int diameter = [call.arguments[@"diameter"] intValue];
      double sigmaColor = [call.arguments[@"sigmaColor"] doubleValue];
      double sigmaSpace = [call.arguments[@"sigmaSpace"] doubleValue];
      int borderType = [call.arguments[@"borderType"] intValue];
      
      [BilateralFilterFactory processWhitPathType:pathType pathString:pathString data:data diameter:diameter sigmaColor:sigmaColor sigmaSpace:sigmaSpace borderType:borderType result:result];
  
  }
  else if ([@"blur" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      NSArray* kernelSize = call.arguments[@"kernelSize"];
      NSArray* anchorPoint = call.arguments[@"anchorPoint"];
      int borderType = [call.arguments[@"borderType"] intValue];
      double p1 = [[anchorPoint objectAtIndex:0] doubleValue];
      double p2 = [[anchorPoint objectAtIndex:1] doubleValue];
      double x = [[kernelSize objectAtIndex:0] doubleValue];
      double y = [[kernelSize objectAtIndex:1] doubleValue];
      double kernelSizeDouble[2] = {x,y};
      double anchorPointDouble[2] = {p1,p2};
      
      [BlurFactory processWhitPathType:pathType pathString:pathString data:data kernelSize:kernelSizeDouble anchorPoint:anchorPointDouble borderType:borderType result:result];
  }
  else if ([@"boxFilter" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int outputDepth = [call.arguments[@"outputDepth"] intValue];
      NSArray* kernelSize = call.arguments[@"kernelSize"];
      NSArray* anchorPoint = call.arguments[@"anchorPoint"];
      bool normalize = [call.arguments[@"normalize"] boolValue];
      int borderType = [call.arguments[@"borderType"] intValue];
      double p1 = [[anchorPoint objectAtIndex:0] doubleValue];
      double p2 = [[anchorPoint objectAtIndex:1] doubleValue];
      double x = [[kernelSize objectAtIndex:0] doubleValue];
      double y = [[kernelSize objectAtIndex:1] doubleValue];
      double kernelSizeDouble[2] = {x,y};
      double anchorPointDouble[2] = {p1,p2};
      
      [BoxFilterFactory processWhitPathType:pathType pathString:pathString data:data outputDepth:outputDepth kernelSize:kernelSizeDouble anchorPoint:anchorPointDouble normalize:normalize borderType:borderType result:result];
  }
  else if ([@"dilate" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      NSArray* kernelSize = call.arguments[@"kernelSize"];
      double x = [[kernelSize objectAtIndex:0] doubleValue];
      double y = [[kernelSize objectAtIndex:1] doubleValue];
      double kernelSizeDouble[2] = {x,y};
      
      
      [DilateFactory processWhitPathType:pathType pathString:pathString data:data kernelSize:kernelSizeDouble result:result];
  }
  else if ([@"erode" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      NSArray* kernelSize = call.arguments[@"kernelSize"];
      double x = [[kernelSize objectAtIndex:0] doubleValue];
      double y = [[kernelSize objectAtIndex:1] doubleValue];
      double kernelSizeDouble[2] = {x,y};
      
      
      [ErodeFactory processWhitPathType:pathType pathString:pathString data:data kernelSize:kernelSizeDouble result:result];
  }
  else if ([@"filter2D" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int outputDepth = [call.arguments[@"outputDepth"] intValue];
      NSArray* kernelSize = call.arguments[@"kernelSize"];
      int x = [[kernelSize objectAtIndex:0] intValue];
      int y = [[kernelSize objectAtIndex:1] intValue];
      int kernelSizeInt[2] = {x,y};
      
      [Filter2DFactory processWhitPathType:pathType pathString:pathString data:data outputDepth:outputDepth kernelSize:kernelSizeInt result:result];
  }
  else if ([@"gaussianBlur" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      NSArray* kernelSize = call.arguments[@"kernelSize"];
      double sigmaX = [call.arguments[@"sigmaX"] doubleValue];
      double x = [[kernelSize objectAtIndex:0] doubleValue];
      double y = [[kernelSize objectAtIndex:1] doubleValue];
      double kernelSizeDouble[2] = {x,y};
      
      [GaussianBlurFactory processWhitPathType:pathType pathString:pathString data:data kernelSize:kernelSizeDouble sigmaX:sigmaX result:result];
  }
  else if ([@"laplacian" isEqualToString:call.method]) {
     
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int depth = [call.arguments[@"depth"] intValue];
      
      [LaplacianFactory processWhitPathType:pathType pathString:pathString data:data depth:depth result:result];
       
  }
  else if ([@"medianBlur" isEqualToString:call.method]) {
     
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int kernelSize = [call.arguments[@"kernelSize"] intValue];
      
      [MedianBlurFactory processWhitPathType:pathType pathString:pathString data:data kernelSize:kernelSize result:result];
       
  }
  else if ([@"morphologyEx" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int operation = [call.arguments[@"operation"] intValue];
      NSArray* kernelSize = call.arguments[@"kernelSize"];
      int x = [[kernelSize objectAtIndex:0] intValue];
      int y = [[kernelSize objectAtIndex:1] intValue];
      int kernelSizeInt[2] = {x,y};
      
      [MorphologyExFactory processWhitPathType:pathType pathString:pathString data:data operation:operation kernelSize:kernelSizeInt result:result];
  }
  else if ([@"pyrMeanShiftFiltering" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      double spatialWindowRadius = [call.arguments[@"spatialWindowRadius"] doubleValue];
      double colorWindowRadius = [call.arguments[@"colorWindowRadius"] doubleValue];
      
      [PyrMeanShiftFilteringFactory processWhitPathType:pathType pathString:pathString data:data spatialWindowRadius:spatialWindowRadius colorWindowRadius:colorWindowRadius result:result];
  }
  else if ([@"scharr" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int depth = [call.arguments[@"depth"] intValue];
      int dx = [call.arguments[@"dx"] intValue];
      int dy = [call.arguments[@"dy"] intValue];
      
      [ScharrFactory processWhitPathType:pathType pathString:pathString data:data depth:depth dx:dx dy:dy result:result];
  }
  else if ([@"sobel" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int depth = [call.arguments[@"depth"] intValue];
      int dx = [call.arguments[@"dx"] intValue];
      int dy = [call.arguments[@"dy"] intValue];
      
      [SobelFactory processWhitPathType:pathType pathString:pathString data:data depth:depth dx:dx dy:dy result:result];
  }
  else if ([@"sqrBoxFilter" isEqualToString:call.method]) {
      
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int outputDepth = [call.arguments[@"outputDepth"] intValue];
      NSArray* kernelSize = call.arguments[@"kernelSize"];
      double x = [[kernelSize objectAtIndex:0] doubleValue];
      double y = [[kernelSize objectAtIndex:1] doubleValue];
      double kernelSizeDouble[2] = {x,y};
      
      [SqrBoxFilterFactory processWhitPathType:pathType pathString:pathString data:data outputDepth:outputDepth kernelSize:kernelSizeDouble result:result];
  }
  else if ([@"adaptiveThreshold" isEqualToString:call.method]) {
  
      NSString* image_path = call.arguments[@"path"];
      double maxValue = [call.arguments[@"maxValue"] doubleValue];
      int adaptiveMethod = [call.arguments[@"adaptiveMethod"] intValue];
      int thresholdType = [call.arguments[@"thresholdType"] intValue];
      int blockSize = [call.arguments[@"blockSize"] intValue];
      double constantValue = [call.arguments[@"constantValue"] doubleValue];
      
      result([core adaptiveThreshold:image_path maxValue:maxValue adaptiveMethod:adaptiveMethod thresholdType:thresholdType blockSize:blockSize constantValue:constantValue]);
  }
  else if ([@"applyColorMap" isEqualToString:call.method]) {
  
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int colorMap = [call.arguments[@"colorMap"] intValue];
      
      [ApplyColorMapFactory processWhitPathType:pathType pathString:pathString data:data colorMap:colorMap result:result];
      
  }
  else if ([@"cvtColor" isEqualToString:call.method]) {
     
      int pathType = [call.arguments[@"pathType"] intValue];
      NSString* pathString = call.arguments[@"pathString"];
      FlutterStandardTypedData* data = call.arguments[@"data"];
      int outputType = [call.arguments[@"outputType"] intValue];
      
      [CvtColorFactory processWhitPathType:pathType pathString:pathString data:data outputType:outputType result:result];
       
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
