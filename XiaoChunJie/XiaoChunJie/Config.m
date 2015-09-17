//
//  Config.m
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-10.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "Config.h"

@implementation Config
+(NSString *)getVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
}
@end
