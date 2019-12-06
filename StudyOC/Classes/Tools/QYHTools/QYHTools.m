//
//  QYHTools.m
//  YUNDBAP
//
//  Created by hao on 17/9/25.
//
//

#import "QYHTools.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "CommentsPopView.h"
@interface QYHTools()<NSURLSessionDownloadDelegate,KKShareViewDelegate>
{

}
@property(nonatomic,strong)NSURLSessionDownloadTask *downloadTask;
@end
@implementation QYHTools
/**
 单例方法
 */
+ (instancetype)sharedInstance
{
    static QYHTools *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    
    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    return newImage;
}
+(UIImage *) getImageFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

+(NSData *) getDataFromURL:(NSString *)fileURL {
    NSLog(@"执行图片下载函数");
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    return data;
}

+(UIImage *) loadImage:(NSString *)fileName
{
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@", fileName]];
    
    return result;
}

+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension
{
    NSString *filePath = imageName;
    if ([[extension lowercaseString] isEqualToString:@"png"])
    {
        BOOL isOK = [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        NSLog(@"%@",[NSString stringWithFormat:@"%d",isOK]);
    }
    else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"])
    {
        BOOL isOK = [UIImageJPEGRepresentation(image, 0.7) writeToFile:filePath atomically:YES];
        NSLog(@"%@",[NSString stringWithFormat:@"%d",isOK]);
    }
    else
    {
        NSLog(@"文件后缀不认识");
    }
}
#pragma mark -颜色转换
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
#pragma mark 偏好设置
/*偏好设置*/
+ (void)UserDefaultsObj:(id)obj key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/*获取偏好设置*/
+ (id)UserDefaultsObjectForKey:(NSString *)key {
    id obj = nil;
    obj = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return obj;
}
/*删除用户偏好设置*/
+ (void)removeUserDataWithkey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
/*对象归档偏好设置*/
+ (void)archiveObj:(id)obj withKey:(NSString *)key {
    NSData *archiveCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:obj];
    [[NSUserDefaults standardUserDefaults] setObject:archiveCarPriceData forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/*获取偏好设置对象*/
+ (id)unArchiveKey:(NSString *)key {
    NSData *myEncodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return  [NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
}
/*对象转字符串*/
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@" " withString:@""];
        
    }
    return jsonString;
}
#pragma mark 文件管理
/*读程序目录而准备*/
+(NSString *)bundlePath:(NSString *)fileName {
    return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
}
/*用户文档文件路径*/
+(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}
/*获取用户文档文件路径*/
+(NSString *)documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
/*获取缓存路径*/
+(NSString *)getCachesPath{
    
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
}
+ (void)removeDirectoryPath:(NSString *)directoryPath
{
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 抛异常
        // name:异常名称
        // reason:报错原因
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"笨蛋 需要传入的是文件夹路径,并且路径要存在" userInfo:nil];
        [excp raise];
        
    }
    
    // 获取cache文件夹下所有文件,不包括子路径的子路径
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        // 拼接完成全路径
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        
        // 删除路径
        [mgr removeItemAtPath:filePath error:nil];
    }
    
}

// 自己去计算SDWebImage做的缓存
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion
{
    
    // 获取文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory;
    BOOL isExist = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isExist || !isDirectory) {
        // 抛异常
        // name:异常名称
        // reason:报错原因
        NSException *excp = [NSException exceptionWithName:@"pathError" reason:@"笨蛋 需要传入的是文件夹路径,并且路径要存在" userInfo:nil];
        [excp raise];
        
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 获取文件夹下所有的子路径,包含子路径的子路径
        NSArray *subPaths = [mgr subpathsAtPath:directoryPath];
        
        NSInteger totalSize = 0;
        
        for (NSString *subPath in subPaths) {
            // 获取文件全路径
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            // 判断隐藏文件
            if ([filePath containsString:@".DS"]) continue;
            
            // 判断是否文件夹
            BOOL isDirectory;
            // 判断文件是否存在,并且判断是否是文件夹
            BOOL isExist = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            if (!isExist || isDirectory) continue;
            
            // 获取文件属性
            // attributesOfItemAtPath:只能获取文件尺寸,获取文件夹不对,
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            
            // 获取文件尺寸
            NSInteger fileSize = [attr fileSize];
            
            totalSize += fileSize;
        }
        
        // 计算完成回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(totalSize);
            }
        });
        
        
        
    });
    
    
}
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    return result;
}

//保存视频到相册
- (void)saveVideoToALAssetsLibrary:(NSURL *)outputFileURL
{ //PHPhotoLibrary
//    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//    [library writeVideoAtPathToSavedPhotosAlbum:outputFileURL
//                                completionBlock:^(NSURL *assetURL, NSError *error) {
//        if (error) {
//            NSLog(@"保存视频失败:%@",error);
//        } else {
//            NSLog(@"保存视频到相册成功");
//        }
//    }];
}

+ (void)srh_saveImage:(UIImage *)image completionHandle:(void (^)(NSError *, NSString *))completionHandler {
    // 1. 获取照片库对象
       PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
       
       // 假如外面需要这个 localIdentifier ，可以通过block传出去
       __block NSString *localIdentifier = @"sss";
       
       // 2. 调用changeblock
       [library performChanges:^{
           
           // 2.1 创建一个相册变动请求
           PHAssetCollectionChangeRequest *collectionRequest = [self getCurrentPhotoCollectionWithAlbumName:@"photo"];
           
           // 2.2 根据传入的照片，创建照片变动请求
           PHAssetChangeRequest *assetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
           
           // 2.3 创建一个占位对象
           PHObjectPlaceholder *placeholder = [assetRequest placeholderForCreatedAsset];
           localIdentifier = placeholder.localIdentifier;
           
           // 2.4 将占位对象添加到相册请求中
           [collectionRequest addAssets:@[placeholder]];
           
       } completionHandler:^(BOOL success, NSError * _Nullable error) {
           
           if (error) {
//               [iConsole log:@"保存照片出错>>>%@", [error description]];
               completionHandler(error, nil);
           } else {
               completionHandler(nil, localIdentifier);
           }
       }];
}
+ (PHAssetCollectionChangeRequest *)getCurrentPhotoCollectionWithAlbumName:(NSString *)albumName {
    // 1. 创建搜索集合
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 2. 遍历搜索集合并取出对应的相册，返回当前的相册changeRequest
    for (PHAssetCollection *assetCollection in result) {
        if ([assetCollection.localizedTitle containsString:albumName]) {
            PHAssetCollectionChangeRequest *collectionRuquest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
            return collectionRuquest;
        }
    }
    
    // 3. 如果不存在，创建一个名字为albumName的相册changeRequest
    PHAssetCollectionChangeRequest *collectionRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName];
    return collectionRequest;
}
#pragma mark  -  评论视图
- (void)showCommentView:(NSString *)uid {
    CommentsPopView *view = [[CommentsPopView alloc] initWithAwemeId:uid];
    [view show];
}

#pragma mark  -  分享视图
- (void)shareVideo{
    KKShareView *view = [KKShareView new];
    view.shareInfos = [self createShareItems];
    view.frame = [[UIScreen mainScreen]bounds];
    view.delegate = self ;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    [view showShareView];
}

#pragma mark -- 创建更多视图的item

- (NSArray<NSArray<KKShareItem *> *> *)createShareItems{
    KKShareItem *itemWTT = [[KKShareItem alloc]initWithShareType:KKShareTypeWeiTouTiao iconImageName:@"bespoke_editLive_n" title:@"转发"];
    KKShareItem *sendfriend = [[KKShareItem alloc]initWithShareType:KKShareTypeQQ iconImageName:@"bespoke_editLive_n" title:@"私信好友"];
    KKShareItem *itemWX = [[KKShareItem alloc]initWithShareType:KKShareTypeWXFriend iconImageName:@"bespoke_weixin_n" title:@"微信"];
    KKShareItem *itemTime = [[KKShareItem alloc]initWithShareType:KKShareTypeWXTimesmp iconImageName:@"bespoke_pengyouquan_n" title:@"朋友圈"];
    KKShareItem *itemWeiBo = [[KKShareItem alloc]initWithShareType:KKShareTypeWeiBo iconImageName:@"bespoke_weibo_n" title:@"微博"];
    KKShareItem *itemSys = [[KKShareItem alloc]initWithShareType:KKShareTypeSysShare iconImageName:@"bespoke_editLive_n" title:@"系统分享"];
    KKShareItem *report = [[KKShareItem alloc] initWithShareType:KKShareTypeReport iconImageName:@"bespoke_editLive_n" title:@"举报"];
    KKShareItem *coll = [[KKShareItem alloc] initWithShareType:KKShareTypeCollect iconImageName:@"bespoke_editLive_n" title:@"收藏"];
    KKShareItem *itemMsg = [[KKShareItem alloc]initWithShareType:KKShareTypeDown iconImageName:@"bespoke_editLive_n" title:@"保存到相册"];
    KKShareItem *itemEmail = [[KKShareItem alloc]initWithShareType:KKShareTypeNolike iconImageName:@"bespoke_editLive_n" title:@"不感兴趣"];
    KKShareItem *itemCopyLink = [[KKShareItem alloc]initWithShareType:KKShareTypeCopyLink iconImageName:@"bespoke_editLive_n" title:@"复制链接"];
    
    NSArray *array1 =@[itemWTT,sendfriend,itemWX,itemTime,itemWeiBo,itemSys];
    NSArray *array2 =@[report,coll,itemMsg,itemEmail,itemCopyLink];
    
    return @[array1,array2];
}

#pragma mark -- KKShareViewDelegate

- (void)shareWithType:(KKShareType)shareType{
    switch (shareType) {
        case KKShareTypeWXFriend:{
            KKShareObject *shareItem = [KKShareObject new];
            shareItem.title = @"粉号";
            shareItem.desc = @"分享描述";
            shareItem.shareImage = IMAGE_NAME(STSystemDefaultImageName);
            [KKThirdTools shareToWXWithObject:shareItem scene:KKWXSceneTypeChat complete:^(KKErrorCode resultCode, NSString *resultString) {
                
            }];
        }
            break;
        case KKShareTypeWXTimesmp:{
            KKShareObject *shareItem = [KKShareObject new];
            shareItem.title = @"粉号";
            shareItem.desc = @"分享描述";
            shareItem.shareImage = IMAGE_NAME(STSystemDefaultImageName);
            [KKThirdTools shareToWXWithObject:shareItem scene:KKWXSceneTypeChat complete:^(KKErrorCode resultCode, NSString *resultString) {
                
            }];
        }
            break;
        case KKShareTypeWeiBo:{
            KKShareObject *shareItem = [KKShareObject new];
            shareItem.title = @"粉号";
            shareItem.desc = @"分享描述";
            shareItem.shareImage = IMAGE_NAME(STSystemDefaultImageName);
            [KKThirdTools shareToWbWithObject:shareItem complete:^(KKErrorCode resultCode, NSString *resultString) {
                
            }];
        }
            break;
        case KKShareTypeCollect:{//收藏

        }
            break;
        case KKShareTypeNolike:{//不感兴趣

        }
            break;
        case KKShareTypeDown:{//保存到相册

        }
            break;
        case KKShareTypeCopyLink:{//复制链接
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//            pasteboard.string =[NSString stringWithFormat:@"%@%@%@",self.heardItem.nickname,self.heardItem.video_desc, self.heardItem.video_url];
            [MBManager showBriefAlert:@"复制成功"];
        }
            break;
        default:
            break;
    }
}

- (void)followBtnClick:(int )userId andButton:(UIButton *)button {
    NSString *key = [kUserDefaults objectForKey:STUserRegisterInfokey];
    if ([key isNotBlank]) {
         NSDictionary *params = @{@"i":@(1),
                                  @"key":key,
                                  @"uid":@(userId),
        };
        [[STHttpResquest sharedManager] requestWithMethod:POST
                                                 WithPath:@"user_center/do_video_guanzhu"
                                               WithParams:params
                                         WithSuccessBlock:^(NSDictionary * _Nonnull dic){
            NSInteger status = [[dic objectForKey:@"state"] integerValue];
            NSString *msg = [[dic objectForKey:@"msg"] description];
            if(status == 200){
                NSDictionary *data = [dic objectForKey:@"data"];
                int flag_type = [[data objectForKey:@"flag_type"] intValue];
                if (flag_type == 1) {
                    button.layer.backgroundColor = [[UIColor colorWithRed:58.0f/255.0f green:58.0f/255.0f blue:68.0f/255.0f alpha:1.0f] CGColor];
                    [button setTitle:@"已订阅" forState:UIControlStateNormal];
                } else {
                    button.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:144.0f/255.0f alpha:1.0f] CGColor];
                    [button setTitle:@"订阅+" forState:UIControlStateNormal];
                }
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            
        }];
    } else {
        STLoginViewController *vc = [STLoginViewController new];
        vc.barStyle = [UIApplication sharedApplication].statusBarStyle;
        STBaseNav *nav = [[STBaseNav alloc] initWithRootViewController:vc];
        [kRootViewController presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

/** 下载视频 */

-(void)startDownLoadVedioWithUrl:(NSString *)url {

//_model=model;
    NSURLSessionConfiguration*config=[NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession*session=[NSURLSession sessionWithConfiguration:config
                                                       delegate:self
                                                  delegateQueue:[NSOperationQueue mainQueue]];

    self.downloadTask=[session downloadTaskWithURL:[NSURL URLWithString:url]];

    [self.downloadTask resume];

}

#pragma mark NSSessionUrlDelegate
-(void)URLSession:(NSURLSession*)session downloadTask:(NSURLSessionDownloadTask*)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    double progress;
//下载进度CGFloat
    progress=totalBytesWritten/(double)totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(),^{
//进行UI操作 设置进度条
        [WSProgressHUD showProgress:progress];
    });

}

//下载完成 保存到本地相册

-(void)URLSession:(NSURLSession*)session downloadTask:(NSURLSessionDownloadTask*)downloadTask didFinishDownloadingToURL:(NSURL*)location{
//1.拿到cache文件夹的路径
    NSString*cache=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)lastObject];
    NSLog(@"cache:%@",cache);
//2,拿到cache文件夹和文件名
    NSString*file=[cache stringByAppendingPathComponent:self.downloadTask.response.suggestedFilename];[[NSFileManager defaultManager]moveItemAtURL:location toURL:[NSURL fileURLWithPath:file]error:nil];
//3，保存视频到相册
    if(UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(file)){
        //保存相册核心代码
        UISaveVideoAtPathToSavedPhotosAlbum(file,self,nil,nil);
        NSLog(@"保存相册!");
    }
    [WSProgressHUD dismiss];
    [WSProgressHUD showSuccessWithStatus:@"保存成功"];
    [self autoDismiss];
}
- (void)autoDismiss {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WSProgressHUD dismiss];
    });

}
@end
