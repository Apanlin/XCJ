//
//  FilesManager.h
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-7.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilesManager : NSObject
{
    
}

+ (BOOL)isFileExists:(NSString *)filePath;
+ (NSString *)getDocumentPath;

+ (BOOL)createFile:(NSString *)filePath;
+ (BOOL)deleteFile:(NSString *)filePath;
@end
