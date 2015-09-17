//
//  PagerVC.h
//  XiaoChunJie
//
//  Created by Apan on 12-7-7.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PagerVC : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
    NSMutableArray *viewControllers;
    NSInteger pageNumber;

}
@property (nonatomic, retain) NSMutableArray *viewControllers;

- (void)loadScrollViewWithPage:(int)page;
@end
