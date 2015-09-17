//
//  FilesManager.m
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-7.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "FilesManager.h"

@implementation FilesManager


+(BOOL) isFileExists:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}
//沙盒路径
+ (NSString *)getDocumentPath
{
    NSArray *storeFilePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentsDirectiory = [storeFilePath objectAtIndex:0];
    return doucumentsDirectiory;
}

+ (BOOL)createFile:(NSString *)filePath
{
    return [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
}

+ (BOOL)deleteFile:(NSString *)filePath
{
    return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}
@end
