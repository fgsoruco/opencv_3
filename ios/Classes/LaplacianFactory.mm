//
//  LaplacianFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "LaplacianFactory.h"
#import "Util.h"

@implementation LaplacianFactory


+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data depth:(int)depth result:(FlutterResult)result{
    
    switch (pathType) {
        case 1:
            result(laplacianS(pathString, depth));
            break;
        case 2:
            result(laplacianB(data, depth));
            break;
        case 3:
            result(laplacianB(data, depth));
            break;
        
        default:
            break;
    }
    
}

FlutterStandardTypedData * laplacianS(NSString * pathString, int depth) {
    
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    if ([Util verificarImagen]) {
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        cv::Laplacian(src, dst, depth);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * laplacianB(FlutterStandardTypedData * data, int depth){
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        cv::Laplacian(src, dst, depth);
        NSData * imgConvert = [Util getImageConvert:dst];
        if (imgConvert == nil){
            resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
        } else {
            resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
        }
    }
    
    return resultado;
}

@end
