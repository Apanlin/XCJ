//
//  MHFileManager.h
//  
//  Created by Lin Pan on 13-3-7.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHFileManager : NSObject
{
    NSString *_filePath;
    NSMutableDictionary *_allDict;
    
    BOOL _bOpen;
}

@property(assign,nonatomic) BOOL bOpen;

+(MHFileManager *)instance;

-(id)initWithFilePath:(NSString *)path;
-(BOOL)open;
-(BOOL)close;

-(NSDictionary *)getAllManHua; //返回所有漫画，字典形式，
-(NSArray *)getAllAlbumNames; //返回所有漫画集的名字数组
-(NSArray *)getMHsFromAlbum:(NSString *)albumName; //返回对应专辑明的所有漫画名字

-(NSInteger)getMHCount;
-(void)addMHWithKey:(id)dictionary forKey:(NSString *)key;
-(void)removeMHWithKey:(NSString *)key;
-(BOOL)isMHExistForKey:(NSString*)key;

- (NSString *)getAlbumHeadIcon:(NSString *)albumName;


@end
