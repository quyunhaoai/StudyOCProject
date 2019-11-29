//
//  KKShareView.m
//  KKShareView
//
//  Created by finger on 2017/8/16.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKShareView.h"
#import "Masonry.h"
#import "KKShareItem.h"
#import "STHeaderImageFriendCollectionViewCell.h"
#define collectionHeight 110
static NSString *cellReuseIdentifier = @"STHeaderImageFriendCollectionViewCell";
@interface KKShareView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIButton *bgView;
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)UIScrollView *shareScrollView1;
@property(nonatomic,strong)UIView *splitLine1;
@property(nonatomic,strong)UIScrollView *shareScrollView2;
@property(nonatomic,strong)UIView *splitLine2;
@property(nonatomic,strong)UIButton *cancelBtn;

@property(nonatomic,assign)CGFloat scrollViewHeight;
@property(nonatomic,assign)CGFloat cancelBtnHeight;
@property(nonatomic,assign)CGFloat contentViewHeight;
@property(nonatomic,assign)CGSize shareBtnSize;
@property(nonatomic,assign)CGFloat shareBtnSpace;
@property (strong, nonatomic) UICollectionView *collectionView; //  视图

@end

@implementation KKShareView

- (id)init{
    self = [super init];
    if(self){
        self.scrollViewHeight = 100;
        self.cancelBtnHeight = 50+HOME_INDICATOR_HEIGHT ;
        self.contentViewHeight = 2 * self.scrollViewHeight + self.cancelBtnHeight + 2 +collectionHeight+60;
        self.shareBtnSize = CGSizeMake(60, 80);
        self.shareBtnSpace = 20 ;
        [self setupUI];
    }
    return self ;
}

#pragma mark -- 设置UI

- (void)setupUI{
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.splitLine1];
    [self.contentView addSubview:self.shareScrollView1];
    [self.contentView addSubview:self.splitLine2];
    [self.contentView addSubview:self.shareScrollView2];
    [self.contentView addSubview:self.cancelBtn];
    [self.contentView addSubview:self.collectionView];
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    self.contentView.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width, self.contentViewHeight);
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(30);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(collectionHeight);
    }];
    [self.shareScrollView1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(30);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.scrollViewHeight);
    }];
    
    [self.splitLine1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shareScrollView1.mas_bottom);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.8);
    }];
    
    [self.shareScrollView2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.splitLine1.mas_bottom).mas_offset(0);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.scrollViewHeight);
    }];
    
    [self.splitLine2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shareScrollView2.mas_bottom);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.8);
    }];
    
    [self.cancelBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.splitLine2.mas_bottom);
        make.width.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.cancelBtnHeight);
    }];
    [self adjustCornerRadius];
}

- (void)adjustCornerRadius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, Window_W, self.contentViewHeight) byRoundingCorners: UIRectCornerTopRight|UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];// UIRectCornerTopRight|UIRectCornerTopLeft;
    maskLayer.frame = CGRectMake(0, 0, Window_W, self.contentViewHeight);
    maskLayer.path = maskPath.CGPath;
    self.contentView.layer.mask = maskLayer;
    
    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, Window_W, 20)];
    [self.contentView addSubview:title1];
    title1.text = @"私信给";
    title1.font = FONT_14;
    title1.textColor = color_text_AFAFB1;
    title1.textAlignment = NSTextAlignmentCenter;
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 30+collectionHeight+10, Window_W, 20)];
    [self.contentView addSubview:title2];
    title2.text = @"分享到";
    title2.font = FONT_14;
    title2.textColor = color_text_AFAFB1;
    title2.textAlignment = NSTextAlignmentCenter;
}
#pragma mark -- 加载分享平台

- (void)setShareInfos:(NSArray<NSArray<KKShareItem *> *> *)shareInfos{
    NSInteger index = 0 ;
    for(NSArray *array in shareInfos){
        NSInteger subIndex = 0 ;
        for(KKShareItem *item in array){
            UIButton *btn = [self createShareBtnWithItem:item];
            if(index == 0){
                [self.shareScrollView1 addSubview:btn];
                [btn setFrame:CGRectMake(subIndex * (self.shareBtnSize.width + self.shareBtnSpace) + self.shareBtnSpace, (self.scrollViewHeight - self.shareBtnSize.height) / 2 , self.shareBtnSize.width, self.shareBtnSize.height)];
            }else{
                [self.shareScrollView2 addSubview:btn];
                [btn setFrame:CGRectMake(subIndex * (self.shareBtnSize.width + self.shareBtnSpace) + self.shareBtnSpace, (self.scrollViewHeight - self.shareBtnSize.height) / 2, self.shareBtnSize.width, self.shareBtnSize.height)];
            }
            [self setButtonContentCenter:btn];
            
            subIndex ++ ;
        }
        if (index == 0) {
            [self.shareScrollView1 setContentSize:CGSizeMake(array.count * (self.shareBtnSize.width + self.shareBtnSpace) + self.shareBtnSpace, self.scrollViewHeight)];
        } else {
            [self.shareScrollView2 setContentSize:CGSizeMake(array.count * (self.shareBtnSize.width + self.shareBtnSpace) + self.shareBtnSpace, self.scrollViewHeight)];
        }
        index ++ ;
    }
}

- (UIButton *)createShareBtnWithItem:(KKShareItem *)item{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:item.title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:item.shareIconName] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [btn setTitleColor:color_textBg_C7C7D1 forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTag:item.shareType];
    [btn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn ;
}

-(void)setButtonContentCenter:(UIButton *) btn{
    CGSize imgViewSize,titleSize,btnSize;
    UIEdgeInsets imageViewEdge,titleEdge;
    CGFloat heightSpace = 10.0f;
    
    //设置按钮内边距
    imgViewSize = btn.imageView.bounds.size;
    titleSize = btn.titleLabel.bounds.size;
    btnSize = btn.bounds.size;
    
    imageViewEdge = UIEdgeInsetsMake(heightSpace,4.0, btnSize.height -imgViewSize.height - heightSpace, - titleSize.width);
    [btn setImageEdgeInsets:imageViewEdge];
    
    titleEdge = UIEdgeInsetsMake(imgViewSize.height +heightSpace, - imgViewSize.width, 0.0, 0.0);
    [btn setTitleEdgeInsets:titleEdge];
}

- (void)shareBtnClicked:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if(self.delegate && [self.delegate respondsToSelector:@selector(shareWithType:)]){
        [self.delegate shareWithType:btn.tag];
    }
    [self hideShareView];
}

#pragma mark -- 分享视图的显示隐藏

- (void)showShareView{
    NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:0];
    [self.shareScrollView1.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UIButton class]]){
            [array1 addObject:obj];
        }
    }];
    
    NSMutableArray *array2 = [NSMutableArray arrayWithCapacity:0];
    [self.shareScrollView2.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[UIButton class]]){
            [array2 addObject:obj];
        }
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 1.0 ;
        self.contentView.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.height - self.contentViewHeight, [[UIScreen mainScreen]bounds].size.width, self.contentViewHeight);
    }];
    
    NSTimeInterval delay = 0.0 ;
    for(UIButton *btn in array1){
        CGAffineTransform tran = CGAffineTransformMakeTranslation(0, self.scrollViewHeight);
        btn.transform = tran ;
        delay += 0.08;
        [UIView animateWithDuration:0.7 delay:delay usingSpringWithDamping:0.7 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }
    
    delay = 0.0;
    for(UIButton *btn in array2){
        CGAffineTransform tran = CGAffineTransformMakeTranslation(0, self.scrollViewHeight);
        btn.transform = tran ;
        delay += 0.08;
        [UIView animateWithDuration:0.7 delay:delay usingSpringWithDamping:0.7 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }

}

- (void)hideShareView{
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.alpha = 0.0;
        self.contentView.frame = CGRectMake(0, [[UIScreen mainScreen]bounds].size.height, [[UIScreen mainScreen]bounds].size.width, self.contentViewHeight);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- 广告视图点击

- (void)adViewClicked{
    
}

#pragma mark -- @property

- (UIButton *)bgView{
    if(!_bgView){
        _bgView = [[UIButton alloc]init];
        _bgView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.0];
        _bgView.alpha = 0.0 ;
        [_bgView addTarget:self action:@selector(hideShareView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgView;
}

- (UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor colorWithRed:20.0/255 green:21.0/255 blue:20.0/255 alpha:0.95];
    }
    return _contentView;
}

- (UIView *)splitLine1{
    if(!_splitLine1){
        _splitLine1 = [[UIView alloc]init];
        _splitLine1.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.2];
    }
    return _splitLine1;
}

- (UIScrollView *)shareScrollView1{
    if(!_shareScrollView1){
        _shareScrollView1 = [[UIScrollView alloc]init];
        _shareScrollView1.backgroundColor = [UIColor clearColor];
        _shareScrollView1.showsVerticalScrollIndicator = NO ;
        _shareScrollView1.showsHorizontalScrollIndicator = NO ;
        _shareScrollView1.scrollEnabled = YES ;
        _shareScrollView1.clipsToBounds = YES ;
        _shareScrollView1.bounces = YES ;
    }
    return _shareScrollView1;
}

- (UIView *)splitLine2{
    if(!_splitLine2){
        _splitLine2 = [[UIView alloc]init];
        _splitLine2.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.2];
    }
    return _splitLine2;
}

- (UIScrollView *)shareScrollView2{
    if(!_shareScrollView2){
        _shareScrollView2 = [[UIScrollView alloc]init];
        _shareScrollView2.backgroundColor = [UIColor clearColor];
        _shareScrollView2.showsVerticalScrollIndicator = NO ;
        _shareScrollView2.showsHorizontalScrollIndicator = NO ;
        _shareScrollView2.clipsToBounds = YES ;
        _shareScrollView2.scrollEnabled = YES ;
        _shareScrollView2.bounces = YES ;
    }
    return _shareScrollView2;
}

- (UIButton *)cancelBtn{
    if(!_cancelBtn){
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:color_textBg_C7C7D1 forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(hideShareView) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setBackgroundColor:[UIColor colorWithRed:26.0/255 green:27.0/255 blue:27.0/255 alpha:1.0]];
    }
    return _cancelBtn;
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
            view.delegate= self;
            view.dataSource= self;
            view.backgroundColor = kClearColor;
            view.showsHorizontalScrollIndicator = NO;
            view.showsVerticalScrollIndicator = NO;
            view.contentInset = UIEdgeInsetsMake(0, 10, 0, 0);
            [view registerNib:[STHeaderImageFriendCollectionViewCell loadNib] forCellWithReuseIdentifier:cellReuseIdentifier];
            view;
        });
    }
    return _collectionView;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    }
    return _dataArray;
}
#pragma mark -- UICollectionViewDelegate,UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    STHeaderImageFriendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat wdith = 80 ;
    CGFloat height =  collectionHeight ;
    return CGSizeMake(wdith, height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self hideShareView];
}

//设置水平间距 (同一行的cell的左右间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//垂直间距 (同一列cell上下间距)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}


@end
