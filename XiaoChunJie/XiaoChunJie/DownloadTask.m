//
//  DownloadTask.m
//  WisdomCloud
//
//  Created by Lin Pan on 12-8-9.
//
//

#import "DownloadTask.h"

@implementation DownloadTask
@synthesize progress = _progress;
@synthesize statusLable = _statusLable;
@synthesize bStart = _bStart;
@synthesize address = _address;
@synthesize savePath = _savePath;
@synthesize fileType = _fileType;
@synthesize name = _name;
@synthesize fid = _fid;
@synthesize bSave2Album = _save2Album;


-(id)init
{
    self = [super init];
    if (self) {
        _progress = [[UIProgressView alloc] init];
        _statusLable = [[UILabel alloc] init];
        _bStart = NO;
        _address = @"";
        _savePath = @"";
    }
    return self;
}
-(id)initWithURL:(NSString *)urlStr savePath:(NSString *)savePath fileName:(NSString *)name
{
    self = [super init];
    if (self) {
        _progress = [[UIProgressView alloc] init];
        _statusLable = [[UILabel alloc] init];
        _bStart = NO;
        _address = @"";
        _savePath = @"";
        
        self.address = urlStr;
        self.savePath = savePath;
        self.name = name;
    }
    return self;
}

-(void)dealloc
{
    [_progress release];
    [_statusLable release];
    [_address release];
    [_savePath release];
    [_fileType release];
    [_name release];
    [_fid release];
    [super dealloc];
}
@end
