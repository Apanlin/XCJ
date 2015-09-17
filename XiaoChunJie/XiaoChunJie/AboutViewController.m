//
//  AboutViewController.m
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-29.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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
    [self.navigationController setNavigationBarHidden:YES];
    [self initLeftBtn];
    // Do any additional setup after loading the view from its nib.
    NSString *versionInfo = [Config getVersion];
    _versionLbl.text = [NSString stringWithFormat:@"版本:%@",versionInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
