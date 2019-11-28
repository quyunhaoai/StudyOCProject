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
@property(nonatomic,weak)NSIndexPath *selIndexPath;
@end

@implementation STLookPhotoViewController
- (UIView *)listView {
    return self.view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBlackColor;
    self.dataArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    [self setupUI];
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

#pragma mark -- 刷新数据

- (void)refreshData:(BOOL)header shouldShowTips:(BOOL)showTip{
//    [self.loadingView setHidden:self.dataArray.count];
//    [[KKFetchNewsTool shareInstance]fetchSummaryWithSectionItem:self.sectionItem success:^(KKSummaryDataModel *model) {
//        NSMutableArray *insertArray = [NSMutableArray arrayWithCapacity:0];
//        if(model.contentArray.count){
//            if(header){
//                NSRange range = NSMakeRange(0,[model.contentArray count]);
//                [self.dataArray insertObjects:model.contentArray atIndexes:[NSIndexSet indexSetWithIndexesInRange:range]];
//                if(self.dataArray.count > 30){
//                    NSInteger delCount = self.dataArray.count - 30 ;
//                    for(NSInteger i = 0 ; i < delCount ; i++){
//                        [self.dataArray removeLastObject];
//                    }
//                    [CATransaction begin];
//                    [CATransaction setDisableActions:YES];
//                    [self.collectView reloadData];
//                    [CATransaction commit];
//                }else{
//                    for(NSInteger i = 0 ; i < model.contentArray.count ; i++){
//                        [insertArray safeAddObject:[NSIndexPath indexPathForRow:i inSection:0]];
//                    }
//                }
//            }else{
//                NSInteger fromIndex = self.dataArray.count;
//                NSInteger lastItemIndex = self.dataArray.count - 1;
//                [self.dataArray addObjectsFromArray:model.contentArray];
//                if(self.dataArray.count > 30){
//                    NSInteger delCount = self.dataArray.count - 30 ;
//                    for(NSInteger i = 0 ; i < delCount ; i++){
//                        [self.dataArray safeRemoveObjectAtIndex:0];
//                        lastItemIndex -- ;
//                    }
//                    [CATransaction begin];
//                    [CATransaction setDisableActions:YES];
//                    [self.collectView reloadData];
//                    [self.collectView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:lastItemIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
//                    [CATransaction commit];
//                }else{
//                    for(NSInteger i = 0; i < model.contentArray.count ; i++){
//                        [insertArray safeAddObject:[NSIndexPath indexPathForRow:(fromIndex + i) inSection:0]];
//                    }
//                }
//            }
//        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectView.mj_footer endRefreshing];
            [self.collectView.mj_header endRefreshing];
            
//            if(insertArray.count){
//                [CATransaction begin];
//                [CATransaction setDisableActions:YES];
//                [self.collectView insertItemsAtIndexPaths:insertArray];
//                [CATransaction commit];
//            }
            
//            [self.loadingView setHidden:YES];
//            [self.noDataView setHidden:self.dataArray.count];
            
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
//    } failure:^(NSError *error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.refreshTipLabel setText:@"网络不给力"];
//            [self.collectView.mj_footer endRefreshing];
//            [self.collectView.mj_header endRefreshing];
//            [self.loadingView setHidden:YES];
//            [self.noDataView setHidden:self.dataArray.count];
//            [self.collectView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_equalTo(self).mas_offset(self.refreshTipLabel.height);
//            }];
//            [UIView animateWithDuration:0.3 animations:^{
//                [self layoutIfNeeded];
//            }];
//
//            [self performSelector:@selector(showRefreshTipParam:) withObject:@[@(NO),@(YES)] afterDelay:2.0];
//        });
//    }];
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
            view.backgroundColor = color_tipYellow_FECE24;
            view.textColor = KKColor(255, 255, 255, 1);
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
