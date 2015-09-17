//
//  DownloadViewController.m
//  XiaoChunJie
//
//  Created by Lin Pan on 12-8-5.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import "DownloadViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utils.h"
#import "DownloadHandler.h"
#import "DownloadTask.h"
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
#import "HttpParser.h"
#import "ServerMHAlbum.h"
#import "DownloadTableCell.h"
#import "MHFileManager.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "DDMenuController.h"
#import "NSString+Common.h"
#define kGapX  0

@interface DownloadViewController ()
{
    BOOL _bReload;
}


@end

@implementation DownloadViewController
@synthesize downloadTaskList = _downloadTaskList;
@synthesize testLbl = _testLbl;
@synthesize serverMHAlbumList = _serverMHAlbumList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
        // Custom initialization
    }
    return self;
}


+(DownloadViewController *)instance
{
    
    static DownloadViewController *instance;
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[DownloadViewController alloc] init];
        }
    }
    
    return instance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setTitleWithLbl:nil str:@"在线下载"];
    
    UIButton *navMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    navMenu.frame = CGRectMake(10, 7, 37, 28);
    [navMenu setImage:[UIImage imageNamed:@"nav-menu.png"] forState:UIControlStateNormal];
    [navMenu addTarget:self action:@selector(moveToRightSide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navMenu];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(someMHDeleted) name:@"MHDelected" object:nil];
    
    
    _downloadTaskList = [[NSMutableArray alloc] init];
    
//    [self getMHList];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if (_bReload) {
        [_tableView reloadData];
        _bReload = NO;
    }
}

- (void)viewDidUnload
{
    [self setTestLbl:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc
{
    [_downloadTaskList release];
    [_serverMHAlbumList release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MHDelected" object:nil];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)moveToRightSide
{
     [[self appDelegate].menuController showLeftController:YES];
}

- (void)showWrongNetWork:(NSString *)tips
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong.gif"]] autorelease];
    // Set custom view mode
    HUD.mode = MBProgressHUDModeCustomView;
//    HUD.delegate = self;
    HUD.labelText = tips;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}



#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_serverMHAlbumList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UITableViewCell *cell = nil;
    
    
    static NSString *CellIdentifier = @"Cell";
    
    DownloadTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[DownloadTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell.downloadBtn addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row % 2 == 1) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"darkCellBJ@2x.png"]];
    }
    else
    {
        cell.backgroundView = nil;
    }
    
    cell.downloadBtn.tag = indexPath.row;
    ServerMHAlbum *album = [_serverMHAlbumList objectAtIndex:indexPath.row];
    cell.titleLbl.text = [album.name stringByDeletingPathExtension];
    cell.dateDetail.text = album.time;
    cell.sizeDatail.text = [NSString stringWithSize:[album.size floatValue]];
    cell.myImageView.placeholderImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"head" ofType:@"jpg"]];
    cell.myImageView.imageURL = [NSURL URLWithString:album.imgUrl];
    DownloadTask *task = [_downloadTaskList objectAtIndex:indexPath.row];
    task.progress.frame = CGRectMake(70, 48, 160, 10);
    [[MHFileManager instance] open];
    if([[MHFileManager instance] isMHExistForKey:[album.name stringByDeletingPathExtension]])
    {
        task.progress.progress = 1;
    }
    else{
        task.progress.progress = 0;
    }
    
    if (task.bStart) {
        [cell.downloadBtn setBackgroundImage:[UIImage imageNamed:@"stopBtn.png"] forState:UIControlStateNormal];
        [cell.downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
        cell.downloadBtn.enabled = YES;
    }
    else
    {
        if (task.progress.progress >= 1) {
            [cell.downloadBtn setBackgroundImage:[UIImage imageNamed:@"download_succeed.png"] forState:UIControlStateNormal];
            [cell.downloadBtn setTitle:@"" forState:UIControlStateNormal];
            cell.downloadBtn.enabled = NO;
        }
        else{
            [cell.downloadBtn setBackgroundImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateNormal];
            [cell.downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
            cell.downloadBtn.enabled = YES;
        }
    }
    
    [cell.contentView addSubview:task.progress];

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ShowManHuaViewController *showVC = [[ShowManHuaViewController alloc]initWithNibName:@"ShowManHuaViewController" bundle:nil];
//    [self.navigationController pushViewController:showVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - download delegate
- (void)didDownloadFailedWithTask:(DownloadTask *)downloadTask
{
    DLog(@"downloadFailed");
    [self showWrongNetWork:@"好像不给力啊,请重试!"];
    downloadTask.bStart = NO;
    [_tableView reloadData];
    
}

- (void)didDownloadSucceedWithTask:(DownloadTask *)downloadTask
{
    DLog(@"downloadSucceed");
    downloadTask.bStart = NO;
    [_tableView reloadData];
}
- (void)didUnzipSucceeAtPath:(NSString *)filePath
{
    NSString *fileName = [filePath lastPathComponent];
    NSArray *fileArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath error:nil];
    DLog(@"fileArr %@",fileArr);
    
    //filter 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains 'jpg'"];
    NSArray *filterArr= [fileArr filteredArrayUsingPredicate:predicate];
    DLog(@"filterArr %@",filterArr);
    
    
    MHFileManager *mhManager = [MHFileManager instance];
    [mhManager open];
    if(![mhManager isMHExistForKey:fileName])
    {
        [mhManager addMHWithKey:filterArr forKey:fileName];
    }
    [mhManager close];

}

#pragma mark - Http
-(void)getMHList
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseApiUrl,kGetMHList]];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
        // Use when fetching text data
        if (request.responseString)
        {
            self.serverMHAlbumList = [HttpParser pareserMHAlbum:request.responseString];
            [self.downloadTaskList removeAllObjects];
            for (ServerMHAlbum *album in self.serverMHAlbumList)
            {
                DownloadTask *downloadTask = [[DownloadTask alloc]initWithURL:album.url savePath:kDocumentPath fileName:album.name];
                [self.downloadTaskList addObject:downloadTask];
                [downloadTask release];
            }
            
            
            [self.tableView reloadData];
            DLog(@"get server man hua list %@",_serverMHAlbumList);
        }
        else
        {
            DLog(@"网络返回结果出错了");
            [self showWrongNetWork:@"好像不给力啊,请重试!"];
        }
        
        [self doneLoadingTableViewData];
     
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        DLog(@"http error %@",error);
        
        [self doneLoadingTableViewData];
        [self showWrongNetWork:@"网络不给力啊，请重试!"];

    }];
    [request startAsynchronous];
}

-(void)doRefresh
{
    [self getMHList];
}

-(void)downloadAction:(id)sender
{
    UIButton *downloadBtn = (UIButton *)sender;
    int tag = downloadBtn.tag;
    NSLog(@"tag %d",tag);
    DownloadTask *task = [_downloadTaskList objectAtIndex:tag];
    if (task.bStart)
    {
         [[DownloadHandler sharedInstance] stopTask:task];
         [downloadBtn setBackgroundImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateNormal];
         [downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
        
    }
    else
    {
        [DownloadHandler sharedInstance] .delegate = self;
        [[DownloadHandler sharedInstance] startTask:task];
        [downloadBtn setBackgroundImage:[UIImage imageNamed:@"stopBtn.png"] forState:UIControlStateNormal];
        [downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
}

-(void)someMHDeleted
{
    _bReload = YES;
}



@end
