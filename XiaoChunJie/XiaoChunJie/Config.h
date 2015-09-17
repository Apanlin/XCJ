//
//  Config.h
//  XiaoChunJie
//
//  Created by Lin Pan on 13-3-10.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject


#define kVersionNum 1
#define kAppID @"3696Z49KZ7.com.pan-apps.xiaochunjie"
//沙盒目录
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
//漫画plist文件目录
#define kMHPlistFilePath [kDocumentPath stringByAppendingPathComponent:@"MHFiles.plist"]

//umeng
#define UMENG_APPKEY @"51205c5252701565b600000f"
//waps_id
#define WAPS_ID @"de1ffd9fbfe736e5f8a669436ccf0091"
#define kChannel @"appstore"

#define Color(r,g,b,a) [UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:a]

typedef enum {
    kMeunShowFeedbck,
    kMeunDownload,
}MeunType;

//api
#define kBaseApiUrl @"http://www.pan-apps.com/apps/"
#define kGetMHList @"getmanhualist.php"
#define kCheckVersion @"checkXCJVersion.php"
+(NSString *)getVersion;

@end
