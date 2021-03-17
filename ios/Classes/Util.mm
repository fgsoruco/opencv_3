//
//  Util.m
//  Runner
//
//  Created by Fernando on 08/03/2021.
//

#import "Util.h"

@implementation Util

CGColorSpaceRef colorSpace;
const char * suffix;
int bytesInFile;
const char * command;
std::vector<uint8_t> fileData;


+ (NSData*) getDataFromPath: (NSString*) image_path {
    command = [image_path cStringUsingEncoding:NSUTF8StringEncoding];
    
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
    
    return imgOriginal;
}


+ (bool) verificarImagen{
    suffix = strrchr(command, '.');
    if (!suffix || suffix == command) {
        suffix = "";
    }
    
    if (strcasecmp(suffix, ".png") == 0 || strcasecmp(suffix, ".jpg") == 0 || strcasecmp(suffix, ".jpeg") == 0) {
        return true;
    }
    return false;
}

+ (cv::Mat) getMatFromByte: (const UInt8 *) bytes{
    CFDataRef file_data_ref = CFDataCreateWithBytesNoCopy(NULL, bytes,
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
    
    cv::Mat srcMat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(srcMat.data,                 // Pointer to  data
                                                     cols,                       // Width of bitmap
                                                     rows,                       // Height of bitmap
                                                     8,                          // Bits per component
                                                     srcMat.step[0],              // Bytes per row
                                                     colorSpace,                 // Colorspace
                                                     kCGImageAlphaNoneSkipLast |
                                                     kCGBitmapByteOrderDefault); // Bitmap info flags
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image);
    CGContextRelease(contextRef);
    CFRelease(image);
    CFRelease(image_provider);
    CFRelease(file_data_ref);
    
    return srcMat;
}


+ (NSData *) getImageConvert: (cv::Mat) dest{
    NSData *data = [NSData dataWithBytes:dest.data length:dest.elemSize()*dest.total()];
    
    if (dest.elemSize() == 1) {
          colorSpace = CGColorSpaceCreateDeviceGray();
      } else {
          colorSpace = CGColorSpaceCreateDeviceRGB();
      }
      CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
      // Creating CGImage from cv::Mat
      CGImageRef imageRef = CGImageCreate(dest.cols,                                 //width
                                         dest.rows,                                 //height
                                         8,                                          //bits per component
                                         8 * dest.elemSize(),                       //bits per pixel
                                         dest.step[0],                            //bytesPerRow
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
    
    return imgConvert;
}


+ (cv::Mat) flutterData2Mat: (FlutterStandardTypedData *) imgOriginal{
    cv::Mat tmpMat;
    
    
    UInt8* valor1 = (UInt8*) imgOriginal.data.bytes;
    
    int size = imgOriginal.elementCount;
    

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
        
        tmpMat = cv::Mat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
        CGContextRef contextRef = CGBitmapContextCreate(tmpMat.data,                 // Pointer to  data
                                                         cols,                       // Width of bitmap
                                                         rows,                       // Height of bitmap
                                                         8,                          // Bits per component
                                                         tmpMat.step[0],              // Bytes per row
                                                         colorSpace,                 // Colorspace
                                                         kCGImageAlphaNoneSkipLast |
                                                         kCGBitmapByteOrderDefault); // Bitmap info flags
        CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image);
        CGContextRelease(contextRef);
        CFRelease(image);
        CFRelease(image_provider);
        CFRelease(file_data_ref);
    } else {
        tmpMat = cv::Mat();
    }
    
    return tmpMat;
}

+ (std::vector<uint8_t>)getFileData{
    return fileData;
}


@end
