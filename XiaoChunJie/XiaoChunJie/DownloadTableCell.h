//
//  DownloadTableCell.h
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-18.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface DownloadTableCell : UITableViewCell

@property(retain,nonatomic)EGOImageView *myImageView;
@property(retain,nonatomic)UILabel *titleLbl;
@property(retain,nonatomic)UILabel *dateName;
@property(retain,nonatomic)UILabel *dateDetail;
@property(retain,nonatomic)UILabel *sizeName;
@property(retain,nonatomic)UILabel *sizeDatail;
@property(retain,nonatomic)UIProgressView *progress;
@property(retain,nonatomic)UIButton *downloadBtn;
@end
