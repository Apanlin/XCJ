//
//  HomeViewController.h
//  XiaoChunJie
//
//  Created by Lin Pan on 12-7-31.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    BOOL _bEdit;
}

@property(retain,nonatomic) IBOutlet UITableView *tableView;
@end
