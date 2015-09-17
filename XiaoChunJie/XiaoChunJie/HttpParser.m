//
//  HttpParser.m
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-17.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "HttpParser.h"
#import "JSONKit.h"
#import "ServerMHAlbum.h"
@implementation HttpParser


+ (NSArray *)pareserMHAlbum:(NSString *)responseStr
{
    NSMutableArray *mhAlbumArr = [[NSMutableArray alloc] init];
    NSData *myDate = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *serverMHArr = [myDate objectFromJSONData];
    //处理
    DLog(@"%@",serverMHArr);
    if (serverMHArr)
    {
        for (id obj in serverMHArr )
        {
            ServerMHAlbum *album = [[ServerMHAlbum alloc] initWithDic:obj];
            [mhAlbumArr addObject:album];
            [album release];
        }
        
        return [mhAlbumArr autorelease];
    }
    
    return  nil;
}
@end
