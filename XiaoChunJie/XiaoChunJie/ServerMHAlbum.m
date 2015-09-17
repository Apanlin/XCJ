//
//  ServerMHAlbum.m
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-16.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "ServerMHAlbum.h"

@implementation ServerMHAlbum
@synthesize name = _name;
@synthesize time = _time;
@synthesize url = _url;
@synthesize imgUrl =_imgUrl;
@synthesize size = _size;
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.time = [dic objectForKey:@"time"];
        self.name = [dic objectForKey:@"name"];
        self.url = [dic objectForKey:@"path"];
        self.imgUrl = [dic objectForKey:@"imgurl"];
        self.size = [dic objectForKey:@"size"];
    }
    
    return self;
}

- (void)dealloc
{
    [self.name release];
    [self.time release];
    [self.url release];
    [self.imgUrl release];
    [self.size release];
    [super dealloc];
}

-(NSString *)description{
    NSString *str = [NSString stringWithFormat:@"name = %@,time = %@,path = %@,size = %@,imgUrl = %@",self.name,self.time,self.url,self.size,self.imgUrl];
    return str;
}

@end
