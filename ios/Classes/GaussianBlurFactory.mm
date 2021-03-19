//
//  GaussianBlurFactory.m
//  Runner
//
//  Created by Fernando on 12/03/2021.
//

#import "GaussianBlurFactory.h"

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
    

    CGColorSpaceRef colorSpace;
    const char * suffix;
    int bytesInFile;
    const char * command;
    std::vector<uint8_t> fileData;
    bool puedePasar = false;
    FlutterStandardTypedData* resultado;
    
    
    command = [pathString cStringUsingEncoding:NSUTF8StringEncoding];
    
    FILE* file = fopen(command, "rb");
    fseek(file, 0, SEEK_END);
    bytesInFile = (int) ftell(file);
    fseek(file, 0, SEEK_SET);
    std::vector<uint8_t> file_data(bytesInFile);
    fread(file_data.data(), 1, bytesInFile, file);
    fclose(file);
    
    fileData = file_data;
    
    NSData *imgOriginal = [NSData dataWithBytes: file_data.data()
                                   length: bytesInFile];
    
    
    suffix = strrchr(command, '.');
    if (!suffix || suffix == command) {
        suffix = "";
    }
    
    if (strcasecmp(suffix, ".png") == 0 || strcasecmp(suffix, ".jpg") == 0 || strcasecmp(suffix, ".jpeg") == 0) {
        puedePasar = true;
    }
 
    
    if (puedePasar) {
        NSData * respuesta;
        if((int) kernelSize[0] % 2 == 1 && (int)kernelSize[1] % 2 == 1){
            
            
            CFDataRef file_data_ref = CFDataCreateWithBytesNoCopy(NULL, fileData.data(),
                                                                  bytesInFile,
                                                                  kCFAllocatorNull);
            
            CGDataProviderRef image_provider = CGDataProviderCreateWithCFData(file_data_ref);
            
            CGImageRef image = nullptr;
            if (strcasecmp(suffix, ".png") == 0) {
                image = CGImageCreateWithPNGDataProvider(image_provider, NULL, true,
                                                         kCGRenderingIntentDefault);
            } else if ((strcasecmp(suffix, ".jpg") == 0) ||
                       (strcasecmp(suffix, ".jpeg") == 0)) {
                image = CGImageCreateWithJPEGDataProvider(image_provider, NULL, true,
                                                          kCGRenderingIntentDefault);
            }
            
            colorSpace = CGImageGetColorSpace(image);
            CGFloat cols = CGImageGetWidth(image);
            CGFloat rows = CGImageGetHeight(image);
            
            cv::Mat src(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
            
            CGContextRef contextRef = CGBitmapContextCreate(src.data,                 // Pointer to  data
                                                             cols,                       // Width of bitmap
                                                             rows,                       // Height of bitmap
                                                             8,                          // Bits per component
                                                             src.step[0],              // Bytes per row
                                                             colorSpace,                 // Colorspace
                                                             kCGImageAlphaNoneSkipLast |
                                                             kCGBitmapByteOrderDefault); // Bitmap info flags
            CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image);
            CGContextRelease(contextRef);
            CFRelease(image);
            CFRelease(image_provider);
            CFRelease(file_data_ref);
            
            
            cv::Mat dst;
            cv::Size size = cv::Size(kernelSize[0], kernelSize[1]);
            cv::GaussianBlur(src, dst, size, sigmaX);
            
            
            NSData *data = [NSData dataWithBytes:dst.data length:dst.elemSize()*dst.total()];
            
            if (dst.elemSize() == 1) {
                  colorSpace = CGColorSpaceCreateDeviceGray();
              } else {
                  colorSpace = CGColorSpaceCreateDeviceRGB();
              }
              CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
              // Creating CGImage from cv::Mat
              CGImageRef imageRef = CGImageCreate(dst.cols,                                 //width
                                                 dst.rows,                                 //height
                                                 8,                                          //bits per component
                                                 8 * dst.elemSize(),                       //bits per pixel
                                                 dst.step[0],                            //bytesPerRow
                                                 colorSpace,                                 //colorspace
                                                 kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                                 provider,                                   //CGDataProviderRef
                                                 NULL,                                       //decode
                                                 false,                                      //should interpolate
                                                 kCGRenderingIntentDefault                   //intent
                                                 );
              // Getting UIImage from CGImage
              UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
              CGImageRelease(imageRef);
              CGDataProviderRelease(provider);
              CGColorSpaceRelease(colorSpace);
            
            NSData* imgConvert;
            
            if (strcasecmp(suffix, ".png") == 0) {
                imgConvert = UIImagePNGRepresentation(finalImage);
            } else if ((strcasecmp(suffix, ".jpg") == 0) ||
                       (strcasecmp(suffix, ".jpeg") == 0)) {
                imgConvert = UIImageJPEGRepresentation(finalImage, 1);
            }
            
            
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
    

    CGColorSpaceRef colorSpace;
    const char * suffix;
    std::vector<uint8_t> fileData;
    
    FlutterStandardTypedData* resultado;
    
    cv::Mat src;
    
    
    UInt8* valor1 = (UInt8*) data.data.bytes;
    
    int size = data.elementCount;
    

    CFDataRef file_data_ref = CFDataCreateWithBytesNoCopy(NULL, valor1,
                                                          size,
                                                          kCFAllocatorNull);
    
    CGDataProviderRef image_provider = CGDataProviderCreateWithCFData(file_data_ref);
    
    CGImageRef image = nullptr;
    
    image = CGImageCreateWithPNGDataProvider(image_provider, NULL, true,
                                                 kCGRenderingIntentDefault);
    suffix = (char*)".png";
    if (image == nil) {
        image = CGImageCreateWithJPEGDataProvider(image_provider, NULL, true,
                                                  kCGRenderingIntentDefault);
        suffix = (char*)".jpg";
    }
    
    if (image == nil) {
        suffix = (char*)"otro";
    }
    
    if(!(strcasecmp(suffix, "otro") == 0)){
        colorSpace = CGImageGetColorSpace(image);
        CGFloat cols = CGImageGetWidth(image);
        CGFloat rows = CGImageGetHeight(image);
        
        src = cv::Mat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
        CGContextRef contextRef = CGBitmapContextCreate(src.data,                 // Pointer to  data
                                                         cols,                       // Width of bitmap
                                                         rows,                       // Height of bitmap
                                                         8,                          // Bits per component
                                                         src.step[0],              // Bytes per row
                                                         colorSpace,                 // Colorspace
                                                         kCGImageAlphaNoneSkipLast |
                                                         kCGBitmapByteOrderDefault); // Bitmap info flags
        CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image);
        CGContextRelease(contextRef);
        CFRelease(image);
        CFRelease(image_provider);
        CFRelease(file_data_ref);
    } else {
        src = cv::Mat();
    }
    
    
    if(src.empty()){
        resultado = [FlutterStandardTypedData typedDataWithBytes: data.data];
    } else {
        NSData * respuesta;
        
        if((int) kernelSize[0] % 2 == 1 && (int)kernelSize[1] % 2 == 1){
           
            cv::Mat dst;
            cv::Size size = cv::Size(kernelSize[0], kernelSize[1]);
            cv::GaussianBlur(src, dst, size, sigmaX);
            
            //********
            
            //NSData * imgConvert = [Util getImageConvert:dst];
            NSData *data = [NSData dataWithBytes:dst.data length:dst.elemSize()*dst.total()];
            
            if (dst.elemSize() == 1) {
                  colorSpace = CGColorSpaceCreateDeviceGray();
              } else {
                  colorSpace = CGColorSpaceCreateDeviceRGB();
              }
              CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
              // Creating CGImage from cv::Mat
              CGImageRef imageRef = CGImageCreate(dst.cols,                                 //width
                                                 dst.rows,                                 //height
                                                 8,                                          //bits per component
                                                 8 * dst.elemSize(),                       //bits per pixel
                                                 dst.step[0],                            //bytesPerRow
                                                 colorSpace,                                 //colorspace
                                                 kCGImageAlphaNone|kCGBitmapByteOrderDefault,// bitmap info
                                                 provider,                                   //CGDataProviderRef
                                                 NULL,                                       //decode
                                                 false,                                      //should interpolate
                                                 kCGRenderingIntentDefault                   //intent
                                                 );
              // Getting UIImage from CGImage
              UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
              CGImageRelease(imageRef);
              CGDataProviderRelease(provider);
              CGColorSpaceRelease(colorSpace);
            
            NSData* imgConvert;
            
            if (strcasecmp(suffix, ".png") == 0) {
                imgConvert = UIImagePNGRepresentation(finalImage);
            } else if ((strcasecmp(suffix, ".jpg") == 0) ||
                       (strcasecmp(suffix, ".jpeg") == 0)) {
                imgConvert = UIImageJPEGRepresentation(finalImage, 1);
            }
            
            //********
            
            respuesta = imgConvert;
            
        } else {
            
            respuesta = data.data;
        }
        
        
        resultado = [FlutterStandardTypedData typedDataWithBytes: respuesta];
    }
    
    return resultado;
}


@end
