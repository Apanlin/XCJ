//
//  AppDelegate.m
//  XiaoChunJie
//
//  Created by Apan on 12-6-30.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "DDMenuController.h"
#import "UMFeedback.h"
#import "EGOQuickPhoto.h"
#import <ShareSDK/ShareSDK.h>
#import "DownloadViewController.h"
#import "TestViewController.h"
#import "MobClick.h"
//#import "WapsOffer/AppConnect.h"
#import "LPRefreshTableViewController.h"
#import "UpdateManager.h"
@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize homeVC = _homeVC;
@synthesize menuController = _menuController;
@synthesize leftViewController;
- (void)dealloc
{
    [_window release];
//    [_viewController release];
    [_homeVC release];
    [_menuController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [WXApi registerApp:@"wx6dd7a9b94f3dd72a"];
//    [QQApi registerPluginWithId:@"QQ075BCD15"];
    [ShareSDK registerApp:@"1c63d6d88f7"];
    
    //umeng feedback check repeat
    [UMFeedback checkWithAppkey:UMENG_APPKEY];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(umCheck:) name:UMFBCheckFinishedNotification object:nil];
    //umeng analytics
    [MobClick startWithAppkey:UMENG_APPKEY];
    //waps
//    [AppConnect getConnect:WAPS_ID pid:kChannel];
    
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil] autorelease];
    
    HomeViewController *homeVC= [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    DDMenuController *rootController = [[DDMenuController alloc] initWithRootViewController:nav];
    _menuController = rootController;
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    rootController.leftViewController = leftVC;
    
//    TestViewController *t = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
//    self.window.rootViewController = t;
    
    self.window.rootViewController = rootController;
    [self.window makeKeyAndVisible];
    return YES;
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSLog(@"查看feedback");
        [_menuController showLeftController:YES];
        
        [self performSelector:@selector(selectIndexPath:) withObject:kMeunShowFeedbck afterDelay:0.5];
        
        
    }else{
        
    }
}

-(void)selectIndexPath:(MeunType)type
{
    switch (type)
    {
        case kMeunShowFeedbck:
        {
            LeftViewController *leftVC = (LeftViewController *)_menuController.leftViewController;
            [leftVC.settingTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            [self performSelector:@selector(showFeedBack) withObject:nil afterDelay:0.3];
            break;
        }
            
        case  kMeunDownload:
        {
            LeftViewController *leftVC = (LeftViewController *)_menuController.leftViewController;
            [leftVC.settingTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
            [leftVC.settingTableView setNeedsDisplay];
            [self performSelector:@selector(go2Download) withObject:nil afterDelay:0.3];
             break;
        }
            
        default:
            break;
    }
    
}

-(void)go2Download
{
    LeftViewController *leftVC = (LeftViewController *)_menuController.leftViewController;
    [leftVC tableView:nil didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
}

-(void)showFeedBack
{
    LeftViewController *leftVC = (LeftViewController *)_menuController.leftViewController;
    [leftVC webFeedback];
}

- (void)umCheck:(NSNotification *)notification {
    UIAlertView *alertView;
    if (notification.userInfo) {
        NSArray * newReplies = [notification.userInfo objectForKey:@"newReplies"];
        NSLog(@"newReplies = %@", newReplies);
        NSString *title = [NSString stringWithFormat:@"有%d条新回复", [newReplies count]];
        NSMutableString *content = [NSMutableString string];
        for (int i = 0; i < [newReplies count]; i++) {
            NSString * dateTime = [[newReplies objectAtIndex:i] objectForKey:@"datetime"];
            NSString *_content = [[newReplies objectAtIndex:i] objectForKey:@"content"];
            [content appendString:[NSString stringWithFormat:@"%d .......%@.......\r\n", i+1,dateTime]];
            [content appendString:_content];
            [content appendString:@"\r\n\r\n"];
        }
        
        alertView = [[UIAlertView alloc] initWithTitle:title message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
        ((UILabel *) [[alertView subviews] objectAtIndex:1]).textAlignment = NSTextAlignmentLeft ;
        [alertView show];
    }
//    else{
//        alertView = [[UIAlertView alloc] initWithTitle:@"没有新回复" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
//    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    if([[UpdateManager shareInstance] bUpdate])
    {
        [[UpdateManager shareInstance] postUpdateTip];
    }
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    double delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[UpdateManager shareInstance] checkUpdate];
    });
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url wxDelegate:self];
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // open app store link
    NSString * url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", kAppID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
