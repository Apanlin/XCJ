//
//  NSString+Common.h
//  HappyShare
//
//  Created by Lin Pan on 13-3-20.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Common)

//获取当前的时间，转成字符串 格式默认为 yyyy-MM-dd
+ (NSString *)stringWithNowDate;
+ (NSString *)stringWithDate:(NSDate *)date formater:(NSString *)formater;

//转换文件大小成字符串,
//fileSize 单位：B   结果格式为 *.*G *.*M  ...
+ (NSString *)stringWithSize:(float)fileSize;
@end
