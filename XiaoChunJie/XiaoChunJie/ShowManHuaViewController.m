//
//  ShowManHuaViewController.m
//  XiaoChunJie
//
//  Created by Lin Pan on 12-8-5.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import "ShowManHuaViewController.h"
#import "PagerVC.h"
#import "ManHuaViewController.h"
@interface ShowManHuaViewController ()

@end

@implementation ShowManHuaViewController

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
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    
    PagerVC *page = [[PagerVC alloc] initWithNibName:@"PagerVC" bundle:nil];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < 500; i++)
    {
		[controllers addObject:[[ManHuaViewController alloc] initWithNibName:@"ManHuaViewController" bundle:nil]];
    }
    page.viewControllers = controllers;
    [self.view addSubview:page.view];
    [controllers release];
    
    [super viewDidLoad];
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
	backButton.frame=CGRectMake(8, 7, 45,27);
	[backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
	[backButton setImage:[UIImage imageNamed:@"nav-back-button.png"] forState:UIControlStateHighlighted];
    [backButton setImage:[UIImage imageNamed:@"nav-back-button.png"] forState:UIControlStateNormal];
    [self.view addSubview:backButton];
}

-(void)backAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
