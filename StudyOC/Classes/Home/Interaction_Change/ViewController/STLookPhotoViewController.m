//
//  STLookPhotoViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/8.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLookPhotoViewController.h"
#import "KKXiaoShiPingCell.h"
#import "KKXiaoShiPingPlayView.h"
#import "SmallVideoPlayViewController.h"
#import "SmallVideoModel.h"
static NSString *cellReuseIdentifier = @"cellReuseIdentifier";
static CGFloat space = 0.5 ;
@interface STLookPhotoViewController ()<JXCategoryListContentViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,KKXiaoShiPingPlayViewDelegate>
@property(nonatomic)UILabel *refreshTipLabel;
@property(nonatomic)UICollectionView *collectView;
@property(nonatomic,weak)NSIndexPath *selIndexPath;
@end

@implementation STLookPhotoViewController

- (UIView *)listView {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlackColor;
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self setupUI];
    [self loadData];
}
#pragma mark -- 设置UI

- (void)setupUI{
    [self.view addSubview:self.refreshTipLabel];
    [self.refreshTipLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    [self.view addSubview:self.collectView];
    [self.collectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self.view);
    }];
    self.view.backgroundColor = color_viewBG_1A1929;
}
//刷新数据
- (void)loadData {
    [self getResource];
    [self.collectView reloadData];
}
#pragma mark -- 刷新数据

- (void)refreshData:(BOOL)header shouldShowTips:(BOOL)showTip{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectView.mj_footer endRefreshing];
        [self.collectView.mj_header endRefreshing];
        
        NSInteger total = [self.dataArray count];
        if(total > 0){
            self.refreshTipLabel.text = @"为你推荐了10条视频";
        }else{
            self.refreshTipLabel.text = @"没有更多更新";
        }
        if(showTip){
            [self.collectView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.view).mas_offset(self.refreshTipLabel.height);
            }];
            [UIView animateWithDuration:0.3 animations:^{
                [self.view layoutIfNeeded];
            }];
            
            [self performSelector:@selector(showRefreshTipParam:) withObject:@[@(NO),@(YES)] afterDelay:2.0];
        }
    });
}

//开始下拉刷新
- (void)beginPullDownUpdate{
    if(![self.collectView.mj_header isRefreshing]){
        [self.collectView.mj_header beginRefreshing];
    }
}

- (void)showRefreshTipParam:(NSArray *)array{
    [self showRefreshTip:[[array safeObjectAtIndex:0]boolValue] animate:[[array safeObjectAtIndex:1]boolValue]];
}

- (void)showRefreshTip:(BOOL)isShow animate:(BOOL)animate{
    [self.collectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(isShow ? self.refreshTipLabel.height : 0);
    }];
    if(animate){
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark -- UICollectionViewDelegate,UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KKXiaoShiPingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat wdith = (Window_W - space) / 2.0 ;
    CGFloat height = wdith * 1.52 ;
    return CGSizeMake(wdith, height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SmallVideoPlayViewController *vc = [SmallVideoPlayViewController new];
    vc.showBackBtn = YES;
    vc.currentPlayIndex = indexPath.row;
    vc.modelArray = self.dataArray;
    [self.navigationController pushViewController:vc animated:YES];
//    self.selIndexPath = indexPath ;
//    KKXiaoShiPingCell *cell = (KKXiaoShiPingCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.contentBgView.alpha = 0 ;
//    [self showPlayViewWithItem:@"" oriRect:cell.frame oriImage:cell.corverView.image];
}

//设置水平间距 (同一行的cell的左右间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return space;
}

//垂直间距 (同一列cell上下间距)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return space;
}

#pragma mark -- 显示视频播放视图

- (void)showPlayViewWithItem:(id)item oriRect:(CGRect)oriRect oriImage:(UIImage *)oriImage{
    KKXiaoShiPingPlayView *browser = [[KKXiaoShiPingPlayView alloc]initWithNewsBaseInfo:@"" videoArray:self.dataArray selIndex:0];
    browser.delegate = self ;
    browser.topSpace = 0 ;
    browser.frame = CGRectMake(0, 0, Window_W, Window_H);
    browser.defaultHideAnimateWhenDragFreedom = NO ;
    browser.oriView = self.collectView;
    browser.oriFrame = oriRect;
    browser.oriImage = oriImage;
    @STweakify(browser);
    [browser setHideImageAnimate:^(UIImage *image,CGRect fromFrame,CGRect toFrame){
        UIImageView *imageView = [YYAnimatedImageView new];
        imageView.image = image;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = fromFrame ;
        imageView.layer.masksToBounds = YES ;
        [self.collectView addSubview:imageView];
        [UIView animateWithDuration:0.3 animations:^{
            imageView.frame = toFrame;
        }completion:^(BOOL finished) {
            [imageView removeFromSuperview];
            @STstrongify(browser);
            [browser removeFromSuperview];
            for(KKXiaoShiPingCell *cell in self.collectView.visibleCells){
                cell.contentBgView.alpha = 1.0 ;
            }
        }];
    }];
    
    [browser setAlphaViewIfNeed:^(BOOL alphaView){
        KKXiaoShiPingCell *cell = (KKXiaoShiPingCell *)[self.collectView cellForItemAtIndexPath:self.selIndexPath];
        cell.contentBgView.alpha = !alphaView ;
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:browser];
    [browser viewWillAppear];
}

#pragma mark -- KKXiaoShiPingPlayViewDelegate

- (void)scrollToIndex:(NSInteger)index callBack:(void (^)(CGRect, UIImage *))callback{
    self.selIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectView selectItemAtIndexPath:self.selIndexPath animated:NO scrollPosition:(UICollectionViewScrollPositionTop)];
    
    for(KKXiaoShiPingCell *cell in self.collectView.visibleCells){
        cell.contentBgView.alpha = 1.0 ;
    }
    
    KKXiaoShiPingCell *cell = (KKXiaoShiPingCell *)[self.collectView cellForItemAtIndexPath:self.selIndexPath];
    if(callback){
        callback(cell.frame,cell.corverView.image);
    }
}

#pragma mark -- @property

- (UICollectionView *)collectView{
    if(!_collectView){
        _collectView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
            view.delegate= self;
            view.dataSource= self;
            view.backgroundColor = color_viewBG_1A1929;
            view.indicatorStyle = UIScrollViewIndicatorStyleWhite;
            view.contentInset = UIEdgeInsetsMake(8, 0, 0, 0);
            [view registerClass:[KKXiaoShiPingCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
            XYWeakSelf;
            view.mj_header = [STCustomHeader headerWithRefreshingBlock:^{
                [weakSelf refreshData:YES shouldShowTips:YES];
            }];
            
            MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                [weakSelf refreshData:NO shouldShowTips:NO];
            }];
            [footer setTitle:@"正在努力加载" forState:MJRefreshStateIdle];
            [footer setTitle:@"正在努力加载" forState:MJRefreshStateRefreshing];
            [footer setTitle:@"正在努力加载" forState:MJRefreshStatePulling];
            [footer setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
            [view setMj_footer:footer];
            
            if (IOS11_OR_LATER) {
                KKAdjustsScrollViewInsets(view);
            }
            
            view;
        });
    }
    return _collectView;
}

- (UILabel *)refreshTipLabel{
    if(!_refreshTipLabel){
        _refreshTipLabel = ({
            UILabel *view = [UILabel new];
            view.backgroundColor = color_tipYellow_FECE24;
            view.textColor = KKColor(255, 255, 255, 1);
            view.font = [UIFont systemFontOfSize:15];
            view.textAlignment = NSTextAlignmentCenter;
            view ;
        });
    }
    return _refreshTipLabel;
}
- (void)getResource {
    SmallVideoModel *model1 = [[SmallVideoModel alloc] init];
    model1.rid = 1;
    model1.name = @"model1";
    model1.comment_num = 12;
    model1.score = 11;
    model1.artist = @"作者1";
    model1.head_url = @"http://cdnuserprofilebd.shoujiduoduo.com/head_pic/46/user_head_30881645_20190423071746.jpg";
    model1.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/551/76097551.mp4";
    model1.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/551/76097551.jpg";
    model1.aspect = 1.778;
    
    SmallVideoModel *model2 = [[SmallVideoModel alloc] init];
    model2.rid = 2;
    model2.name = @"model2";
    model2.comment_num = 12;
    model2.score = 21;
    model2.artist = @"作者2";
    model2.head_url = @"http://cdnuserprofilebd.shoujiduoduo.com/head_pic/46/user_head_30881645_20190423071746.jpg";
    model2.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/479/76097479.mp4";
    model2.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/479/76097479.jpg";
    model2.aspect = 1.778;
    
    SmallVideoModel *model3 = [[SmallVideoModel alloc] init];
    model3.rid = 3;
    model3.name = @"model1";
    model3.comment_num = 12;
    model3.score = 31;
    model3.artist = @"作者3";
    model3.head_url = @"http://cdnuserprofilebd.shoujiduoduo.com/head_pic/31/user_head_34964288_20190212001831.jpg";
    model3.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/970/75779970.mp4";
    model3.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/970/75779970.jpg";
    model3.aspect = 1.778;
    
    SmallVideoModel *model4 = [[SmallVideoModel alloc] init];
    model4.rid = 4;
    model4.name = @"model4";
    model4.comment_num = 12;
    model4.score = 41;
    model4.artist = @"作者4";
    model4.head_url = @"http://cdnuserprofilebd.shoujiduoduo.com/head_pic/22/user_head_27430048_20190525064122.jpg";
    model4.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/204/76097204.mp4";
    model4.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/204/76097204.jpg";
    model4.aspect = 1.250;
    
    SmallVideoModel *model5 = [[SmallVideoModel alloc] init];
    model5.rid = 5;
    model5.name = @"model1";
    model5.comment_num = 12;
    model5.score = 51;
    model5.artist = @"作者5";
    model5.head_url = @"http://cdnuserprofilebd.shoujiduoduo.com/head_pic/13/user_head_15486360_20190426173413.jpg";
    model5.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/022/76097022.mp4";
    model5.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/022/76097022.jpg";
    model5.aspect = 1.799;
    
    SmallVideoModel *model6 = [[SmallVideoModel alloc] init];
    model6.rid = 6;
    model6.name = @"model6";
    model6.comment_num = 12;
    model6.score = 61;
    model6.artist = @"作者6";
    model6.head_url = @"http://cdnuserprofilebd.shoujiduoduo.com/head_pic/55/user_head_5925183_20190528092255.jpg";
    model6.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/550/76097550.mp4";
    model6.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/550/76097550.jpg";
    model6.aspect = 0.567;
    
    SmallVideoModel *model7 = [[SmallVideoModel alloc] init];
    model7.rid = 7;
    model7.name = @"model1";
    model7.comment_num = 12;
    model7.score = 71;
    model7.artist = @"作者7";
    model7.head_url = @"http://cdnuserprofilebd.shoujiduoduo.com/head_pic/43/user_head_123737_20190424101443.jpg";
    model7.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/488/75779488.mp4";
    model7.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/488/75779488.jpg";
    model7.aspect = 0.562;
    
    SmallVideoModel *model8 = [[SmallVideoModel alloc] init];
    model8.rid = 8;
    model8.name = @"model1";
    model8.comment_num = 12;
    model8.score = 81;
    model8.artist = @"作者8";
    model8.head_url = @"http://cdnuserprofilebd.shoujiduoduo.com/head_pic/47/user_head_20761695_20190526224947.jpg";
    model8.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/809/76096809.mp4";
    model8.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/809/76096809.jpg";
    model8.aspect = 0.562;
    
    SmallVideoModel *model9 = [[SmallVideoModel alloc] init];
    model9.rid = 9;
    model9.name = @"model9";
    model9.comment_num = 12;
    model9.score = 91;
    model9.artist = @"作者9";
    model9.head_url = @"http://thirdqq.qlogo.cn/g?b=oidb&amp;k=IXYXYnjFTRGWV18ibkgC6Kw&amp;s=100";
    model9.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/603/76096603.mp4";
    model9.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/603/76096603.jpg";
    model9.aspect = 1.000;
    
    SmallVideoModel *model10 = [[SmallVideoModel alloc] init];
    model10.rid = 10;
    model10.name = @"model1";
    model10.comment_num = 12;
    model10.score = 101;
    model10.artist = @"作者10";
    model10.head_url = @"http://thirdqq.qlogo.cn/g?b=oidb&amp;k=lzQZzzcCgg8j4XvcyPBGOA&amp;s=100";
    model10.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/059/75778059.mp4";
    model10.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/059/75778059.jpg";
    model10.aspect = 1.778;
    
    SmallVideoModel *model11 = [[SmallVideoModel alloc] init];
    model11.rid = 11;
    model11.name = @"model11";
    model11.comment_num = 12;
    model11.score = 111;
    model11.artist = @"作者11";
    model11.head_url = @"http://cdnuserprofilebd.shoujiduoduo.com/head_pic/34/user_head_31365520_20190516093434.jpg";
    model11.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/037/76096037.mp4";
    model11.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/037/76096037.jpg";
    model11.aspect = 1.778;
    
    SmallVideoModel *model12 = [[SmallVideoModel alloc] init];
    model12.rid = 12;
    model12.name = @"model12";
    model12.comment_num = 12;
    model12.score = 121;
    model12.artist = @"作者12";
    model12.head_url = @"http://cdnuserprofilebd.shoujiduoduo.com/head_pic/34/user_head_31365520_20190516093434.jpg";
    model12.video_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/video/029/76096029.mp4";
    model12.cover_url = @"http://cdnringbd.shoujiduoduo.com/ringres/userv1/cover/029/76096029.jpg";
    model12.aspect = 1.778;
    [self.dataArray addObjectsFromArray:@[model1,model2,model3,model4,model5,model6,model7,model8,model9,model10,model11,model12]];
}
@end
