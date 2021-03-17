//
//  BoxFilterFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "BoxFilterFactory.h"
#import "Util.h"

@implementation BoxFilterFactory


+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data outputDepth: (int)outputDepth kernelSize: (double[]) kernelSizeDouble anchorPoint:(double[]) anchorPointDouble normalize:(bool)normalize   borderType: (int) borderType result: (FlutterResult) result{
    
    switch (pathType) {
        case 1:
            result(boxFilterS(pathString, outputDepth, kernelSizeDouble, anchorPointDouble, normalize, borderType));
            break;
        case 2:
            result(boxFilterB(data, outputDepth, kernelSizeDouble, anchorPointDouble, normalize, borderType));
            break;
        case 3:
            result(boxFilterB(data, outputDepth, kernelSizeDouble, anchorPointDouble, normalize, borderType));
            break;
        
        default:
            break;
    }
    
}


FlutterStandardTypedData * boxFilterS(NSString * pathString, int outputDepth, double kernelSize[], double anchorPoint[], bool normalize, int borderType) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    if ([Util verificarImagen]) {
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        cv::Size size = cv::Size(kernelSize[0], kernelSize[1]);
        cv::Point point = cv::Point(anchorPoint[0], anchorPoint[1]);
        cv::boxFilter(src, dst, outputDepth, size, point, normalize, borderType);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
        
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * boxFilterB(FlutterStandardTypedData * data, int outputDepth, double kernelSize[], double anchorPoint[], bool normalize, int borderType) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        cv::Size size = cv::Size(kernelSize[0], kernelSize[1]);
        cv::Point point = cv::Point(anchorPoint[0], anchorPoint[1]);
        cv::boxFilter(src, dst, outputDepth, size, point, normalize, borderType);;
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;
}


@end
