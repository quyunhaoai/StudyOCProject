//
//  STVideoDetailViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/12.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STVideoDetailViewController.h"

#import "KKAuthorInfoView.h"
#import "KKVideoInfoView.h"
#import "KKRelateVideoCell.h"
#import "KKNewsCommentView.h"
#import "STVideoChannelModl.h"
#define AuthorViewHeight 60
#import "KKShareView.h"
#import "KKShareObject.h"
#import "CommentsPopView.h"
#import "STCustomHeader.h"
static NSString *commentCellReuseable = @"commentCellReuseable";
static NSString *relateVideoCellReuseable = @"relateVideoCellReuseable";
static CGFloat detailVideoPlayViewHeight = 0 ;
@interface STVideoDetailViewController ()<KKAVPlayerViewDelegate,UITableViewDelegate,UITableViewDataSource,KKAuthorInfoViewDelegate,KKShareViewDelegate,KKCommonDelegate>
@property (strong, nonatomic) KKAVPlayerView *detailVideoPlayView; // 视图
@property (strong, nonatomic) UIImageView *videoContentView; //  视图

@property(nonatomic)KKAuthorInfoView *authorView;
@property(nonatomic)UITableView *tableView;
@property(nonatomic)KKVideoInfoView *videoInfoView;

@property(nonatomic,copy)NSMutableArray *commentArray;//评论数组
@property(nonatomic,copy)NSMutableArray *relateVideoArray;

@property(nonatomic,assign)UIStatusBarStyle barStyle;
@property (strong, nonatomic) STVideoChannelModl *heardItem;    //
@end

@implementation STVideoDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlackColor;
    if(iPhoneX){
        detailVideoPlayViewHeight = (Window_W * 0.56 ) + NAVIGATION_BAR_HEIGHT;
    }else{
        detailVideoPlayViewHeight = (Window_W * 0.56 ) ;
    }
    self.page = 1;
    [self initUI];
    [self refreshData];
}

- (UIImageView *)videoContentView{
    if(!_videoContentView){
        _videoContentView = ({
            UIImageView *view = [UIImageView new];
            view.userInteractionEnabled = YES;
//            view.backgroundColor = [UIColor redColor];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.clipsToBounds = YES;
            view;
        });
    }
    return _videoContentView;
}

//- (void)didMoveToParentViewController:(nullable UIViewController *)parent
//{
//    if (parent == nil) {
//        [self.detailVideoPlayView destoryVideoPlayer];
//    }
//}
#pragma mark -- 初始化UI

- (void)initUI{
    [self.view addSubview:self.videoContentView];
    [self.view addSubview:self.authorView];
    [self.view addSubview:self.videoInfoView];
    [self.view addSubview:self.tableView];
    
    [self.videoContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.mas_equalTo(self.view);
        make.height.mas_equalTo(detailVideoPlayViewHeight);
    }];
    
    [self.authorView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.videoContentView.mas_bottom);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(AuthorViewHeight);
    }];
    
    self.videoInfoView.frame = CGRectMake(0, detailVideoPlayViewHeight+AuthorViewHeight, Window_W, 1);
    self.videoInfoView.height = self.videoInfoView.viewHeight;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.videoInfoView.mas_bottom);
        make.left.width.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view).mas_offset(-AuthorViewHeight-detailVideoPlayViewHeight-self.videoInfoView.height).priority(998);
    }];
    [self videoContentViewAddSubView];
//    XYWeakSelf;
//    self.tableView.mj_header = [STCustomHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.tableView.mj_header endRefreshing];
//        });
//    }];
    [self.tableView bindGlobalStyleForHeadRefreshHandler:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.headRefreshControl endRefreshing];
        });
    }];
}
#pragma mark -- 数据刷新

- (void)refreshData{//请求数据，第一条单独出来， 其他s做一个集合，然后点击下面的列表在请求另外的一个接口， 同时移出x当前列表的数据，加载新的列表数据。、
    XYWeakSelf;
    NSDictionary *params = @{@"i":@(1),
                             @"page":@(self.page),
    };
    [[STHttpResquest sharedManager] requestWithMethod:GET WithPath:@"/video/list" WithParams:params WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"state"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSDictionary *dict = [dic objectForKey:@"data"];
            weakSelf.relateVideoArray = [[dict objectForKey:@"video_list"] mutableCopy];
            if (weakSelf.relateVideoArray.count) {
                [weakSelf.tableView reloadData];
            }
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
        weakSelf.isShowNoDataPageView = NO;
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.isShowNoDataPageView = YES;
        [weakSelf.noDataView addTapGestureWithBlock:^(UIView *gestureView) {
            [weakSelf refreshData];
        }];
    }];
            
}
        
- (void)loadHeadItem:(STVideoChannelModl *)model{
//    [self.videoContentView sd_setImageWithURL:[NSURL URLWithString:model.video_thumb]
//                             placeholderImage:STImageViewDefaultImageMacro];
    self.videoInfoView.title = model.video_title;
    self.videoInfoView.descText = model.video_desc;
    self.videoInfoView.height = self.videoInfoView.viewHeight;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.videoInfoView.mas_bottom);
        make.height.mas_equalTo(self.view).mas_offset(-AuthorViewHeight-detailVideoPlayViewHeight-self.videoInfoView.height).priority(998);
    }];
    self.videoInfoView.likeLabel.text = STRING_FROM_INTAGER(model.zan_volume);
    self.videoInfoView.commentLabel.text = STRING_FROM_INTAGER(model.comment_volume);
    self.videoInfoView.tagArray = model.video_type;
    self.authorView.name = model.nickname;
    self.authorView.headUrl = model.headimg;
    self.authorView.isConcern = NO ;
    self.authorView.showDetailLabel = YES;
    self.authorView.detail = model.zuozhe_desc;
    self.authorView.vipImageView.hidden = !model.is_v;
    self.authorView.headerSize = CGSizeMake(40, 40);
    self.authorView.userId = model.uid;
    self.heardItem = model;
}

- (void)videoContentViewAddSubView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"new_play_video_60x60_"] forState:UIControlStateNormal];
    [button setUserInteractionEnabled:YES];
    [button addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.videoContentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.videoContentView);
        make.width.height.mas_equalTo(44);
    }];
}

- (void)playAction:(UIButton *)button {
    [self.detailVideoPlayView destoryVideoPlayer];
     
    self.detailVideoPlayView = [[KKAVPlayerView alloc]initWithTitle:self.heardItem.video_title
                                                    playCount:STRING_FROM_INTAGER(self.heardItem.play_volume)
                                                     coverUrl:self.heardItem.video_thumb
                                                      videoId:self.heardItem.video_url
                                                    smallType:KKSamllVideoTypeOther];
    self.detailVideoPlayView.originalFrame = self.videoContentView.frame;
    self.detailVideoPlayView.originalView = self.videoContentView;
    self.detailVideoPlayView.delegate = self;
    self.detailVideoPlayView.fullScreen = NO ;
    [self.videoContentView addSubview:self.detailVideoPlayView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.view.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT);
}
#pragma mark -- KKAVPlayerViewDelegate
- (void)enterFullScreen{
}

- (void)quitFullScreen{
}

- (void)quitVideoDetailView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.detailVideoPlayView destoryVideoPlayer];
    [self.detailVideoPlayView removeFromSuperview];
    self.detailVideoPlayView = nil ;
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
            [[QYHTools sharedInstance] startDownLoadVedioWithUrl:self.heardItem.video_url];
        }
            break;
        case KKShareTypeCopyLink:{//复制链接
            dispatch_async(dispatch_get_main_queue(), ^{
                UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                NSString *copyStr = [NSString stringWithFormat:@"%@%@%@",self.heardItem.nickname,self.heardItem.video_desc, self.heardItem.video_url];
                pasteboard.string =copyStr;
                NSLog(@"%@",pasteboard.string);
                [WSProgressHUD showSuccessWithStatus:@"复制成功"];
                [[QYHTools sharedInstance] autoDismiss];
            });
        }
            break;
        default:
            break;
    }
}

#pragma mark  -  显示评论视图
- (void)showCommentView{
    CommentsPopView *view = [[CommentsPopView alloc] initWithAwemeId:@""];
    [view show];
//    KKNewsCommentView *view = [[KKNewsCommentView alloc]initWithNewsBaseInfo:@""];
//    view.topSpace = 249+STATUS_BAR_HEIGHT ;
//    view.navContentOffsetY = 0 ;
//    view.navTitleHeight = 44 ;
//    view.contentViewCornerRadius = 10 ;
//    view.cornerEdge = UIRectCornerTopRight|UIRectCornerTopLeft;
//    view.enableHorizonDrag = NO;
//    view.enableFreedomDrag = NO;
//    view.defaultHideAnimateWhenDragFreedom = NO;
//    [[UIApplication sharedApplication].keyWindow addSubview:view];
//    [view mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(Window_W, Window_H));
//    }];
//    [view startShow];
}

#pragma mark -- UITableViewDataSource,UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.relateVideoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [KKRelateVideoCell techHeightForOjb:@""];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil ;
    cell = [tableView dequeueReusableCellWithIdentifier:relateVideoCellReuseable];
    STVideoChannelModl *item =[STVideoChannelModl yy_modelWithDictionary:[self.relateVideoArray safeObjectAtIndex:indexPath.row]];
    [((KKRelateVideoCell *)cell) refreshData:item];
    [(KKRelateVideoCell *)cell setDelegate:self];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    STVideoChannelModl *model = [STVideoChannelModl yy_modelWithDictionary:[self.relateVideoArray safeObjectAtIndex:indexPath.row]];
    [self playRelateVideo:model];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

#pragma mark -- 播放推荐的视频

- (void)playRelateVideo:(STVideoChannelModl *)contentItem{
    [self loadHeadItem:contentItem];
    NSString *videoId = contentItem.video_url;
    NSString *title = contentItem.video_title;
    NSString *playCount = STRING_FROM_INTAGER(contentItem.play_volume);
    NSString *url = contentItem.video_thumb;
    [self.detailVideoPlayView destoryVideoPlayer];
    KKAVPlayerView *view = [[KKAVPlayerView alloc]initWithTitle:title playCount:playCount coverUrl:url videoId:videoId smallType:KKSamllVideoTypeOther];
    self.detailVideoPlayView = view;
    self.detailVideoPlayView.originalFrame = self.videoContentView.frame;
    self.detailVideoPlayView.originalView = self.videoContentView;
    self.detailVideoPlayView.delegate = self;
    self.detailVideoPlayView.fullScreen = NO ;
    self.detailVideoPlayView.canHideStatusBar = YES;
    [self.videoContentView addSubview:self.detailVideoPlayView];
    [self refreshData];
}

#pragma mark -- KKAuthorInfoViewDelegate

- (void)setConcern:(BOOL)isConcern callback:(void (^)(BOOL))callback{
    if(callback){
        callback(YES);
    }
}
- (void)clickedUserHeadWithUserId:(NSString *)userId {
    STChildrenViewController *vc = [STChildrenViewController new];
    vc.title = @"个人主页";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark  -  cellDel
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item {
    if (type == KKBarButtonTypeMore) {
        [[QYHTools sharedInstance] shareVideo];
    }
}
- (void)jumpBtnClicked:(id)item {
    [[QYHTools sharedInstance] shareVideo];
}
- (void)setConcern:(BOOL)isConcern userId:(NSString *)userId callback:(void (^)(BOOL))callback{
    if(callback){
        callback(YES);
    }
    NSLog(@"isConcern:%d,userId:%@",isConcern,userId);
}

- (void)reportUser:(NSString *)userId{
    NSLog(@"userId:%@",userId);
}

#pragma mark -- @property

- (KKAuthorInfoView *)authorView{
    if(!_authorView){
        _authorView = ({
            KKAuthorInfoView *view = [KKAuthorInfoView new];
            view.showDetailLabel = NO ;
            view.delegate = self ;
            view.showBottomSplit = YES ;
            view.backgroundColor = color_viewBG_1A1929;
            view ;
        });
    }
    return _authorView;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = ({
            UITableView *view = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
            view.delegate = self;
            view.dataSource = self ;
            view.backgroundColor = color_viewBG_1A1929;
            [view registerClass:[KKRelateVideoCell class] forCellReuseIdentifier:relateVideoCellReuseable];
            view.separatorStyle = UITableViewCellSeparatorStyleNone;
            @STweakify(self);
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                @STstrongify(self);
                [self.tableView.mj_footer endRefreshing];
            }];
            [footer setTitle:@"正在努力加载" forState:MJRefreshStateIdle];
            [footer setTitle:@"正在努力加载" forState:MJRefreshStateRefreshing];
            [footer setTitle:@"正在努力加载" forState:MJRefreshStatePulling];
            [footer setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
            [view setMj_footer:footer];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            //iOS11 reloadData界面乱跳bug
            view.estimatedRowHeight = 0;
            view.estimatedSectionHeaderHeight = 0;
            view.estimatedSectionFooterHeight = 0;
            if(IOS11_OR_LATER){
                KKAdjustsScrollViewInsets(view);
            }
            view ;
        });
    }
    return _tableView ;
}

- (KKVideoInfoView *)videoInfoView{
    if(!_videoInfoView){
        _videoInfoView = ({
            KKVideoInfoView *view = [KKVideoInfoView new];
            @STweakify(view)
            @STweakify(self);
            [view setChangeViewHeight:^(CGFloat height){
                @STstrongify(view);
                @STstrongify(self);
                view.height = height;
                [self loadHeadItem:self.heardItem];
                [self.tableView reloadData];
            }];
            [view.commentButton addTarget:self action:@selector(showCommentView) forControlEvents:UIControlEventTouchUpInside];
            [view.moreButton addTarget:self action:@selector(shareVideo) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _videoInfoView;
}

- (NSMutableArray *)commentArray {
    if (!_commentArray) {
        _commentArray = [NSMutableArray new];
    }
    return _commentArray;
}

- (NSMutableArray *)relateVideoArray{
    if(!_relateVideoArray){
        _relateVideoArray = [NSMutableArray new];
    }
    return _relateVideoArray;
}
@end
