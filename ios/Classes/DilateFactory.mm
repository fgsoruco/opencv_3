//
//  DilateFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "DilateFactory.h"
#import "Util.h"

@implementation DilateFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data kernelSize:(double [])kernelSizeDouble result:(FlutterResult)result{
    
    switch (pathType) {
        case 1:
            result(dilateS(pathString, kernelSizeDouble));
            break;
        case 2:
            result(dilateB(data, kernelSizeDouble));
            break;
        case 3:
            result(dilateB(data, kernelSizeDouble));
            break;
        
        default:
            break;
    }
}

FlutterStandardTypedData * dilateS(NSString * pathString, double kernelSize[]) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    if ([Util verificarImagen]) {
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        // Preparing the kernel matrix object
        cv::Mat kernel = cv::getStructuringElement(cv::MORPH_RECT, cv::Size(((kernelSize[0] * kernelSize[1]) + 1), ((kernelSize[0] * kernelSize[1]) + 1)));
        cv::dilate(src, dst, kernel);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
        
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * dilateB(FlutterStandardTypedData * data, double kernelSize[]) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        // Preparing the kernel matrix object
        cv::Mat kernel = cv::getStructuringElement(cv::MORPH_RECT, cv::Size(((kernelSize[0] * kernelSize[1]) + 1), ((kernelSize[0] * kernelSize[1]) + 1)));
        cv::dilate(src, dst, kernel);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;
}



@end
