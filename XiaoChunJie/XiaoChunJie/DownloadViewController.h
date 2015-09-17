//
//  DownloadViewController.h
//  XiaoChunJie
//
//  Created by Lin Pan on 12-8-5.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import "LPRefreshTableViewController.h"
#import "DownloadHandler.h"

@interface DownloadViewController : LPRefreshTableViewController<DownloadHandlerDelegate>
{    
    NSMutableArray *_downloadTaskList;
    NSArray *_serverMHAlbumList;
    
}
@property(retain, nonatomic) IBOutlet UILabel *testLbl;
@property(retain,nonatomic)NSMutableArray *downloadTaskList;
@property(retain,nonatomic)NSArray *serverMHAlbumList;

+ (DownloadViewController *)instance;

@end
