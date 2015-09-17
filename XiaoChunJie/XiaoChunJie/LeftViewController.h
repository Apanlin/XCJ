//
//  LeftViewController.h
//  XiaoChunJie
//
//  Created by Apan on 12-7-7.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AderWallDelegate.h"
#import "AderPointWall.h"
@interface LeftViewController : BaseViewController<AderWallDelegate, UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_leftArr;
}
@property (retain, nonatomic) IBOutlet UITableView *settingTableView;
-(void)webFeedback;
@end
