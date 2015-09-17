//
//  NSString+Common.m
//  HappyShare
//
//  Created by Lin Pan on 13-3-20.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

+ (NSString *)stringWithNowDate
{
    NSDate *nowDate = [NSDate date];
    NSString *formatter = @"yyyy-MM-dd";
    
    return [NSString stringWithDate:nowDate formater:formatter];
    
}

+ (NSString *)stringWithDate:(NSDate *)date formater:(NSString *)formater
{
    if (!date || !formater) {
        return  nil;
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formater];
    return [formatter stringFromDate:date];
}

+ (NSString *)stringWithSize:(float)fileSize
{
    NSString *sizeStr;
    if(fileSize/1024.0/1024.0/1024.0 > 1)
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fG",fileSize/1024.0/1024.0/1024.0];
    }
    else if(fileSize/1024.0/1024.0 > 1 && fileSize/1024.0/1024.0 < 1024 )
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fM",fileSize/1024.0/1024.0];
    }
    else
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fK",fileSize/1024.0];
    }
    
    return sizeStr;

}
@end
