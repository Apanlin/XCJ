//
//  DownloadHandler.h
//  DownloadHandler
//
//  Created by Apan on 2013-2-6
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
// Extension by Apan 2012-7-31

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "DownloadTask.h"
@protocol DownloadHandlerDelegate <NSObject>
@optional
-(void)didDownloadSucceedWithTask:(DownloadTask *)downloadTask;
-(void)didDownloadFailedWithTask:(DownloadTask *)downloadTas;
-(void)didUnzipSucceeAtPath:(NSString *)filePath;
-(void)didUnzipFailed;
@end


@interface DownloadHandler : NSObject<ASIHTTPRequestDelegate, ASIProgressDelegate>

@property(nonatomic,assign)id<DownloadHandlerDelegate> delegate;


+(DownloadHandler *)sharedInstance;
-(void)startTask:(DownloadTask *)task;
-(void)stopTask:(DownloadTask *)task;
@end
