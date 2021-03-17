//
//  DistanceTransformFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "DistanceTransformFactory.h"
#import "Util.h"

@implementation DistanceTransformFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data distanceType: (int) distanceType maskSize: (int) maskSize result: (FlutterResult) result{
    
    switch (pathType) {
        case 1:
            result(distanceTransformS(pathString, distanceType, maskSize));
            break;
        case 2:
            result(distanceTransformB(data, distanceType, maskSize));
            break;
        case 3:
            result(distanceTransformB(data, distanceType, maskSize));
            break;
        
        default:
            break;
    }
    
}


FlutterStandardTypedData * distanceTransformS(NSString * pathString, int distanceType, int maskSize) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    if ([Util verificarImagen]) {
        
        NSData * respuesta;
         if(distanceType == cv::DIST_C || distanceType == cv::DIST_L1 || distanceType == cv::DIST_L2) {
             cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
             cv::Mat dst;
             cv::Mat srcGRAY;
             cv::Mat srcTHR;
             cv::cvtColor(src, srcGRAY, CV_BGRA2GRAY);
             cv::threshold(srcGRAY, srcTHR, 100, 255, 0);
             cv::distanceTransform(srcTHR, dst, distanceType, maskSize);
             NSData * imgConvert = [Util getImageConvert:dst];
             
            respuesta = imgConvert;
        } else {
            respuesta = imgOriginal;
        }
        
        
        resultado = [FlutterStandardTypedData typedDataWithBytes: respuesta];
        
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * distanceTransformB(FlutterStandardTypedData * data, int distanceType, int maskSize) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        
        NSData * respuesta;
        if((distanceType == cv::DIST_C || distanceType == cv::DIST_L1 || distanceType == cv::DIST_L2)
           && (maskSize == 3 || maskSize == 5 || maskSize == 0)) {
            
            cv::Mat dst;
            cv::Mat srcGRAY;
            cv::Mat srcTHR;
            cv::cvtColor(src, srcGRAY, CV_BGRA2GRAY);
            cv::threshold(srcGRAY, srcTHR, 100, 255, 0);
            cv::distanceTransform(srcTHR, dst, distanceType, maskSize);
            NSData * imgConvert = [Util getImageConvert:dst];
            respuesta = imgConvert;
        } else {
            respuesta = data.data;
        }
        
    
        resultado = [FlutterStandardTypedData typedDataWithBytes: respuesta];
    }
    
    return resultado;
}

@end
