//
//  MedianBlurFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "MedianBlurFactory.h"
#import "Util.h"

@implementation MedianBlurFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data kernelSize:(int)kernelSize result:(FlutterResult)result{
    
    switch (pathType) {
        case 1:
            result(medianBlurS(pathString, kernelSize));
            break;
        case 2:
            result(medianBlurB(data, kernelSize));
            break;
        case 3:
            result(medianBlurB(data, kernelSize));
            break;
        
        default:
            break;
    }
    
}

FlutterStandardTypedData * medianBlurS(NSString * pathString, int kernelSize) {
    
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    if ([Util verificarImagen]) {
        
        NSData * respuesta;
        if(kernelSize % 2 == 1){
            cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
            cv::Mat dst;
            cv::medianBlur(src, dst, kernelSize);
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

FlutterStandardTypedData * medianBlurB(FlutterStandardTypedData * data, int kernelSize){
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        
        NSData * respuesta;
        if(kernelSize % 2 == 1){
            cv::Mat dst;
            cv::medianBlur(src, dst, kernelSize);
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
