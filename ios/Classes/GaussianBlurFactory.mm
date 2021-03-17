//
//  GaussianBlurFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "GaussianBlurFactory.h"
#import "Util.h"

@implementation GaussianBlurFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data kernelSize: (double[]) kernelSizeDouble sigmaX: (double) sigmaX result: (FlutterResult) result{
    
    
    switch (pathType) {
        case 1:
            result(gaussianBlurS(pathString, kernelSizeDouble, sigmaX));
            break;
        case 2:
            result(gaussianBlurB(data, kernelSizeDouble, sigmaX));
            break;
        case 3:
            result(gaussianBlurB(data, kernelSizeDouble, sigmaX));
            break;
        
        default:
            break;
    }
    
}

FlutterStandardTypedData * gaussianBlurS(NSString * pathString, double kernelSize[], double sigmaX) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    //anchorPoint, borderType ---> solo android
    if ([Util verificarImagen]) {
        NSData * respuesta;
        if((int) kernelSize[0] % 2 == 1 && (int)kernelSize[1] % 2 == 1){
            cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
            cv::Mat dst;
            cv::Size size = cv::Size(kernelSize[0], kernelSize[1]);
            cv::GaussianBlur(src, dst, size, sigmaX);
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

FlutterStandardTypedData * gaussianBlurB(FlutterStandardTypedData * data, double kernelSize[], double sigmaX) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        NSData * respuesta;
        
        if((int) kernelSize[0] % 2 == 1 && (int)kernelSize[1] % 2 == 1){
           
            cv::Mat dst;
            cv::Size size = cv::Size(kernelSize[0], kernelSize[1]);
            cv::GaussianBlur(src, dst, size, sigmaX);
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
