//
//  ContentViewController.m
//  XiaoChunJie
//
//  Created by Apan on 12-7-1.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//

#import "ManHuaViewController.h"

//@implementation UIScrollView (UITouch)
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//
//    
//    UITouch *touch = [touches anyObject];
//    if([touch tapCount] == 2)
//    {
//        NSLog(@"double click");
//        CGFloat zs = self.zoomScale;
//        zs = (zs == 1.0)? 2.0 : 1.0;
//        
//        [UIView beginAnimations:nil context:NULL];
//        [UIView setAnimationDuration:0.3];
//        self.zoomScale = zs;
//        [UIView commitAnimations];
//    }
//
//}
//
//
//@end




@implementation ManHuaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *img1 = [UIImage imageNamed:@"1.jpg"];
    imageView = [self adapterImage:img1];
    [img1 release];
    
    //设置scrollview
//    scrollView.bounces = NO;
    scrollView.minimumZoomScale = 1.0;
    scrollView.maximumZoomScale = 3.0;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.contentSize = imageView.frame.size;
    [scrollView addSubview:imageView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma -mark 功能函数
-(UIImageView *)adapterImage:(UIImage *)image
{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:image];
    
    if(image.size.width > 320)
    {
        float newHeight = image.size.height*(320/image.size.width);
        float newY = newHeight > 480? 0:(480-image.size.height)/2; 
        imgView.frame = CGRectMake(0, newY, 320, newHeight);
        
    }
    else if(image.size.height > 480)
    {
        float newWidth = image.size.width*(480/image.size.height);
        float newX = newWidth > 320? 0 : (320-newWidth)/2 ;
        imgView.frame = CGRectMake(320-newX, 0, newWidth, 480); 
    }
    else
    {
        imgView.frame =  CGRectMake((320-image.size.width)/2, (480-image.size.height)/2,image.size.width, image.size.height)  ;
        
    }
    
    
    return imgView;
    
}
#pragma -mark scrollerView delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    NSLog(@"viewForZoomingInScrollView");
   return imageView;
}

-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    NSLog(@"scrollViewWillBeginZooming");
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndScrollingAnimation");
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll");
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    NSLog(@"%f",imageView.frame.size.width);
    if(imageView.frame.size.width < 320)
    {
//        imageView.center = CGPointMake(160, 240);
    }
    
    NSLog(@"scrollViewDidZoom");
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
 NSLog(@"scrollViewDidEndZooming");

}

#pragma -mark touch delegate
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{NSLog(@" click");
    UITouch *touch = [touches anyObject];
    if([touch tapCount] == 2)
    {
        NSLog(@"double click");
        CGFloat zs = scrollView.zoomScale;
        zs = (zs == 1.0)? 2.0 : 1.0;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        scrollView.zoomScale = zs;
        [UIView commitAnimations];
    }
}
@end
