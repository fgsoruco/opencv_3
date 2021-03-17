//
//  Util.h
//  Runner
//
//  Created by Fernando on 08/03/2021.
//
#ifdef __cplusplus
#undef NO
#import <opencv2/opencv.hpp>
#endif
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface Util : NSObject

+ (NSData*) getDataFromPath: (NSString*) image_path;
+ (bool) verificarImagen;
+ (cv::Mat) getMatFromByte: (const UInt8 *) bytes;
+ (NSData *) getImageConvert: (cv::Mat) dest;
+ (cv::Mat) flutterData2Mat: (FlutterStandardTypedData *) imgOriginal;
+ (std::vector<uint8_t>) getFileData;

@end

NS_ASSUME_NONNULL_END
