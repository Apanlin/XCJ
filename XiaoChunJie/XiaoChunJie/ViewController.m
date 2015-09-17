//
//  ViewController.m
//  XiaoChunJie
//
//  Created by Apan on 12-6-30.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import "ViewController.h"
#import "ManHuaViewController.h"
//#import "PagerVC.h"
#import "AppDelegate.h"


#define kTriggerOffSet 100.0f

/////////////////////////////////////
@interface ViewController () 
//- (void)restoreViewLocation;
//- (void)moveToLeftSide;
//- (void)moveToRightSide;
//- (void)animateHomeViewToSide:(CGRect)newViewRect;
@end




@implementation ViewController



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}



-(void)dealloc
{
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTopBar];
//    PagerVC *page = [[PagerVC alloc] initWithNibName:@"PagerVC" bundle:nil];
//    NSMutableArray *controllers = [[NSMutableArray alloc] init];
//    for (unsigned i = 0; i < 500; i++)
//    {
//		[controllers addObject:[[ManHuaViewController alloc] initWithNibName:@"ManHuaViewController" bundle:nil]];
//    }
//    page.viewControllers = controllers;
////    [self.view addSubview:page.view];
//    [controllers release];
    
                           
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}






// animate home view to side rect
- (void)animateHomeViewToSide:(CGRect)newViewRect {
    [UIView animateWithDuration:0.2 
                     animations:^{
                         self.navigationController.view.frame = newViewRect;
                     } 
                     completion:^(BOOL finished){
                         UIControl *overView = [[UIControl alloc] init];
                         overView.tag = 10086;
                         overView.backgroundColor = [UIColor clearColor];
                         overView.frame = self.navigationController.view.frame;
                         [overView addTarget:self action:@selector(restoreViewLocation) forControlEvents:UIControlEventTouchDown];
                         [[[UIApplication sharedApplication] keyWindow] addSubview:overView];
                         [overView release];
                     }];
}
-(void)initTopBar
{
    topBarImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"topBar" ofType:@"png"]]] ;
    topBarImage.frame = CGRectMake(0, 0, 320, 44);
    [self.view addSubview:topBarImage];
    NSLog(@"init Top bar");
}
@end
