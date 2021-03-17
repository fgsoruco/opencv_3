//
//  ScharrFactory.h
//  Runner
//
//  Created by Fernando on 12/03/2021.
//
#ifdef __cplusplus
#undef NO
#import <opencv2/opencv.hpp>
#endif
#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScharrFactory : NSObject

//depth: Int, dx: Int, dy: Int
+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data depth: (int)depth dx: (int) dx dy: (int) dy result: (FlutterResult) result;


@end

NS_ASSUME_NONNULL_END
