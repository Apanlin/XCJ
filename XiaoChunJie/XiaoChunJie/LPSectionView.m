//
//  LPSectionView.m
//  XiaoChunJie
//
//  Created by Lin Pan on 13-2-26.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "LPSectionView.h"

@implementation LPSectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexSep.png"]];
        bgImageView.frame = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
        bgImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:bgImageView];
        [bgImageView release];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, self.frame.size.width - 20.0, self.frame.size.height)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor colorWithRed:201 green:190 blue:170 alpha:1];
        [self addSubview:_titleLabel];
        [_titleLabel release];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _titleLabel.frame = CGRectMake(10.0, 0.0, self.frame.size.width - 20.0, self.frame.size.height);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
