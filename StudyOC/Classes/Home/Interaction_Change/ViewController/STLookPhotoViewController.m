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
static NSString *cellReuseIdentifier = @"cellReuseIdentifier";
static CGFloat space = 0.5 ;
@interface STLookPhotoViewController ()<JXCategoryListContentViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,KKXiaoShiPingPlayViewDelegate>
@property(nonatomic)UILabel *refreshTipLabel;
@property(nonatomic)UICollectionView *collectView;
//@property(nonatomic)KKLoadingView *loadingView ;
@property(nonatomic,weak)NSIndexPath *selIndexPath;
@end

@implementation STLookPhotoViewController
- (UIView *)listView {
    return self.view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    [self setupUI];
}
#pragma mark -- 设置UI

- (void)setupUI{
    [self.view addSubview:self.collectView];
    [self.collectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self.view);
    }];
    self.view.backgroundColor = color_viewBG_1A1929;
}

#pragma mark -- 刷新数据

- (void)refreshData:(BOOL)header shouldShowTips:(BOOL)showTip{

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
        make.top.mas_equalTo(self).mas_offset(isShow ? self.refreshTipLabel.height : 0);
    }];
    if(animate){
        [UIView animateWithDuration:0.3 animations:^{
//            [self layoutIfNeeded];
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
//    KKSummaryContent *item = [self.dataArray safeObjectAtIndex:indexPath.row];
    KKXiaoShiPingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
//    [cell refreshWith:item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat wdith = (Window_W - space) / 2.0 ;
    CGFloat height = wdith * 1.52 ;
    return CGSizeMake(wdith, height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selIndexPath = indexPath ;
//    KKSummaryContent *item = [self.dataArray safeObjectAtIndex:indexPath.row];
    KKXiaoShiPingCell *cell = (KKXiaoShiPingCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentBgView.alpha = 0 ;
    
    [self showPlayViewWithItem:@"" oriRect:cell.frame oriImage:cell.corverView.image];
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
//    KKNewsBaseInfo *newsInfo = [KKNewsBaseInfo new];
//    newsInfo.title = item.title;
//    newsInfo.groupId = item.smallVideo.group_id;
//    newsInfo.itemId = item.smallVideo.item_id;
//    newsInfo.commentCount = item.smallVideo.action.comment_count;
//    newsInfo.userInfo = item.smallVideo.user.info;
//    newsInfo.catagory = @"hotsoon_video";
    
    KKXiaoShiPingPlayView *browser = [[KKXiaoShiPingPlayView alloc]initWithNewsBaseInfo:@"" videoArray:self.dataArray selIndex:self.selIndexPath.row];
    browser.delegate = self ;
    browser.topSpace = 0 ;
    browser.frame = CGRectMake(0, 0, Window_W, Window_H);
    browser.defaultHideAnimateWhenDragFreedom = NO ;
    browser.oriView = self.collectView;
    browser.oriFrame = oriRect;
    browser.oriImage = oriImage;
    
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
            [view registerClass:[KKXiaoShiPingCell class] forCellWithReuseIdentifier:cellReuseIdentifier];
            XYWeakSelf;
            view.mj_header = [CustomGifHeader headerWithRefreshingBlock:^{
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
            view.backgroundColor = KKColor(214, 232, 248, 1.0);
            view.textColor = KKColor(0, 135, 211, 1);
            view.font = [UIFont systemFontOfSize:15];
            view.textAlignment = NSTextAlignmentCenter;
            view ;
        });
    }
    return _refreshTipLabel;
}

//- (KKLoadingView *)loadingView{
//    if(!_loadingView){
//        _loadingView = ({
//            KKLoadingView *view = [KKLoadingView new];
//            view.hidden = NO ;
//            view.backgroundColor = [UIColor whiteColor];
//            view ;
//        });
//    }
//    return _loadingView;
//}

@end
