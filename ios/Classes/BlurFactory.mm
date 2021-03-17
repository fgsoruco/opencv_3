//
//  BlurFactory.m
//  Runner
//
//  Created by Fernando on 08/03/2021.
//

#import "BlurFactory.h"
#import "Util.h"

@implementation BlurFactory

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data kernelSize: (double[]) kernelSizeInt anchorPoint:(double[]) anchorPointInt borderType: (int) borderType result: (FlutterResult) result{
    
    
    switch (pathType) {
        case 1:
            result(blur(pathString, kernelSizeInt, anchorPointInt, borderType));
            break;
        case 2:
            result(blurB(data, kernelSizeInt, anchorPointInt, borderType));
            break;
        case 3:
            result(blurB(data, kernelSizeInt, anchorPointInt, borderType));
            break;
        
        default:
            break;
    }
    
}

FlutterStandardTypedData * blur(NSString * pathString, double kernelSize[], double anchorPoint[], int borderType) {
    FlutterStandardTypedData* resultado;
    NSData *imgOriginal = [Util getDataFromPath:pathString];
    
    //anchorPoint, borderType ---> solo android
    if ([Util verificarImagen]) {
        cv::Mat src = [Util getMatFromByte:[Util getFileData].data()];
        cv::Mat dst;
        cv::Size size = cv::Size(kernelSize[0], kernelSize[1]);
        cv::Point anchorPointP = cv::Point(anchorPoint[0], anchorPoint[1]);
        cv::blur(src, dst, size, anchorPointP, borderType);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
        
    } else {
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgOriginal];
    }
    
    return resultado;
}

FlutterStandardTypedData * blurB(FlutterStandardTypedData * data, double kernelSize[], double anchorPoint[], int borderType) {
    
    FlutterStandardTypedData* resultado;
    cv::Mat src = [Util flutterData2Mat:data];
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        cv::Mat dst;
        cv::Size size = cv::Size(kernelSize[0], kernelSize[1]);
        cv::Point anchorPointP = cv::Point(anchorPoint[0], anchorPoint[1]);
        cv::blur(src, dst, size, anchorPointP, borderType);
        NSData * imgConvert = [Util getImageConvert:dst];
        resultado = [FlutterStandardTypedData typedDataWithBytes: imgConvert];
    }
    
    return resultado;
}

@end
