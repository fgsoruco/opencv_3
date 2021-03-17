//
//  MorphologyExFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "MorphologyExFactory.h"
#import "Util.h"

@implementation MorphologyExFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data operation: (int)operation kernelSize: (int[]) kernelSizeDouble result: (FlutterResult) result{
    
    switch (pathType) {
        case 1:
            result(morphologyExS(pathString, operation, kernelSizeDouble));
            break;
        case 2:
            result(morphologyExB(data, operation, kernelSizeDouble));
            break;
        case 3:
            result(morphologyExB(data, operation, kernelSizeDouble));
            break;
        
        default:
            break;
    }
    
}


FlutterStandardTypedData * morphologyExS(NSString * pathString, int operation, int kernelSize[]) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    if ([Util verificarImagen]) {
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        // Creating kernel matrix
        cv::Mat kernel = cv::Mat::ones(kernelSize[0], kernelSize[1], CV_32F);
        cv::morphologyEx(src, dst, operation, kernel);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
        
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * morphologyExB(FlutterStandardTypedData * data, int operation, int kernelSize[]) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        
        // Creating kernel matrix
        cv::Mat kernel = cv::Mat::ones(kernelSize[0], kernelSize[1], CV_32F);
        
        cv::morphologyEx(src, dst, operation, kernel);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;
}


@end
