//
//  AderPointWall.h
//  AderWall-SDK
//
//  Created by renren on 12-8-16.
//  Copyright (c) 2012年 renren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AderWallDelegate.h"

@interface AderPointWall : UIViewController

/*! 
 @method        startPointWallServiceWithAppid:
 
 @abstract      启动积分墙服务程序
 
 */
- (void)startPointWallService;


/*! 
 @method        getAderPoints
 
 @abstract      查询用户积分
 
 
 */
-(void)getAderPoints;

/*! 
 @method        spendAderPoints:
 
 @abstract      消费用户积分
 
 */
-(void)spendAderPoints;


/*! 
 @method        setDelegate:
 
 @abstract      设置委托，接收SDK反馈
 
 */
@property (nonatomic,assign)id<AderWallDelegate>delegate;

/*! 
 @method        setAppId:
 
 @abstract      设置appId
 
 */
@property (nonatomic,copy)NSString *appId;

/*! 
 @method        initWithAppId:Delegate:Model:
 
 @abstract      初始化AderWall
 
 */

- (id)initWithAppId:(NSString *)appId Delegate:(id<AderWallDelegate>)delegate Model:(Model)model;

/*弹出积分墙
 */

- (void)displayWallWithViewController:(UIViewController *)rootViewController;


/*关闭积分墙
 */
- (void)dismissWall;

@end
