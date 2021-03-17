//
//  Created by fgsoruco@gmail.com ©2021.
//

#import "CvtColorFactory.h"
#import "Util.h"

@implementation CvtColorFactory


+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data outputType:(int)outputType result:(FlutterResult)result{
    
    switch (pathType) {
        case 1:
            result(cvtColor(pathString, outputType));
            break;
        case 2:
            result(cvtColorB(data,outputType));
            break;
        case 3:
            result(cvtColorB(data,outputType));
            break;
        
        default:
            break;
    }
    
}

FlutterStandardTypedData * cvtColor(NSString * pathString, int outputType) {
    
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    if ([Util verificarImagen]) {
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        cv::cvtColor(src, dst, outputType);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * cvtColorB(FlutterStandardTypedData * data, int outputType){
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        cv::cvtColor(src, dst, outputType);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;
}


@end
