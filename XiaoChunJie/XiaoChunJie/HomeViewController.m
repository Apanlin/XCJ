//
//  HomeViewController.m
//  XiaoChunJie
//
//  Created by Lin Pan on 12-7-31.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import "HomeViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "ShowManHuaViewController.h"
#import "DownloadViewController.h"
#import "DDMenuController.h"
#import "EGOQuickPhoto.h"
#import "MHFileManager.h"
#import "EGOImageView.h"
#import "OLImageView.h"
#import "OLImage.h"
#define kTriggerOffSet 100.0f
@interface HomeViewController ()
{
    NSMutableArray *_manHuaList;
    __block MHFileManager *_mhManager;
}
@property(retain,nonatomic)NSMutableArray *manHuaList;
@end

@implementation HomeViewController
@synthesize tableView = _tableView;
@synthesize manHuaList = _manHuaList;

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
//    CALayer *layer = self.view.layer;
//    layer.masksToBounds = YES;
//    layer.cornerRadius = 5.5;
//    layer.shadowColor = [UIColor blackColor].CGColor;
//    layer.shadowRadius = 2.0;
//    layer.shadowOpacity = 0.5;
//    layer.shadowOffset = CGSizeMake(-10, -8);
//
    [self setTitleWithLbl:nil str:@"我的漫画"];
    _mhManager = [MHFileManager instance];
    [_mhManager open];
//    _manHuaList = [[NSMutableArray alloc] initWithArray:[_mhManager getAllAlbumNames]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _manHuaList = [[NSMutableArray alloc] initWithArray:[_mhManager getAllAlbumNames]];
        dispatch_async(dispatch_get_main_queue(), ^{
             [self checkListCount];
            [_tableView reloadData];
          
        });
        
    });
    
   
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES withAnimation:NO];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)dealloc
{
//    [_mhManager release];
    [_manHuaList release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





// move view to right side
- (void)moveToRightSide {
                                         
    [[self appDelegate].menuController showLeftController:YES];
}



#pragma mark - UI Method
-(void)initTopBar
{

    [super initTopBar];
    UIButton *navMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    navMenu.frame = CGRectMake(10, 7, 37, 28);
    [navMenu setImage:[UIImage imageNamed:@"nav-menu.png"] forState:UIControlStateNormal];
//    [navMenu setBackgroundImage:[UIImage imageNamed:@"nav-menu-button.png"] forState:UIControlStateNormal];
//    [navMenu setBackgroundImage:[UIImage imageNamed:@"nav-menu-button-press.png"] forState:UIControlStateHighlighted];
    [navMenu addTarget:self action:@selector(moveToRightSide) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navMenu];
    
    UIButton *navDownload = [UIButton buttonWithType:UIButtonTypeCustom];
    navDownload.frame = CGRectMake(282, 8,23, 23);
//    [navDownload setImage:[UIImage imageNamed:@".png"] forState:UIControlStateNormal];
    [navDownload setBackgroundImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
//    [navDownload setBackgroundImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateHighlighted];
    [navDownload addTarget:self action:@selector(settingMHList:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navDownload];
    
}

-(void)deleteMHAlbum:(NSString *)name
{
    if (!_mhManager.bOpen) {
        [_mhManager open];
    }
    [_mhManager removeMHWithKey:name];
    [_mhManager close];
}
-(void)settingMHList:(id)sender
{
    _bEdit = !_bEdit;
    _tableView.editing = _bEdit;
}


-(void)go2Download:(id)sender
{
    
    [[self appDelegate].menuController showLeftController:YES];
    [self performSelector:@selector(showDownloadView) withObject:nil afterDelay:0.3];
}

-(void)showDownloadView
{
    [[self appDelegate] selectIndexPath:kMeunDownload];
}

- (void)drawDefaultView
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"gif"];
    NSData *GIFDATA = [NSData dataWithContentsOfFile:filePath];
    OLImageView *Aimv = [OLImageView new];
    Aimv.image = [OLImage imageWithData:GIFDATA];
    [Aimv setFrame:CGRectMake(120, 110, 80, 80)];
    [self.view addSubview:Aimv];
    [Aimv release];
    
    UIButton *tipsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tipsBtn.frame = CGRectMake(23, 210, 274, 46);
    [tipsBtn setImage:[UIImage imageNamed:@"nomh.png"] forState:UIControlStateNormal];
    //    [tipsBtn setImage:[UIImage imageNamed:@"nil.png"] forState:UIControlStateNormal];
    [tipsBtn addTarget:self action:@selector(go2Download:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tipsBtn];
}

- (void)checkListCount
{
    if ([_manHuaList count] == 0) {
        [self drawDefaultView];
    }
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_manHuaList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // UITableViewCell *cell = nil;
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        EGOImageView *imageView = [[EGOImageView alloc]initWithFrame:CGRectMake(10, 8, 50, 50)];
        imageView.tag = 501;
        CALayer *layer = [imageView layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:5.0];
        [layer setBorderWidth:1.0];
        [layer setBorderColor:[[UIColor colorWithRed:(135/255.f) green:(137/255.f) blue:(136/255.f) alpha:1] CGColor]];
        [cell.contentView addSubview:imageView];
        [imageView release];
        
        UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 250, 26)];
        titleLbl.font = [UIFont systemFontOfSize:16];
        titleLbl.tag = 502;
        titleLbl.backgroundColor = [UIColor clearColor];
        titleLbl.textColor = [UIColor colorWithRed:86/255.f green:86/255.f blue:86/255.f alpha:1.0];
        [cell.contentView addSubview:titleLbl];
        [titleLbl release];
        
        UILabel *detailLbl = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, 280, 15)];
        detailLbl.tag = 503;
        detailLbl.backgroundColor = [UIColor clearColor];
        [detailLbl setFont:[UIFont systemFontOfSize:12]];
        detailLbl.textColor = [UIColor colorWithRed:201/255.f green:201/255.f blue:201/255.f alpha:1.0];
//        [cell.contentView addSubview:detailLbl];
        [detailLbl release];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (indexPath.row % 2 == 1) {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"darkCellBJ@2x.png"]];
    }
    else
    {
        cell.backgroundView = nil;
    }
    
    
    EGOImageView *imageView = (EGOImageView *)[cell.contentView viewWithTag:501];
    imageView.placeholderImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"head" ofType:@"jpg"]];
    imageView.imageURL = [NSURL  fileURLWithPath:[_mhManager getAlbumHeadIcon:[_manHuaList objectAtIndex:indexPath.row]]];
    
    UILabel *title = (UILabel *)[cell.contentView viewWithTag:502];
    title.text = [_manHuaList objectAtIndex:indexPath.row];
    
    UILabel *detailLabel = (UILabel *)[cell.contentView viewWithTag:503];
    detailLabel.text = [_manHuaList objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ShowManHuaViewController *showVC = [[ShowManHuaViewController alloc]initWithNibName:@"ShowManHuaViewController" bundle:nil];
//    [self.navigationController pushViewController:showVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *mhArr = [[_mhManager getMHsFromAlbum:[_manHuaList objectAtIndex:indexPath.row]] retain];
    
    NSMutableArray * sourceArr = [[NSMutableArray alloc] init];
    for (id name in mhArr)
    {
        DLog(@"name %@",name);
        EGOQuickPhoto *p1 = [[EGOQuickPhoto alloc] initWithImageURL:[NSURL fileURLWithPath:name]];
        [sourceArr addObject:p1];
        [p1 release];
    }
    
    EGOQuickPhotoSource *pSource = [[EGOQuickPhotoSource alloc] initWithPhotos:sourceArr];
    EGOPhotoViewController *photoController = [[EGOPhotoViewController alloc] initWithPhotoSource:pSource];
    [self.navigationController pushViewController:photoController animated:YES];
    
    [photoController release];
}

#pragma mark - UITableViewCell Delegates

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        DLog(@"删除action");
        [self deleteMHAlbum:[_manHuaList objectAtIndex:indexPath.row]];
        [_manHuaList removeObjectAtIndex:indexPath.row];
        [self checkListCount];
        [_tableView reloadData];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MHDelected" object:nil];
        
        
    }
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除";
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



@end
