//
//  LPRefreshTableViewController.h
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-18.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "BaseViewController.h"


@interface LPRefreshTableViewController : BaseViewController<EGORefreshTableHeaderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL _reloading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    UITableView *_tableView;
}
@property(retain,nonatomic)UITableView *tableView;

-(void)doRefresh;
-(void)doneLoadingTableViewData;
@end
