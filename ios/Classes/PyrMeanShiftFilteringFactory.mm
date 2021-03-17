//
//  PyrMeanShiftFilteringFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "PyrMeanShiftFilteringFactory.h"
#import "Util.h"

@implementation PyrMeanShiftFilteringFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data spatialWindowRadius: (double)spatialWindowRadius colorWindowRadius: (double) colorWindowRadius result: (FlutterResult) result{
    
    switch (pathType) {
        case 1:
            result(pyrMeanShiftFilteringS(pathString, spatialWindowRadius, colorWindowRadius));
            break;
        case 2:
            result(pyrMeanShiftFilteringB(data, spatialWindowRadius, colorWindowRadius));
            break;
        case 3:
            result(pyrMeanShiftFilteringB(data, spatialWindowRadius, colorWindowRadius));
            break;
        
        default:
            break;
    }
    
}


FlutterStandardTypedData * pyrMeanShiftFilteringS(NSString * pathString, double spatialWindowRadius, double colorWindowRadius) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    if ([Util verificarImagen]) {
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        cv::Mat srcBGR;
        cv::cvtColor(src, srcBGR, CV_BGRA2BGR);
        cv::pyrMeanShiftFiltering(srcBGR, dst, spatialWindowRadius, colorWindowRadius);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
        
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * pyrMeanShiftFilteringB(FlutterStandardTypedData * data, double spatialWindowRadius, double colorWindowRadius) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        cv::Mat srcBGR;
        cv::cvtColor(src, srcBGR, CV_BGRA2BGR);
        cv::pyrMeanShiftFiltering(srcBGR, dst, spatialWindowRadius, colorWindowRadius);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;
}


@end
