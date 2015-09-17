//
//  UpdateManager.m
//  XiaoChunJie
//
//  Created by Lin Pan on 13-4-4.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "UpdateManager.h"
#import "ASIHTTPRequest.h"
@implementation UpdateManager


+ (UpdateManager *)shareInstance
{
    static UpdateManager *instance;
    @synchronized(self)
    {
        if (!instance) {
            instance = [[UpdateManager alloc] init];
        }
    }
    return instance;
}

- (void)checkUpdate
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseApiUrl,kCheckVersion]];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        // Use when fetching text data
        if (request.responseString)
        {
            NSLog(@"version %@",request.responseString);
            int versionNum = [request.responseString intValue];
            if (versionNum > kVersionNum)
            {
                _bUpdate = YES;
            }
        }
        else
        {
            DLog(@"网络返回结果出错了");
        }}];
    
    [request startAsynchronous];
}

- (void)postUpdateTip
{
    
    UILocalNotification * localNotification = [[UILocalNotification alloc] init];
    if (localNotification)
    {
        DLog(@"post location Natification");
        localNotification.fireDate= [[[NSDate alloc] init] dateByAddingTimeInterval:1];
        localNotification.timeZone=[NSTimeZone defaultTimeZone];
        localNotification.alertBody = @"小纯洁漫画有新的版本了，点击到App Store升级。";
        localNotification.alertAction = @"升级";
        //            localNotification.applicationIconBadgeNumber=1; //应用的红色数字
        localNotification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }

//    dispatch_async(dispatch_get_main_queue(), ^{
//        UILocalNotification * localNotification = [[UILocalNotification alloc] init];
//        if (localNotification)
//        {
//            DLog(@"post location Natification");
//            localNotification.fireDate= [[[NSDate alloc] init] dateByAddingTimeInterval:1];
//            localNotification.timeZone=[NSTimeZone defaultTimeZone];
//            localNotification.alertBody = @"小纯洁漫画有新的版本了，点击到App Store升级。";
//            localNotification.alertAction = @"升级";
////            localNotification.applicationIconBadgeNumber=1; //应用的红色数字
//            localNotification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成
//            [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//        }
//    });
}
@end
