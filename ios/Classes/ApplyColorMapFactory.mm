//
//  ApplyColorMapFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "ApplyColorMapFactory.h"
#import "Util.h"

@implementation ApplyColorMapFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data colorMap:(int)colorMap result:(FlutterResult)result{
    
    switch (pathType) {
        case 1:
            result(applyColorMapS(pathString, colorMap));
            break;
        case 2:
            result(applyColorMapB(data, colorMap));
            break;
        case 3:
            result(applyColorMapB(data, colorMap));
            break;
        
        default:
            break;
    }
    
}

FlutterStandardTypedData * applyColorMapS(NSString * pathString, int colorMap) {
    
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    if ([Util verificarImagen]) {
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        cv::Mat srcBGR;
        cv::cvtColor(src, srcBGR, CV_BGRA2BGR);
        cv::applyColorMap(srcBGR, dst, colorMap);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * applyColorMapB(FlutterStandardTypedData * data, int colorMap){
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        cv::Mat srcBGR;
        cv::cvtColor(src, srcBGR, CV_BGRA2BGR);
        cv::applyColorMap(srcBGR, dst, colorMap);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;
}


@end
