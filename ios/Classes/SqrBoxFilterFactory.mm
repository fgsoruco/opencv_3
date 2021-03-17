//
//  SqrBoxFilterFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "SqrBoxFilterFactory.h"
#import "Util.h"

@implementation SqrBoxFilterFactory


+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data outputDepth: (int)outputDepth kernelSize: (double[]) kernelSizeDouble result: (FlutterResult) result{
    
    switch (pathType) {
        case 1:
            result(sqrBoxFilterS(pathString, outputDepth, kernelSizeDouble));
            break;
        case 2:
            result(sqrBoxFilterB(data, outputDepth, kernelSizeDouble));
            break;
        case 3:
            result(sqrBoxFilterB(data, outputDepth, kernelSizeDouble));
            break;
        
        default:
            break;
    }
    
}


FlutterStandardTypedData * sqrBoxFilterS(NSString * pathString, int outputDepth, double kernelSize[]) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    if ([Util verificarImagen]) {
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        cv::Size size = cv::Size(kernelSize[0], kernelSize[1]);
        cv::sqrBoxFilter(src, dst, outputDepth, size);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
        
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * sqrBoxFilterB(FlutterStandardTypedData * data, int outputDepth, double kernelSize[]) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        cv::Size size = cv::Size(kernelSize[0], kernelSize[1]);
        cv::sqrBoxFilter(src, dst, outputDepth, size);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;
}

@end
