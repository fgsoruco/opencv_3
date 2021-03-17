//
//  AdaptiveThresholdFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "AdaptiveThresholdFactory.h"
#import "Util.h"

@implementation AdaptiveThresholdFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data maxValue: (double)maxValue adaptiveMethod: (int) adaptiveMethod thresholdType: (int) thresholdType blockSize: (int) blockSize constantValue: (int) constantValue result: (FlutterResult) result{
    
    switch (pathType) {
        case 1:
            result(adaptiveThresholdS(pathString, maxValue, adaptiveMethod, thresholdType, blockSize, constantValue));
            break;
        case 2:
            result(adaptiveThresholdB(data, maxValue, adaptiveMethod, thresholdType, blockSize, constantValue));
            break;
        case 3:
            result(adaptiveThresholdB(data, maxValue, adaptiveMethod, thresholdType, blockSize, constantValue));
            break;
        
        default:
            break;
    }
    
}


FlutterStandardTypedData * adaptiveThresholdS(NSString * pathString, double maxValue, int adaptiveMethod, int thresholdType, int blockSize, double constantValue) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    if ([Util verificarImagen]) {
        
        NSData * respuesta;
        if(blockSize % 2 == 1){
            cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
            cv::Mat dst;
            cv::Mat srcGRAY;
            cv::cvtColor(src, srcGRAY, CV_BGRA2GRAY);
            cv::adaptiveThreshold(srcGRAY, dst, maxValue, adaptiveMethod, thresholdType, blockSize, constantValue);
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

FlutterStandardTypedData * adaptiveThresholdB(FlutterStandardTypedData * data, double maxValue, int adaptiveMethod, int thresholdType, int blockSize, double constantValue) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        
        NSData * respuesta;
        if(blockSize % 2 == 1){
            cv::Mat dst;
            cv::Mat srcGRAY;
            cv::cvtColor(src, srcGRAY, CV_BGRA2GRAY);
            cv::adaptiveThreshold(srcGRAY, dst, maxValue, adaptiveMethod, thresholdType, blockSize, constantValue);
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
