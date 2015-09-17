//
//  DownloadTask.h
//  WisdomCloud
//
//  Created by Lin Pan on 12-8-9.
//
//

#import <Foundation/Foundation.h>
@interface DownloadTask : NSObject
{
    UIProgressView *_progress;
    UILabel *_statusLable;
    BOOL _bStart; //标记有没有开始传输
    NSString *_address;
    NSString *_savePath;
    NSString *_name;
    NSString *_fileType;
    NSString *_fid;
}
 
@property(retain,nonatomic) UIProgressView *progress;
@property(retain,nonatomic) UILabel *statusLable;
@property(retain,nonatomic) NSString *address;
@property(retain,nonatomic) NSString *savePath;
@property(retain,nonatomic) NSString *name;
@property(retain,nonatomic) NSString *fileType;
@property(nonatomic,assign) BOOL bStart;
@property(nonatomic,retain) NSString *fid;
@property(nonatomic,assign) BOOL bSave2Album;//是否存到相册


-(id)initWithURL:(NSString *)urlStr savePath:(NSString *)savePath fileName:(NSString *)name;
@end
