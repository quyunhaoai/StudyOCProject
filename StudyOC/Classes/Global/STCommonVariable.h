//
//  STCommonVariable.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/23.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#ifndef STCommonVariable_h
#define STCommonVariable_h

/* 外边距、内边距 */
//外边距
static float const kkMarginSuper = 70.f;
static float const kkMarginMax = 55.f;
static float const kkMarginHuge = 45.f;
static float const kkMarginLarge = 40.f;
static float const kkMarginNormal = 30.f;
static float const kkMarginSmall = 20.f;
static float const kkMarginMin = 15.f;
static float const kkMarginTiny = 10.f;
//内边距
static float const kkPaddingSuper = 30.f;
static float const kkPaddingMax = 25.f;
static float const kkPaddingHuge = 20.f;
static float const kkPaddingLarge = 15.f;
static float const kkPaddingNormalLarge = 12.f;
static float const kkPaddingNormal = 10.f;
static float const kkPaddingSmall = 5.f;
static float const kkPaddingMin = 4.f;
static float const kkPaddingTiny = 2.f;

/* 图标、头像尺寸 */
//图标
static CGSize const kkIconSizeSuper = (CGSize){37.f, 37.f};
static CGSize const kkIconSizeMax = (CGSize){33.f, 33.f};
static CGSize const kkIconSizeHuge = (CGSize){27.f, 27.f};
static CGSize const kkIconSizeLarge = (CGSize){24.f, 24.f};
static CGSize const kkIconSizeNormal = (CGSize){22.f, 22.f};
static CGSize const kkIconSizeSmall = (CGSize){20.f, 20.f};
static CGSize const kkIconSizeMin = (CGSize){18.f, 18.f};
static CGSize const kkIconSizeTiny = (CGSize){15.f, 15.f};
static CGSize const kkIconSizeMinimum = (CGSize){12.f, 12.f};
//图片/头像
static CGSize const kkImageSizeSuper = (CGSize){105.f, 105.f};
static CGSize const kkImageSizeMax = (CGSize){90.f, 90.f};
static CGSize const kkImageSizeHuge = (CGSize){75.f, 75.f};
static CGSize const kkImageSizeLarge = (CGSize){62.f, 62.f};
static CGSize const kkImageSizeNormal = (CGSize){45.f, 45.f};
static CGSize const kkImageSizeSmall = (CGSize){42.f, 42.f};
static CGSize const kkImageSizeMin = (CGSize){40.f, 40.f};
static CGSize const kkImageSizeTiny = (CGSize){30.f, 30.f};
static CGSize const kkImageSizeMinimum = (CGSize){25.f, 25.f};

/* 不透明度 */
static float const kkLowOpacity = .3f;//30%，低不透明
static float const kkNormalOpacity = .5f;//50%，中不透明(常用于按钮)
static float const kkHighOpacity = .75f;//75%，高不透明(常用语遮罩）

typedef NS_ENUM(NSInteger, KKSectionOpType){
    KKSectionOpTypeAddToFavSection,//添加到用户感兴趣的板块
    KKSectionOpTypeRemoveFromFavSection,//从用户感兴趣的板块中删除
};

typedef NS_ENUM(NSInteger, KKNetworkStatus){
    KKNetworkStatusUnknown = -1,//未知状态
    KKNetworkStatusNotReachable = 0,//无网状态
    KKNetworkStatusReachableViaWWAN = 1,//手机网络
    KKNetworkStatusReachableViaWiFi = 2,//Wifi网络
};

typedef NS_ENUM(NSInteger, KKBarButtonType){
    KKBarButtonTypeUpvote,//点赞
    KKBarButtonTypeComment,//评论
    KKBarButtonTypeShare,//分享
    KKBarButtonTypeBury,//点踩
    KKBarButtonTypeFavorite,//收藏
    KKBarButtonTypeMore,//收藏
    KKBarButtonTypeConcern,//关注
    KKBarButtonTypePlayVideo,//播放视频
};

typedef NS_ENUM(NSInteger, KKMoveDirection){
    KKMoveDirectionNone,
    KKMoveDirectionUp,
    KKMoveDirectionDown,
    KKMoveDirectionRight,
    KKMoveDirectionLeft
} ;

typedef NS_ENUM(NSInteger, KKShowViewType){
    KKShowViewTypeNone,
    KKShowViewTypePush,
    KKShowViewTypePopup,
} ;

typedef NS_ENUM(NSInteger, KKBottomBarType){
    KKBottomBarTypePersonalComment,//个人评论页面
    KKBottomBarTypePictureComment,//图片新闻的评论页面
    KKBottomBarTypeNewsDetail,//新闻详情页面
} ;

//用户访问相册权限
typedef NS_ENUM(NSInteger, KKPhotoAuthorizationStatus){
    KKPhotoAuthorizationStatusNotDetermined = 0,  // User has not yet made a choice with regards to this application
    
    KKPhotoAuthorizationStatusRestricted,         // This application is not authorized to access photo data.
    // The user cannot change this application’s status, possibly due to active restrictions
    //   such as parental controls being in place.
    KKPhotoAuthorizationStatusDenied,             // User has explicitly denied this            application access to photos data.
    
    KKPhotoAuthorizationStatusAuthorized         // User has authorized this application to access photos data.
};

//相片分组的日期格式
typedef NS_ENUM(NSInteger, KKDateFormat){
    KKDateFormatYMD = 0, // yyyy-mm-dd
    KKDateFormatYM,// yyyy-mm
    KKDateFormatYear //yyyy
};

typedef NS_ENUM(NSInteger,KKViewTag){
    KKViewTagPersonInfoScrollView = 100000 ,//他人信息(动态，文章等视图的父视图)scrollview的tag，主要用于解决手势冲突
    KKViewTagRecognizeSimultaneousTableView,//他人信息最外层tableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoDongTai ,//他人信息动态视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoArtical ,//他人信息文章视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoVideo ,//他人信息视频视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoWenDa ,//他人信息问答视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoRelease ,//他人信息发布厅视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagPersonInfoMatrix ,//他人信息矩阵视图的uitableview的tag，主要用于解决手势冲突
    KKViewTagUserCenterView ,//个人中心的uitableview的tag，主要用于解决手势冲突
    KKViewTagImageDetailView ,//相片预览视图tag，主要用于解决手势冲突
    KKViewTagImageDetailDescView ,//相片描述视图tag，主要用于解决手势冲突
};

@protocol KKCommonDelegate <NSObject>//通用，
@optional
- (void)didSelectWithView:(UIView *)view andCommonCell:(NSIndexPath *)index;
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item;
- (void)shieldBtnClicked:(id)item;
- (void)jumpBtnClicked:(id)item;
- (void)jumpToUserPage:(NSString *)userId;
- (void)clickImageWithItem:(id)item rect:(CGRect)rect fromView:(UIView *)fromView image:(UIImage *)image indexPath:(NSIndexPath *)indexPath;
@end

@protocol KKCommentDelegate <NSObject>//评论
@optional
- (void)diggBtnClick:(NSString *)commemtId callback:(void(^)(BOOL suc))callback;
- (void)setConcern:(BOOL)isConcern userId:(NSString *)userId callback:(void(^)(BOOL isSuc))callback;
- (void)jumpToUserPage:(NSString *)userId;
- (void)showAllDiggUser:(NSString *)commemtId;
- (void)reportUser:(NSString *)userId ;
- (void)showAllComment:(NSString *)commentId;
@end
/*
 [self.headerIconView setCornerImageWithURL:[NSURL URLWithString:@""] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
 self.titleLabel.text = @"美好的一天从新开始，我门一起来保护地球！节约用水！关爱地球，q我门的y家园";
 self.nameStringLabel.text = @"蔚蓝的天空";
 self.subNameStringLabel.text = @"本视频有光引科技赞助！";
 NSRange dddd = NSMakeRange(4, 4);
 self.descLabel.text = @"本视频有光引科技赞助";
 SetRichTextLabel(self.descLabel, FONT_10,dddd, kRedColor);
 self.commentLabel.text = @"1234评论";
 [self.coverView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:IMAGE_NAME(STSystemDefaultImageName)];
 [self.rightBtn setTitle:@"123" forState:UIControlStateNormal];
 [self.stateLabel setText:@"转载"];
 [self.rightBtn setBackgroundColor:kBlackColor];
 self.tagView.dataSources = @[@"点赞超百万",@"新人",@"人气达人",@"活跃人气王",@"超人",@"已看过的",@"已关注的",@"123",@"新人",@"人气达人",@"活跃人气王",@"456"];
 self.videoTimeLabel.text = @"2.5万 3.05";
 */
static inline NSDictionary *testDataDict(){
    NSDictionary *dict = @{@"data":@{
                                   @"header":@[],
                                   @"content":@[@{@"title":@"美好的一天从新开始，我门一起来保护地球！节约用水！关爱地球，我门的家园",
                                                  @"nameString":@"",
                                                  },
                                                @{@"title":@"美好的一天从新开始，我门一起来保护地球！节约用水！关爱地球，我门的家园",
                                                  @"nameString":@"",
                                                  },
                                                @{@"title":@"美好的一天从新开始，我门一起来保护地球！节约用水！关爱地球，我门的家园",
                                                  @"nameString":@"",
                                                  },
                                                @{@"title":@"美好的一天从新开始，我门一起来保护地球！节约用水！关爱地球，我门的家园",
                                                  @"nameString":@"",
                                                  },
                                                @{@"title":@"美好的一天从新开始，我门一起来保护地球！节约用水！关爱地球，我门的家园",
                                                  @"nameString":@"",
                                                  },
                                                ],
                                   @"footer":@[],
                                   }
                           
                          
    };
    return dict;
    
}
#endif /* STCommonVariable_h */
