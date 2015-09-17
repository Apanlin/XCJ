//
//  MHFileManager.m
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-7.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "MHFileManager.h"
#import "FilesManager.h"
@implementation MHFileManager

@synthesize bOpen = _bOpen;

+(MHFileManager *)instance
{
    
    static MHFileManager *instance;
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[MHFileManager alloc] initWithFilePath:kMHPlistFilePath];
        }
    }
    
    return instance;
}



-(id)initWithFilePath:(NSString *)path
{
    self = [super init];
    if (self) {
        _filePath = [path copy];
    }
    return self;
}

-(void)dealloc
{
    [_filePath release];
    [super dealloc];
}

-(BOOL)open
{
    if (!_bOpen)
    {
        if (_filePath)
        {
            if (![FilesManager isFileExists:_filePath])
            {
                if (![FilesManager createFile:_filePath])
                {
                    return NO;
                }
            }
            
            _allDict = [[NSMutableDictionary dictionaryWithContentsOfFile:_filePath] retain];
            if (!_allDict)
            {
                _allDict = [[NSMutableDictionary alloc] init];
            }
            _bOpen = YES;
            return YES;
        }
    }
    
    
    return  YES;
}

-(BOOL)close
{
    _bOpen = NO;
    if([_allDict writeToFile:_filePath atomically:YES]){
        DLog(@"write ok!");
        return YES;
    }else{
        DLog(@"write wrong");
        return NO;
    }
    
    
}


-(NSDictionary *)getAllManHua
{
    if (_allDict)
    {
        return  (NSDictionary *)_allDict;
    }
    else
    {
        DLog(@"文件未打开");
        return nil;
    }
}


//判断key的书是否存在
-(BOOL)isMHExistForKey:(NSString*)key{
    

    if (_allDict)
    {
        //根目录下存在名为bookname的字典
        if ([_allDict objectForKey:key])
        {
            return YES;
        }
    }
    else{
        DLog(@"isMHExistForKey出错，文件未打开！");
    }
    
    return  NO;
 
}


//根据key值删除对应书籍
-(void)removeMHWithKey:(NSString *)key
{
    if (_allDict)
    {
        [_allDict removeObjectForKey:key];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@",kDocumentPath,key];
        [FilesManager deleteFile:filePath];
    }
    else
    {
        DLog(@"删除出错，文件未打开！");
    }

    
}


//将dictionary写入plist文件，前提：dictionary已经准备好
-(void)addMHWithKey:(id)dictionary forKey:(NSString *)key{
    
    if (_allDict)
    {
        //增加一个数据
        [_allDict setValue:dictionary forKey:key]; //在plistDictionary增加一个key为...的value
    }
    else
    {
        DLog(@"addMHWithKey 出错，文件未打开！");
    }

    
}

-(NSInteger)getMHCount
{
    if (!_allDict)
    {
         DLog(@"getMHCount 出错，文件未打开！");
        return 0;
    }
    return [_allDict count];
}

-(NSArray *)getAllAlbumNames
{
    if (_allDict) {
        return [_allDict allKeys];
    }
    else{
        DLog(@"文件未打开");
    }
    return  nil;
}

-(NSArray *) getMHsFromAlbum:(NSString *)albumName
{
    if (_allDict)
    {
        NSArray *album = [_allDict valueForKey:albumName];
        NSLog(@"album %@",album);
//        NSArray *mhs = [album allValues];
        
//        NSComparator cmptr = ^(id obj1, id obj2){
//            NSLog(@"%d",[obj1 intValue]);
//            if ([obj1 intValue] > [obj2 intValue]) {
//                return (NSComparisonResult)NSOrderedDescending;
//            }
//            
//            if ([obj1 intValue]  < [obj2 intValue]) {
//                return (NSComparisonResult)NSOrderedAscending;
//            }
//            return (NSComparisonResult)NSOrderedSame;
//        };
//        mhs =  [mhs sortedArrayUsingComparator:cmptr];
        
        NSMutableArray * mhPathArr = [[NSMutableArray alloc] init];
        for (id name in album)
        {
            NSString *mhPath = [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",albumName,name]];
            [mhPathArr addObject:mhPath];
        }
        return [mhPathArr autorelease];
    }
    else
    {
        DLog(@"文件未打开");
        return  nil;
    }
    
}

- (NSString *)getAlbumHeadIcon:(NSString *)albumName
{
    return  [kDocumentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/icon.png",albumName]];
}

@end
