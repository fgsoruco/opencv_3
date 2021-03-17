//
//  Filter2DFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "Filter2DFactory.h"
#import "Util.h"

@implementation Filter2DFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data outputDepth: (int)outputDepth kernelSize: (int[]) kernelSizeDouble result: (FlutterResult) result{
    
    switch (pathType) {
        case 1:
            result(filter2DS(pathString, outputDepth, kernelSizeDouble));
            break;
        case 2:
            result(filter2DB(data, outputDepth, kernelSizeDouble));
            break;
        case 3:
            result(filter2DB(data, outputDepth, kernelSizeDouble));
            break;
        
        default:
            break;
    }
    
}


FlutterStandardTypedData * filter2DS(NSString * pathString, int outputDepth, int kernelSize[]) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    if ([Util verificarImagen]) {
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        // Creating kernel matrix
        cv::Mat kernel = cv::Mat::ones(kernelSize[0], kernelSize[1], CV_32F);
        cv::filter2D(src, dst, outputDepth, kernel);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
        
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * filter2DB(FlutterStandardTypedData * data, int outputDepth, int kernelSize[]) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        
        // Creating kernel matrix
        cv::Mat kernel = cv::Mat::ones(kernelSize[0], kernelSize[1], CV_32F);
        
        cv::filter2D(src, dst, outputDepth, kernel);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;
}


@end
