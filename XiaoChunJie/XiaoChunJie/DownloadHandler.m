//
//  DownloadHandler.m
//  DownloadHandler
//
//  Created by Apan on 2013-2-6
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "ZipArchive.h"
#import "DownloadHandler.h"
#import "FilesManager.h"
static DownloadHandler *sharedDownloadhandler = nil;


@interface DownloadHandler()
-(BOOL)isImage:(NSString *)fileName;
-(BOOL)isMovie:(NSString *)fileName;
-(BOOL)isZip:(NSString *)fileName;
@end


@implementation DownloadHandler{
    ASIHTTPRequest *_request;
    ASINetworkQueue *_queue;
}

@synthesize delegate;

+(DownloadHandler *)sharedInstance{
    if (!sharedDownloadhandler)
    {
        sharedDownloadhandler = [[DownloadHandler alloc] init];
    }
    return sharedDownloadhandler;
}
-(id)init{
    if (self = [super init]) {
        if (!_queue) {
            _queue = [[ASINetworkQueue alloc] init];
            _queue.showAccurateProgress = YES;
            _queue.shouldCancelAllRequestsOnFailure = NO;
            [_queue go];
        }
    }
    return self;
}

-(void)dealloc
{
    [_queue release];
    _queue = nil;
    [delegate release];
    delegate = nil;
    [super dealloc];
}


-(void)startTask:(DownloadTask *)task
{
    for (ASIHTTPRequest *r in [_queue operations])
    {
        DownloadTask *downingTask = [r.userInfo objectForKey:@"task"];
        if (downingTask == task)
        {
            NSLog(@"队列中已存在特定request时，退出");
            return;//队列中已存在特定request时，退出
        }
    }
    
    NSURL *url = [NSURL URLWithString:task.address];
    _request = [ASIHTTPRequest requestWithURL:url];
    _request.delegate = self;
    _request.temporaryFileDownloadPath = [self cachesPathWithName:task.name];
    _request.downloadDestinationPath = [self actualSavePathWithTask:task];
    _request.downloadProgressDelegate = task.progress;
    _request.allowResumeForFileDownloads = YES;
    _request.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[task retain],@"task",nil];
    [_queue addOperation:_request];
    task.bStart = YES;
}


-(void)stopTask:(DownloadTask *)task
{
    task.bStart = NO;
    [self removeRequestFromQueueWithTask:task];
}

-(void)removeRequestFromQueueWithTask:(DownloadTask *)task
{
    for (ASIHTTPRequest *r in [_queue operations])
    {
        DownloadTask *downloadingTask = [r.userInfo objectForKey:@"task"];
        if (downloadingTask == task)
        {
            [r clearDelegatesAndCancel];
        }
    }
}

-(NSString *)actualSavePathWithTask:(DownloadTask *)task
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:task.savePath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:task.savePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return [task.savePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", task.name]];
}
-(NSString *)cachesPathWithName:(NSString *)name
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", name]];
    return path;
}



#pragma mark - Request Delegate
-(void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    NSLog(@"total size: %lld", request.contentLength);
}
-(void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"requestStarted");
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    DownloadTask *downingTask = [request.userInfo objectForKey:@"task"];
    [self removeRequestFromQueueWithTask:downingTask];
    
    UILabel *statusLabel = [request.userInfo objectForKey:@"statusLabel"];
    statusLabel.text = @"下载完成";
    //解压
    if ([self isZip:downingTask.name])
    {
        [self unzipFile:[downingTask.savePath stringByAppendingPathComponent:downingTask.name]];
    }

    if (delegate && [delegate respondsToSelector:@selector(didDownloadSucceedWithTask:)])
    {
        [delegate didDownloadSucceedWithTask:downingTask];
        
    }
    
    //save to Album
    NSString *path = [downingTask.savePath stringByAppendingPathComponent:downingTask.name];
    NSLog(@"the downloaded file's path: %@",path);
    if (downingTask.bSave2Album)
    {
        if ([self isImage:downingTask.name])
        {
            UIImage *image =[UIImage imageWithContentsOfFile:path];
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        else if([self isMovie:downingTask.name])
        {
            if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path))
            {
                UISaveVideoAtPathToSavedPhotosAlbum(path, nil, nil, nil);
            }
        }
    }

//    [downingTask release];
    
    
}
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"download failed, error: %@", error);
    
    DownloadTask *downingTask = [request.userInfo objectForKey:@"task"];
    [self removeRequestFromQueueWithTask:downingTask];
    
    UILabel *statusLabel = [request.userInfo objectForKey:@"statusLabel"];
    statusLabel.text = @"下载失败";
    
    if (delegate && [delegate respondsToSelector:@selector(didDownloadFailedWithTask:)])
    {
         [delegate didDownloadFailedWithTask:downingTask];
    }
    
//    [downingTask release];
}



#pragma mark - private method
//文件判断
- (BOOL)isImage:(NSString *)fileName
{
    return [fileName hasSuffix:@"jpg"]||[fileName hasSuffix:@"JPG"]||[fileName hasSuffix:@"png"]||[fileName hasSuffix:@"PNG"]||[fileName hasSuffix:@"gif"]||[fileName hasSuffix:@"GIF"];
}
- (BOOL)isMovie:(NSString *)fileName
{
    return [fileName hasSuffix:@"MOV"] ||[fileName hasSuffix:@"mov"] || [fileName hasSuffix:@"mp4"] || [fileName hasSuffix:@"MP4"] || [fileName hasSuffix:@"3gp"] || [fileName hasSuffix:@"3GP"];
}
- (BOOL)isZip:(NSString *)fileName
{
      return [fileName hasSuffix:@"ZIP"] ||[fileName hasSuffix:@"zip"];
}

-(void)unzipFile:(NSString *)path
{
    NSString *unzipPath = path;
    ZipArchive *unzip = [[ZipArchive alloc] init];
    if ([unzip UnzipOpenFile:path]) {
        BOOL result = [unzip UnzipFileTo:kDocumentPath overWrite:YES];
        if (result) {
            NSLog(@"unzip successfully");
            if (delegate && [delegate respondsToSelector:@selector(didUnzipSucceeAtPath:)])
            {
                [delegate didUnzipSucceeAtPath:[unzipPath stringByDeletingPathExtension]];
            }
            
            [FilesManager deleteFile:path];
        }
        else{
             NSLog(@"unzip failed");
        }
        [unzip UnzipCloseFile];
    }
    [unzip release];
    unzip = nil;
}

@end
