//
//  BilateralFilterFactory.m
//  Runner
//
//  Created by Fernando on 08/03/2021.
//

#import "BilateralFilterFactory.h"
#import "Util.h"

@implementation BilateralFilterFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data diameter:(int)diameter sigmaColor:(double)sigmaColor sigmaSpace:(double)sigmaSpace borderType:(int)borderType result:(FlutterResult)result{
    
    switch (pathType) {
        case 1:
            result(bilateralFilterS(pathString, diameter, sigmaColor, sigmaSpace, borderType));
            break;
        case 2:
            result(bilateralFilterB(data, diameter, sigmaColor, sigmaSpace, borderType));
            break;
        case 3:
            result(bilateralFilterB(data, diameter, sigmaColor, sigmaSpace, borderType));
            break;
        
        default:
            break;
    }
    
}

FlutterStandardTypedData * bilateralFilterS(NSString * pathString, int diameter, double sigmaColor, double sigmaSpace, int borderType){
    
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    if ([Util verificarImagen]) {
        
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        cv::Mat srcGray;
        cv::cvtColor(src, srcGray, CV_BGRA2BGR);
        cv::bilateralFilter(srcGray, dst, diameter, sigmaColor, sigmaSpace, borderType);
        
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
        
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    return resultado;
}

FlutterStandardTypedData * bilateralFilterB(FlutterStandardTypedData * data, int diameter, double sigmaColor, double sigmaSpace, int borderType){
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        cv::Mat srcBGR;
        cv::cvtColor(src, srcBGR, CV_BGRA2BGR);
        cv::bilateralFilter(srcBGR, dst, diameter, sigmaColor, sigmaSpace, borderType);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;

}

@end
