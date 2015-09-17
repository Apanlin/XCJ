//
//  AderWallDelegateProtocal.h
//  AderWall-SDK
//
//  Created by renren on 12-6-5.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{	
    MODEL_TEST,    //测试模式	
    MODEL_RELEASE  //发布模式	
    
} Model;

@class AderWall;

@protocol AderWallDelegate <NSObject>
@optional

//开启服务失败
-(void)aderWallFaildToShow:(NSError *)error;

//广告墙视图成功展示
-(void)aderWallDidReceiveSuccess:(UIViewController *)aderWall;

//广告墙视图移除
-(void)aderWallCloseActionCallBack:(UIViewController *)aderWall;

/**
 *查询积分接口回调
 */
- (void) aderWallQuery:(BOOL)status Score:(long long)score WithMessage:(NSString *)message;;

/**
 *减少积分接口回调
 */
- (void) aderWallReducscore:(BOOL)status WithMessage:(NSString *)message;


@end
