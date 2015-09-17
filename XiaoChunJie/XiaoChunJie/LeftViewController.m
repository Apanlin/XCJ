//
//  LeftViewController.m
//  XiaoChunJie
//
//  Created by Apan on 12-7-7.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import "LeftViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "DownloadViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "DDMenuController.h"
#import "UMFeedback.h"
#import "LPLeftSideTableCell.h"
#import "LPSectionView.h"
#import "AGAuthViewController.h"
//#import "WapsOffer/AppConnect.h"
#import "AboutViewController.h"
#import "AderPointWall.h"
#import "AderWallDelegate.h"
@interface LeftViewController ()

@end

@implementation LeftViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
//    [super viewDidLoad];
    _leftArr = [[NSArray alloc] initWithObjects:@"看漫画",@"在线下载",@"分享设置",@"意见反馈",@"关于我们",@"鼓励一下呗！^v^",@"更多精美应用",nil];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IndexBG.png"]];
    bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    bgImageView.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:bgImageView];
    [bgImageView release];
    
    self.settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height)
                                              style:UITableViewStylePlain];
    self.settingTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.settingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.settingTableView.sectionHeaderHeight = 32;
    self.settingTableView.dataSource = self;
    self.settingTableView.delegate = self;
    self.settingTableView.backgroundColor = [UIColor clearColor];
    self.settingTableView.backgroundView = nil;
    [self.view addSubview:self.settingTableView];
    [self.settingTableView release];
    
   
}

- (void)viewDidUnload
{
    [self setSettingTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma  mark - Table Data
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_leftArr count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"小纯洁漫画";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    LPSectionView *sectionView = [[LPSectionView alloc] initWithFrame:CGRectZero];
    sectionView.titleLabel.text = @"小纯洁漫画";
    return [sectionView autorelease];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LeftViewTableCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[LPLeftSideTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *lineView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"IndexLine.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
        lineView.frame = CGRectMake(0.0, cell.contentView.frame.size.height - lineView.frame.size.height , cell.contentView.frame.size.width, lineView.frame.size.height);
        lineView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [cell addSubview:lineView];
        cell.backgroundColor = [UIColor clearColor];
        [lineView release];
        
	}
    
    cell.textLabel.text = [_leftArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
	return cell;
}
#pragma mark - Table Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DDMenuController *menuController = self.appDelegate.menuController;
    
    int row = indexPath.row;
    switch (row) {
        case 0:
        {
            HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeVC];
            [menuController setRootController:navController animated:YES];
            break;
        }
        case 1:
        {
            //下载页面
            DownloadViewController *downloadVC = [DownloadViewController instance];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:downloadVC];
            [menuController setRootController:navController animated:YES];
            break;
        }
        case 2:
        {
            AGAuthViewController *authVC = [[AGAuthViewController alloc] init];
            authVC.title = @"分享设置";            
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:authVC];
            [menuController setRootController:navController animated:YES];
            break;
        }
        case 3:
        {
            [self webFeedback];
            break;
        }
        case 4:
        {
            AboutViewController *aboutVC = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:aboutVC];
            [menuController setRootController:navController animated:YES];
            break;
        }
        case 6:
        {
//            [AppConnect showOffers];
        }

        default:
            break;
    }
}

-(void)webFeedback
{
    DDMenuController *menuController = self.appDelegate.menuController;
    [UMFeedback showFeedback:menuController withAppkey: UMENG_APPKEY];
}


- (void)dealloc {
    [_settingTableView release];
    [super dealloc];
}
@end
