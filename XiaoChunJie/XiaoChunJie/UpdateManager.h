//
//  UpdateManager.h
//  XiaoChunJie
//
//  Created by Lin Pan on 13-4-4.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateManager : NSObject
{
    BOOL _bUpdate;
}
@property(assign,nonatomic) BOOL bUpdate;
+ (UpdateManager *)shareInstance;

- (void)checkUpdate;
- (void)postUpdateTip;
@end
