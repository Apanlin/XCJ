//
//  DownloadTableCell.m
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-18.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "DownloadTableCell.h"
#import <QuartzCore/QuartzCore.h>
#import "EGOImageView.h"
#define kGapX  0
@implementation DownloadTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        
        EGOImageView *imageView = [[EGOImageView alloc]initWithFrame:CGRectMake(10+kGapX, 8, 50, 50)];
        
        CALayer *layer = [imageView layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:5.0];
        [layer setBorderWidth:1.0];
        [layer setBorderColor:[[UIColor colorWithRed:(135/255.f) green:(137/255.f) blue:(136/255.f) alpha:1] CGColor]];
        [self.contentView addSubview:imageView];
        self.myImageView = imageView;
        [imageView release];
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(70+kGapX, 5, 230, 26)];
        titleLbl.font = [UIFont systemFontOfSize:16];
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:1.0];
        [self.contentView addSubview:titleLbl];
        self.titleLbl = titleLbl;
        [titleLbl release];
        
        //时间
        UILabel *dateName = [[UILabel alloc] initWithFrame:CGRectMake(70+kGapX, 30, 30, 15)];
        dateName.backgroundColor = [UIColor clearColor];
        [dateName setFont:[UIFont systemFontOfSize:12]];
        dateName.text = @"更新:";
        dateName.textColor = [UIColor colorWithRed:101/255.f green:101/255.f blue:101/255.f alpha:1.0];
        [self.contentView addSubview:dateName];
        self.dateName = dateName;
        [dateName release];
        
        UILabel *dateDetail = [[UILabel alloc] initWithFrame:CGRectMake(100+kGapX, 30, 70, 15)];
        dateDetail.backgroundColor = [UIColor clearColor];
        [dateDetail setFont:[UIFont systemFontOfSize:12]];
        dateDetail.text = @"2012-08-10";
        dateDetail.textColor = Color(238, 92, 66, 1.0);
        [self.contentView addSubview:dateDetail];
        self.dateDetail = dateDetail;
        [dateDetail release];
    
        //大小
        UILabel *sizeName = [[UILabel alloc] initWithFrame:CGRectMake(165+kGapX, 30, 30, 15)];
        sizeName.backgroundColor = [UIColor clearColor];
        [sizeName setFont:[UIFont systemFontOfSize:12]];
        sizeName.text = @"大小:";
        sizeName.textColor = [UIColor colorWithRed:101/255.f green:101/255.f blue:101/255.f alpha:1.0];
        [self.contentView addSubview:sizeName];
        self.sizeName = sizeName;
        [sizeName release];
        
        UILabel *sizeDatail = [[UILabel alloc] initWithFrame:CGRectMake(195+kGapX, 30, 50, 15)];
        sizeDatail.backgroundColor = [UIColor clearColor];
        [sizeDatail setFont:[UIFont systemFontOfSize:12]];
        sizeDatail.text = @"5.5M";
        sizeDatail.textColor = Color(238, 92, 66, 1.0);
        [self.contentView addSubview:sizeDatail];
        self.sizeDatail = sizeDatail;
        [sizeDatail release];
        
        UIButton *downloadButton = [[UIButton alloc] init];
        [downloadButton setBackgroundImage: [UIImage imageNamed:@"download.png"] forState:UIControlStateNormal];
        downloadButton.frame = CGRectMake(250, 23.2, 44, 22.4);
        [self.contentView addSubview:downloadButton];
        [downloadButton setTitle:@"下载" forState:UIControlStateNormal];
        downloadButton.titleLabel.font = [UIFont systemFontOfSize:9];
        downloadButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.downloadBtn = downloadButton;
        [downloadButton release];
        //progress
        UIProgressView *progress = [[UIProgressView alloc] initWithFrame:CGRectMake(70+kGapX, 48, 160, 10)];
        [progress setProgressViewStyle:UIProgressViewStyleDefault];
//        [self.contentView addSubview:progress];
        self.progress = progress;
        [progress release];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    [_progress release];
    [_sizeDatail release];
    [_sizeName release];
    [_dateDetail release];
    [_dateName release];
    [_titleLbl release];
    [_myImageView release];
    [_downloadBtn release];
    [super dealloc];
}

@end
