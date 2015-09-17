//
//  ContentViewController.h
//  XiaoChunJie
//
//  Created by Apan on 12-7-1.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ManHuaViewController :UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrollView;
    UIImageView *imageView;
}

-(UIImageView *)adapterImage:(UIImage *)image;
@end
