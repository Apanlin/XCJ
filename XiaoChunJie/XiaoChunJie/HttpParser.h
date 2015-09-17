//
//  HttpParser.h
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-17.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpParser : NSObject

+ (NSArray *)pareserMHAlbum:(NSString *)responseStr;
@end
