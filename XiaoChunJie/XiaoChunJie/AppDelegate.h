//
//  AppDelegate.h
//  XiaoChunJie
//
//  Created by Apan on 12-6-30.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LeftViewController;
@class ViewController;
@class HomeViewController;
@class DDMenuController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    HomeViewController *_homeVC;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DDMenuController *menuController;

@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) LeftViewController *leftViewController;
@property (strong, nonatomic) HomeViewController *homeVC;

//-(void)selectIndexPath:(MeunType)type;
@end
