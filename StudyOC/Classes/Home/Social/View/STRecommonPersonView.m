//
//  STRecommonPersonView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/12.
//  Copyright © 2019 研学旅行. All rights reserved.
//
#define space 5
static NSString *cellReuseIdentifier = @"STRecommonPersonCollectionViewCell";
#import "STRecommonPersonView.h"
#import "STRecommonPersonCollectionViewCell.h"
@interface STRecommonPersonView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataArray;  //  数组
@property (nonatomic,strong) UIButton *moreButton; //  按钮

@end
@implementation STRecommonPersonView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = color_cellBg_151420;
    [self addSubview:self.nameStringLabel];
    [self addSubview:self.collectView];
    [self addSubview:self.moreButton];
    [self.nameStringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(16);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(45);
    }];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(Window_W);
        make.height.mas_equalTo(155);
        make.bottom.mas_equalTo(self).mas_offset(-14);
    }];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-kkPaddingNormal);
        make.centerY.mas_equalTo(self.nameStringLabel).mas_offset(0);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    self.nameStringLabel.text = @"值得订阅的粉号自媒体";
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray =[NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@""]];
    }
    return _dataArray;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setImage:[UIImage imageNamed:@"more_home"] forState:UIControlStateNormal];
            [view addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _moreButton;
}

- (void)moreBtnClicked:(UIButton *)button {
    
    
}
- (UILabel *)nameStringLabel {
    if (!_nameStringLabel) {
        _nameStringLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = [UIColor kkColorWhite];
            view.font = FONT_14;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.numberOfLines = 1;
            view ;
        });
    }
    return _nameStringLabel;
}

#pragma mark -- @property

- (UICollectionView *)collectView{
    if(!_collectView){
        _collectView = ({
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
            view.delegate= self;
            view.dataSource= self;
            view.backgroundColor = color_viewBG_1A1929;
            view.showsHorizontalScrollIndicator = NO;
            view.showsVerticalScrollIndicator = NO;
            view.contentInset = UIEdgeInsetsMake(0, 16, 0, 0);
            [view registerNib:[STRecommonPersonCollectionViewCell loadNib] forCellWithReuseIdentifier:cellReuseIdentifier];
            view;
        });
    }
    return _collectView;
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
    STRecommonPersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifier forIndexPath:indexPath];
//    [cell refreshWith:item];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat wdith = 103 ;
    CGFloat height =  155 ;
    return CGSizeMake(wdith, height);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    STChildrenViewController *vc = [STChildrenViewController new];
    vc.title = @"个人主页";
    UIViewController *controller = [[QYHTools sharedInstance] getCurrentVC];
    [controller presentViewController:vc animated:YES completion:nil];
}

//设置水平间距 (同一行的cell的左右间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//垂直间距 (同一列cell上下间距)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 13;
}




@end
