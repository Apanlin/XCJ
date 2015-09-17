//
//  BaseViewController.h
//  XiaoChunJie
//
//  Created by Apan on 12-7-7.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;
@interface BaseViewController : UIViewController
{

    UIImageView *topBarImage;
    UILabel *titleLabel;
}

-(AppDelegate *)appDelegate;
-(void)showTips:(NSString*)title message:(NSString*)error tag:(NSInteger)tag;
-(void)showTips:(NSString*)title message:(NSString*)error;

-(void)showIndicator;
-(void)showIndicator :(NSString *)showtext;
- (void)hideIndicator;

-(void)initTopBar;
-(void)initLeftBtn;
-(void)setTitleWithLbl:(UILabel*)aTitleLbl str:(NSString*)titleStr;
@end
