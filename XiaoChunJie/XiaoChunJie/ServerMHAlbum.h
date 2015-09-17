//
//  ServerMHAlbum.h
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-16.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerMHAlbum : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *imgUrl;
@property(nonatomic,copy) NSString *size;
- (id)initWithDic:(NSDictionary *)dic;
@end
