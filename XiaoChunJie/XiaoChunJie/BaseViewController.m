//
//  BaseViewController.m
//  XiaoChunJie
//
//  Created by Apan on 12-7-7.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "DDMenuController.h"
@interface BaseViewController ()


@end

@implementation BaseViewController

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
    [super viewDidLoad];
    [self initTopBar];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bj.png"]];
    // Do any additional setup after loading the view from its nib.
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

-(AppDelegate *)appDelegate
{
	return (AppDelegate* )[UIApplication sharedApplication].delegate;
}


- (void)showTips:(NSString*)title message:(NSString*)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:error delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    [alert release];
}


- (void)showTips:(NSString*)title message:(NSString*)error tag:(NSInteger)tag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:error delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    alert.tag = tag;
    [alert show];
    [alert release];
}


- (void)showIndicator {

}

- (void)hideIndicator {

}
-(void)showIndicator :(NSString *)showtext{

}

-(void)initTopBar
{
    NSLog(@"Base->initTopBar");
    topBarImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"topBar" ofType:@"png"]]] ;
    topBarImage.frame = CGRectMake(0, 0, 320, 44);
    [self.view addSubview:topBarImage];
    NSLog(@"init Top bar");
}

//添加标题
-(void)setTitleWithLbl:(UILabel*)aTitleLbl str:(NSString*)titleStr
{
	if(aTitleLbl==nil)
	{
		if(titleLabel)
		{
			[titleLabel setText:titleStr];
		}
		else {
			titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(80, 0, 160, 44)];
			titleLabel.textAlignment=UITextAlignmentCenter;
			[titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
			titleLabel.textColor=[UIColor whiteColor];
			titleLabel.backgroundColor=[UIColor clearColor];
			[titleLabel setText:titleStr];
			[self.view addSubview:titleLabel];
		}
        
	}
    else
    {
		if(titleLabel)
		{
			[titleLabel removeFromSuperview];
			[titleLabel release];
		}
		titleLabel=[aTitleLbl retain];
		[self.view addSubview:titleLabel];
        [titleLabel release];
	}
    
}

-(void)initLeftBtn
{
    UIButton *navMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    navMenu.frame = CGRectMake(10, 7, 37, 28);
    [navMenu setImage:[UIImage imageNamed:@"nav-menu.png"] forState:UIControlStateNormal];
    [navMenu addTarget:self action:@selector(moveToRightSide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navMenu];
}
-(void)moveToRightSide
{
    [[self appDelegate].menuController showLeftController:YES];
}

@end
