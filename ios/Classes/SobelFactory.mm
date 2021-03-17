//
//  SobelFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "SobelFactory.h"
#import "Util.h"

@implementation SobelFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data depth: (int)depth dx: (int) dx dy: (int) dy result: (FlutterResult) result{
    
    switch (pathType) {
        case 1:
            result(sobelS(pathString, depth, dx, dy));
            break;
        case 2:
            result(sobelB(data, depth, dx, dy));
            break;
        case 3:
            result(sobelB(data, depth, dx, dy));
            break;
        
        default:
            break;
    }
    
}


FlutterStandardTypedData * sobelS(NSString * pathString, int depth, int dx, int dy) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    if ([Util verificarImagen]) {
        
        NSData * respuesta;
        if (dx >= 0 && dy >= 0 && dx+dy == 1) {
            cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
            cv::Mat dst;
            cv::Sobel(src, dst, depth, dx, dy);
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

FlutterStandardTypedData * sobelB(FlutterStandardTypedData * data, int depth, int dx, int dy) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        NSData * respuesta;
        if (dx >= 0 && dy >= 0 && dx+dy == 1) {
            cv::Mat dst;
            cv::Sobel(src, dst, depth, dx, dy);
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
