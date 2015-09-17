//
//  LPLeftSideTableCell.m
//  XiaoChunJie
//
//  Created by Lin Pan on 13-2-26.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "LPLeftSideTableCell.h"

@implementation LPLeftSideTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AccessoryView.png"]] autorelease];
        
        
        UIImage *lineImage = [UIImage imageNamed:@"IndexLine.png"];
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[lineImage stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        lineView.frame = CGRectMake(0.0, self.frame.size.height - lineImage.size.height ,self.frame.size.width, lineImage.size.height);
        lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:lineView];
        [lineView release];

    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.accessoryView.frame = CGRectMake(250, self.accessoryView.frame.origin.y, self.accessoryView.frame.size.width, self.accessoryView.frame.size.height);
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
