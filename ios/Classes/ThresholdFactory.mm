//
//  ThresholdFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "ThresholdFactory.h"
#import "Util.h"

@implementation ThresholdFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data thresholdValue: (double)thresholdValue maxThresholdValue: (double) maxThresholdValue thresholdType: (int) thresholdType result: (FlutterResult) result{
    
    switch (pathType) {
        case 1:
            result(thresholdS(pathString, thresholdValue, maxThresholdValue, thresholdType));
            break;
        case 2:
            result(thresholdB(data, thresholdValue, maxThresholdValue, thresholdType));
            break;
        case 3:
            result(thresholdB(data, thresholdValue, maxThresholdValue, thresholdType));
            break;
        
        default:
            break;
    }
    
}


FlutterStandardTypedData * thresholdS(NSString * pathString, double thresholdValue, double maxThresholdValue, int thresholdType) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    if ([Util verificarImagen]) {
        
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        cv::Mat srcGRAY;
        cv::cvtColor(src, srcGRAY, CV_BGRA2GRAY);
        cv::threshold(srcGRAY, dst, thresholdValue, maxThresholdValue, thresholdType);
        NSData * imgConvert = [Util getImageConvert:dst];
        
        
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
        
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * thresholdB(FlutterStandardTypedData * data, double thresholdValue, double maxThresholdValue, int thresholdType) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        cv::Mat srcGRAY;
        cv::cvtColor(src, srcGRAY, CV_BGRA2GRAY);
        cv::threshold(srcGRAY, dst, thresholdValue, maxThresholdValue, thresholdType);
        NSData * imgConvert = [Util getImageConvert:dst];
        
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;
}


@end
