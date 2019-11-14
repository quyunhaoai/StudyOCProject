//
//  STDefineMacros.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/5.
//  Copyright © 2019 研学旅行. All rights reserved.
//


#ifndef STDefineMacros_h
#define STDefineMacros_h

#define kPrintPathLog (1)           //  打印页面path debug 模式下
/*================================常用宏===============================*/
//定义窗口大小
#define Window_Bounds   [UIScreen mainScreen].bounds
#define Window_H        [[UIScreen mainScreen] bounds].size.height
#define Window_W        [[UIScreen mainScreen] bounds].size.width

//这里的375我是针对6s为标准适配的,如果需要其他标准可以修

#define kWidth(R)  (R)*(Window_W)/375.0
//这里的667我是针对6s为标准适配的,如果需要其他标准可以修改
//#define kHeight(R) (R)*(Window_H)/667.0
//这里的812我是针对iphoneX为标准适配的,如果需要其他标准可以修改
#define kHeight(R) (R)*(Window_H)/812.0
//  列表个数
#define XYPageCount     10

#define KCellDefultHeight 48.0
//数据库表名
#define STBGFMDB_tableName @"messageHistory"
#define client  @"ios"
#define STImageViewDefaultImageMacro IMAGE_NAME(STimagDefault)
////适配的一些宏定义
#define IOS11_OR_LATER        ( [[[UIDevice currentDevice] systemVersion] compare:@"11.0" options:NSNumericSearch] != NSOrderedAscending )
//判断设备类型
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否是ipad
#define IS_PAD (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define iPhone4 (kScreenHeight == 480)
//判断iPhone5系列
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhone6系列
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
//判断iphone6+系列
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
// 判断是否是iPhone X 判断iPhoneXs
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_PAD: NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size)) && !IS_PAD : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_PAD : NO)

// 状态栏高度
#define STATUS_BAR_HEIGHT ((iPhoneX==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT ((iPhoneX==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
// tabBar高度
#define TAB_BAR_HEIGHT ((iPhoneX==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 34.f + 49.f : 49.0)
// home indicator
#define HOME_INDICATOR_HEIGHT ((iPhoneX==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs_Max== YES) ? 34.f : 0.f)

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//弱引用
#define XYWeakSelf      __weak __typeof(&*self) weakSelf = self
#define __weakify(type) @weakify(type)
#define __strongify(type) @strongify(type)
//IntToString
#define XYIntToString(theInt) ([NSString stringWithFormat:@"%d",theInt])

//FloatToString
#define XYFloatToString(theFloat) ([NSString stringWithFormat:@"%.0f",theFloat])

//服务器返回值验证
#define validateGetStr(TheStr)((TheStr==[NSNull null] || !TheStr)?@"":[NSString stringWithFormat:@"%@",TheStr])

/*判断是否为nil,如果是,返回空字符串*/
#define checkNull(__X__)                     [(__X__) isKindOfClass:[NSNull class]] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]
#define checkNullReplaceZero(__X__)          [(__X__) isKindOfClass:[NSNull class]] || (__X__) == nil ? @"0" : [NSString stringWithFormat:@"%@", (__X__)]
/**效果同上,可以自定制返回字符串*/
#define checkAndReplace(__X__, __Y__)        [(__X__) isKindOfClass:[NSNull class]] || (__X__) == nil ? [NSString stringWithFormat:@"%@", (__Y__)] : [NSString stringWithFormat:@"%@", (__X__)]
/**
 *  字符串空判断替换
 *
 *  @param str     当前字符串
 *  @param default 默认字符串
 *
 *  @return 如果为空返回默认字符串 不为空则返回对应字符串
 */
#define NSSTRING_NULL_DEFAULT(str,default) (str.length<=0||[str isEqual:[NSNull null]])?default:str

/**
 *  解析字典中字段字符串数据
 *
 *  @param d          当前数据源
 *  @param k          当前对应的key
 *
 *  @return 返回解析后的摒除空判断的数据
 */
#define BACKINFO_DIC_2_STRING(d , k) ([d objectForKey:k] == [NSNull null]||[[d objectForKey:k] isEqualToString:@""])?@"":[d objectForKey:k]

/**
 *  解析字典中字段整形数据
 *
 *  @param d          当前数据源
 *  @param k          当前对应的key
 *
 *  @return 返回解析后的摒除空判断的数据
 */
#define BACKINFO_DIC_2_INTAGER(d , k) ([d objectForKey:k] == [NSNull null])?0:[[d objectForKey:k] integerValue]

/**
 *  解析字典中字段整形数据
 *
 *  @param d          当前数据源
 *  @param k          当前对应的key
 *
 *  @return 返回解析后的摒除空判断的数据
 */
#define BACKINFO_DIC_2_INT(d , k) ([d objectForKey:k] == [NSNull null])?0:[[d objectForKey:k] intValue]

/**
 *  解析字典中字段浮点类型数据
 *
 *  @param d          当前数据源
 *  @param k          当前对应的key
 *
 *  @return 返回解析后的摒除空判断的数据
 */
#define BACKINFO_DIC_2_DOUBLE(d , k) ([d objectForKey:k] == [NSNull null])?.0f:[[d objectForKey:k] doubleValue]

/**
 *  解析字典中字段浮点类型数据
 *
 *  @param d          当前数据源
 *  @param k          当前对应的key
 *
 *  @return 返回解析后的摒除空判断的数据
 */
#define BACKINFO_DIC_2_FLOAT(d , k) ([d objectForKey:k] == [NSNull null])?.0f:[[d objectForKey:k] floatValue]

/**
 *  解析字典中字段长整形数据
 *
 *  @param d          当前数据源
 *  @param k          当前对应的key
 *
 *  @return 返回解析后的摒除空判断的数据
 */
#define BACKINFO_DIC_2_LLONG(d , k) ([d objectForKey:k] == [NSNull null])?0:[[d objectForKey:k] longLongValue]

/**
 *  解析字典中字段布尔数据
 *
 *  @param d          当前数据源
 *  @param k          当前对应的key
 *
 *  @return 返回解析后的摒除空判断的数据
 */
#define BACKINFO_DIC_2_BOOL(d , k) ([d objectForKey:k] == [NSNull null])?0:[[d objectForKey:k] boolValue]

/**
 *  解析字典中字段对象数据
 *
 *  @param d          当前数据源
 *  @param k          当前对应的key
 *
 *  @return 返回解析后的摒除空判断的数据
 */
#define BACKINFO_DIC_2_OBJECT(d , k) ([d objectForKey:k] == [NSNull null])?nil:[d objectForKey:k]

/**
 *  整型数据转换字符串
 *
 *  @param a 当前数据
 *
 *  @return 转换后的字符串
 */
#define STRING_FROM_INTAGER(a) [NSString stringWithFormat:@"%d",(int)a]

/**
 *  布尔数据转换字符串
 *
 *  @param a 当前数据
 *
 *  @return 转换后的字符串
 */
#define STRING_FROM_BOOL(a) [NSString stringWithFormat:@"%d",(int)a]

/**
 *  长整型数据转换字符串
 *
 *  @param a 当前数据
 *
 *  @return 转换后的字符串
 */
#define STRING_FROM_LLONG(a) [NSString stringWithFormat:@"%lld",a]

/**
 *  浮点数据转换字符串
 *
 *  @param a 当前数据
 *
 *  @return 转换后的字符串
 */
#define STRING_FROM_DOUBLE(a) [NSString stringWithFormat:@"%.9f",a]

#define STRING_FROM_2_FLOAT(a) [NSString stringWithFormat:@"%.2f",a]

/**
 *  获得图片
 *
 *  @param str_Name 图片名字
 *
 *  @return 返回一个UIImage对象
 */
#define IMAGE_NAME(str_Name) [UIImage imageNamed:str_Name]

/**
 *  通过tag找一个控件
 *
 *  @param nameClass 控件类型
 *  @param tag       tag值
 *  @param view      父视图
 *
 *  @return 返回对应类型控件对象
 */
#define FIND_VIEW(nameClass,tag,view) (nameClass *)[view viewWithTag:tag]

/**
 *  计算文字在指定区域所占的宽度
 *
 *  @param str      文字内容
 *  @param height   所占高度
 *  @param font     文字字体
 *
 *  @return 返回文字宽度
 */
#define STRINGFONT_2_WIDTH(str, height, font) [str boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.width

/**
 *  计算文字在指定区域所占的高度
 *
 *  @param str      文字内容
 *  @param width    所占宽度
 *  @param font     文字字体
 *
 *  @return 返回文字高度
 */
#define STRINGFONT_2_HEIGHT(str, width, font) [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height

//获取当前时间戳
#define DATE_NOW_SINCE1970 [[NSDate date] timeIntervalSince1970]

//7.0获取字体size CGRect
#define XYNewGetFontSize(kcontent,kfont,ksize) [kcontent boundingRectWithSize:ksize options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kfont} context:nil]

//设置富文本
#define SetRichTextLabel(showLab,fontNumber,ccc,textColor)\
{\
NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:showLab.text];\
[str addAttribute:NSFontAttributeName value:fontNumber range:ccc];\
[str addAttribute:NSForegroundColorAttributeName value:textColor range:ccc];\
showLab.attributedText = str;\
}\

//设置富文本
#define SetAnthorRichTextLabel(showLab,fontNumber,desTextStr,textColor)\
{\
NSRange range = [showLab.text rangeOfString:desTextStr];\
NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:showLab.text];\
[str addAttribute:NSFontAttributeName value:fontNumber range:range];\
[str addAttribute:NSForegroundColorAttributeName value:textColor range:range];\
showLab.attributedText = str;\
}

/**
 *  获得图片
 *
 *  @param str_Name 图片名字
 *
 *  @return 返回一个UIImage对象
 */
#define ImageNamed(str_Name) [UIImage imageNamed:str_Name]

/******等比例放大,以iphone6尺寸为基础*******/
#define RationEnlarge(data) data*[UIScreen mainScreen].bounds.size.width/375.0f
#define RationEnlarge5s(data) data*[UIScreen mainScreen].bounds.size.width/320.0
#define RationHeight(data)   data*[UIScreen mainScreen].bounds.size.height/667.0
//适配iOS 11 scrollview自动布局
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

#define KKAdjustsScrollViewInsets(scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)
#define degreesToRadian(x) (M_PI * (x) / 180.0)

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

///IOS 版本判断
#define IOSAVAILABLEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] < 0)
// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]
////当前语言
//#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])

// View 坐标(x,y)和宽高(width,height)
#define X(v)               (v).frame.origin.x
#define Y(v)               (v).frame.origin.y
#define WIDTH(v)           (v).frame.size.width
#define HEIGHT(v)          (v).frame.size.height

//#define MinX(v)            CGRectGetMinX((v).frame) // 获得控件屏幕的x坐标
//#define MinY(v)            CGRectGetMinY((v).frame) // 获得控件屏幕的Y坐标

#define MidX(v)            CGRectGetMidX((v).frame) //横坐标加上到控件中点坐标
#define MidY(v)            CGRectGetMidY((v).frame) //纵坐标加上到控件中点坐标

//#define MaxX(v)            CGRectGetMaxX((v).frame) //横坐标加上控件的宽度
//#define MaxY(v)            CGRectGetMaxY((v).frame) //纵坐标加上控件的高度

// 日志

#ifdef DEBUG

#define XYLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#elif DEBUGUAT

#define XYLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

//#define XYLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#define XYLog(...);


#endif

#pragma mark 国际化
//  国际化
#define XYLocalizedString(key) NSLocalizedString(key, nil)

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

/**
 *  获得缩略图URLString(300)
 *
 *  @param str_Name 图片名字
 *
 *  @return 返回一个字符串URLString对象
 */
#define KThumbnailString(str_Name) [NSString stringWithFormat:@"%@?imageView2/2/w/300",str_Name]
//#define KThumbnailString(str_Name) [NSString stringWithFormat:@"%@",str_Name]

//#define KCOSThumbnailString(str_Name) [NSString stringWithFormat:@"%@?imageView2/1/w/400/h/600/q/85",str_Name]

/**
 *  获得缩略图URL(300)
 *
 *  @param str_Name 图片名字
 *
 *  @return 返回一个字符串URL对象
 */
#define KThumbnailStringURL(str_Name) [NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/2/w/300",str_Name]]

//#define KCOSThumbnailStringURL(str_Name) [NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/400/h/600/q/85",str_Name]]

/**
 *  获得缩略图URL(自定义)
 *
 *  @param str_Name 图片名字 size尺寸
 *
 *  @return 返回一个字符串URL对象
 */
#define KCustomThumbnailStringURL(str_Name,size) [NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/2/w/%@",str_Name,size]]

//#define KCOSCustomThumbnailStringURL(str_Name,size) [NSURL URLWithString:[NSString stringWithFormat:@"%@?imageView2/1/w/%@/h/600/q/85",str_Name,size]]

//获取一个随机整数，范围在[from,to），包括from，不包括to
#define kArc4random(from,to) (int)(from + (arc4random() % (to - from + 1)))

/*================================COLOR/FONT===============================*/
#pragma mark  -  color
//颜色相关
#define KKColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define randomColorValue arc4random_uniform(256)
#define KKRandomColor [UIColor colorWithRed:(randomColorValue)/255.0 green:(randomColorValue)/255.0 blue:(randomColorValue)/255.0 alpha:1.0]

/**
 *  十六进制色值转化
 *
 *  @param rgbValue 当前色值
 *
 *  @return 返回当前UIColor颜色
 */
#define COLOR_HEX_RGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//7.0获取字体size CGRect
#define ZYNewGetFontSize(kcontent,kfont,ksize) [kcontent boundingRectWithSize:ksize options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kfont} context:nil]

/**
 *  UIButton起始Tag 19911022
 */
#define BUTTON_TAG(tag)         (19911022+tag)

/**
 *  UILabel起始Tag 19981022
 */
#define LABEL_TAG(tag)          (19981022+tag)

/**
 *  UIImageView起始Tag 19991022
 */
#define IMAGEVIEW_TAG(tag)      (19991022+tag)


//  COLOR_ + 所属意义   参照：XIYUAN-5.0-UI 戏缘ui 通用规范
#define COLOR_F42415 COLOR_HEX_RGB(0xF42415)    //  C1  重要色:用于特别需要强调和突出的文字、按钮和 icon,如页面状态栏与界面相关按钮、icon、提示等
#define COLOR_333333 COLOR_HEX_RGB(0x333333)    //  C2  重要色:用于重要及文字信息、内容标题信息,如戏曲名称、大板块标题、类目名称等
#define COLOR_477aac COLOR_HEX_RGB(0x477aac)    //  C8  重要色:小面积使用，用于重要链接文字颜色
#define COLOR_999999 COLOR_HEX_RGB(0x999999)    //  C3  一般色:用于辅助、次要的文字信息,如戏曲选段、时间等相关信息
#define COLOR_f5f5f5 COLOR_HEX_RGB(0xf5f5f5)    //  C6  较弱色:用于内容区域底色
#define COLOR_e5e5e5 COLOR_HEX_RGB(0xe5e5e5)    //  C5  较弱色:用于分割线
#define COLOR_cccccc COLOR_HEX_RGB(0xcccccc)    //  C7  较弱色:用于特殊说明字体及提示字体
#define COLOR_666666 COLOR_HEX_RGB(0x666666)    //  C4  较弱色:？
#define COLOR_2A9F5D COLOR_HEX_RGB(0x2A9F5D)    //  C4  绿帽子的颜色
#define COLOR_696969 COLOR_HEX_RGB(0x696969)    //  C4  较弱色:？
#define COLOR_477AAC COLOR_HEX_RGB(0x477AAC)    //  C4  较弱色:？

#define COlOR_EDEDED COLOR_HEX_RGB(0xEDEDED)        //内容区域底色
#define COlOR_EFEFF4 COLOR_HEX_RGB(0xEFEFF4)        //内容区域底色
#define COlOR_E5E5EA COLOR_HEX_RGB(0xE5E5EA)        //内容区域底色
#define COLOR_D1D1D6 COLOR_HEX_RGB(0xD1D1D6)
#define COLOR_C7C7CC COLOR_HEX_RGB(0xC7C7CC)
#define COLOR_8E8E93 COLOR_HEX_RGB(0x8E8E93)
#define COLOR_056377 COLOR_HEX_RGB(0x056377)        //用于特殊字体链接跳转
#define COLOR_d2d1d1 COLOR_HEX_RGB(0xd2d1d1)
#define COLOR_13B900 COLOR_HEX_RGB(0x13B900)        //绿色线条y背景色
#define COLOR_bbbbbb COLOR_HEX_RGB(0xbbbbbb)        //绿色线条y背景色
#define COLOR_E92101 COLOR_HEX_RGB(0xE92101)        //绿色线条y背景色
#define COLOR_E1451F COLOR_HEX_RGB(0xE1451F)        //按钮背景色
#define COLOR_BDBDBD COLOR_HEX_RGB(0xBDBDBD)         //线条x灰色

#define color_010100 COLOR_HEX_RGB(0x010100)
#define color_viewBG_1A1929 COLOR_HEX_RGB(0x1A1929)
#define color_B2B2B2 COLOR_HEX_RGB(0xB2B2B2)        //菜单文字底色
#define color_text_AFAFB1  COLOR_HEX_RGB(0xAFAFB1)  //灰色字体 用于描述 一般色:用于辅助、次要的文字信息,如戏曲选段、时间等相关信息
#define color_textBg_C7C7D1 COLOR_HEX_RGB(0xC7C7D1)
#define color_tipYellow_FECE24   COLOR_HEX_RGB(0xFECE24) //提醒色
#define color_contenBg_1A1A26 COLOR_HEX_RGB(0x1A1A26) //底色
#define color_button_FC2D57 COLOR_HEX_RGB(0xFC2D57) //订阅按钮色
#define color_tipRed_FF0000 COLOR_HEX_RGB(0xFF0000)
#define color_cellBg_151420 COLOR_HEX_RGB(0x151420) //cell背景色

#define kBlackColor         [UIColor blackColor]
#define kDarkGrayColor      [UIColor darkGrayColor]
#define kLightGrayColor     [UIColor lightGrayColor]
#define kWhiteColor         [UIColor whiteColor]
#define kGrayColor          [UIColor grayColor]
#define kRedColor           [UIColor redColor]
#define kGreenColor         [UIColor greenColor]
#define kBlueColor          [UIColor blueColor]
#define kCyanColor          [UIColor cyanColor]
#define kYellowColor        [UIColor yellowColor]
#define kMagentaColor       [UIColor magentaColor]
#define kOrangeColor        [UIColor orangeColor]
#define kPurpleColor        [UIColor purpleColor]
#define kClearColor         [UIColor clearColor]

//  FONT_ + 所属PT    参照：XIYUAN-5.0-UI 戏缘ui 通用规范
#define FONT_18 [UIFont systemFontOfSize:RationEnlarge(18.f)]    //  T1  用在导航栏标题
#define FONT_16 [UIFont systemFontOfSize:RationEnlarge(16.f)]    //  T2  用于筛选标题或戏曲标题
#define FONT_15 [UIFont systemFontOfSize:RationEnlarge(15.f)]
#define FONT_14 [UIFont systemFontOfSize:RationEnlarge(14.f)]    //  T3  用于小标题
#define FONT_13 [UIFont systemFontOfSize:RationEnlarge(13.f)]    //  T4  用于辅助性文字（如唱过人数、歌曲大小、时间等）
#define FONT_12 [UIFont systemFontOfSize:RationEnlarge(12.f)]
#define FONT_11 [UIFont systemFontOfSize:RationEnlarge(11.f)]    //
#define FONT_10 [UIFont systemFontOfSize:RationEnlarge(10.f)]    //  T5  用于辅助性文字（如底部导航栏字体大小或需要特殊说明地方）

#define ColorWhiteAlpha10 RGBA(255.0, 255.0, 255.0, 0.1)
#define ColorWhiteAlpha20 RGBA(255.0, 255.0, 255.0, 0.2)
#define ColorWhiteAlpha40 RGBA(255.0, 255.0, 255.0, 0.4)
#define ColorWhiteAlpha60 RGBA(255.0, 255.0, 255.0, 0.6)
#define ColorWhiteAlpha80 RGBA(255.0, 255.0, 255.0, 0.8)
#define ColorBlackAl RGBA(0.0, 0.0, 0.0, 0.1)
#define ColorBlackAlpha1 RGBA(0.0, 0.0, 0.0, 0.01)
#define ColorBlackAlpha5 RGBA(0.0, 0.0, 0.0, 0.05)
#define ColorBlackAlpha10 RGBA(0.0, 0.0, 0.0, 0.1)
#define ColorBlackAlpha20 RGBA(0.0, 0.0, 0.0, 0.2)
#define ColorBlackAlpha40 RGBA(0.0, 0.0, 0.0, 0.4)
#define ColorBlackAlpha60 RGBA(0.0, 0.0, 0.0, 0.6)
#define ColorBlackAlpha80 RGBA(0.0, 0.0, 0.0, 0.8)
#define ColorBlackAlpha90 RGBA(0.0, 0.0, 0.0, 0.9)

#define FONT_Medium_18 [UIFont fontWithName:@"PingFangSC-Medium" size:RationEnlarge(18.f)]    //Medium_18加粗
#define FONT_Medium_16 [UIFont fontWithName:@"PingFangSC-Medium" size:RationEnlarge(16.f)]    //Medium_16加粗
#define FONT_Medium_15 [UIFont fontWithName:@"PingFangSC-Medium" size:RationEnlarge(15.f)]    //Medium_15加粗
#define FONT_Medium_14 [UIFont fontWithName:@"PingFangSC-Medium" size:RationEnlarge(14.f)]    //Medium_14加粗
#define STFont(size) [UIFont systemFontOfSize:(size)]
#define STBoldFont(size) [UIFont boldSystemFontOfSize:(size)]



//扫一扫
#define LBXScan_Define_Native  //包含native库
#define LBXScan_Define_ZXing   //包含ZXing库
#define LBXScan_Define_ZBar   //包含ZBar库
#define LBXScan_Define_UI     //包含界面库

//kkTodayNews
//基本类型
#define SYNTHESIZE_CATEGORY_VALUE_PROPERTY(valueType, propertyGetter, propertySetter)\
- (valueType) propertyGetter {\
valueType ret = {0};\
[objc_getAssociatedObject(self, @selector( propertyGetter )) getValue:&ret];\
return ret;\
}\
- (void) propertySetter (valueType)value{\
NSValue *valueObj = [NSValue valueWithBytes:&value objCType:@encode(valueType)];\
objc_setAssociatedObject(self, @selector( propertyGetter ), valueObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);\
}

// block 安全self
#if __has_feature(objc_arc)
// arc
#define WEAKSELF        typeof(self) __weak weakSelf = self
#define STRONGSELF      typeof(weakSelf) __strong strongSelf = weakSelf
#else
// mrc
#define WEAKSELF     __block typeof(id) weakSelf = self;
#define WEAKSELF_( __CLASSNAME__ )     __block typeof( __CLASSNAME__ *) weakSelf = self;
#endif

#define __weakify(type) @weakify(type)
#define __strongify(type) @strongify(type)







#endif /* STDefineMacros_h */
