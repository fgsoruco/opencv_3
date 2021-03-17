//
//  ThresholdFactory.h
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

@interface ThresholdFactory : NSObject

//thresholdValue: Double, maxThresholdValue: Double, thresholdType: Int

+ (void)processWhitPathType:(int)pathType pathString:(NSString *)pathString data:(FlutterStandardTypedData *)data thresholdValue: (double)thresholdValue maxThresholdValue: (double) maxThresholdValue thresholdType: (int) thresholdType result: (FlutterResult) result;

@end

NS_ASSUME_NONNULL_END
