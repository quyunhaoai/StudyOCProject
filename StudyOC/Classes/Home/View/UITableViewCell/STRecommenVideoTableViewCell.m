//
//  STRecommenVideoTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STRecommenVideoTableViewCell.h"
#import "TagView.h"
#import "STHeaderIconListView.h"

@interface STRecommenVideoTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) TagView *tagView; // tag 视图
//@property (strong, nonatomic) STHeaderIconListView *headerView; //  视图
@property (strong, nonatomic) UICollectionView *collectionView; //  视图
@property(nonatomic,strong)CAGradientLayer *gradientLayer;


@end
@implementation STRecommenVideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.headerIconView];
    [self.bgView addSubview:self.nameStringLabel];
    [self.bgView addSubview:self.subNameStringLabel];
    [self.bgView addSubview:self.stateLabel];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.coverView];
    [self.bgView addSubview:self.descLabel];
    [self.bgView addSubview:self.rightBtn];
    [self.bgView addSubview:self.commentLabel];
    [self.bgView addSubview:self.splitView];
    [self.coverView addSubview:self.tagView];
    [self.coverView addSubview:self.videoTimeLabel];
//    [self.coverView addSubview:self.headerView];
    [self addViews];
    [self.coverView.layer insertSublayer:self.gradientLayer below:self.tagView.layer];
    self.gradientLayer.frame = CGRectMake(0, Window_W*0.28, Window_W-space-space, Window_W*0.28);
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).mas_offset(0);
    }];
    [self.headerIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.bgView).mas_offset(space);
        make.size.mas_equalTo(CGSizeMake(37, 37));
    }];
    [self.nameStringLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView.mas_right).mas_offset(space);
        make.top.mas_equalTo(self.headerIconView);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(200);
    }];
    [self.subNameStringLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameStringLabel);
        make.top.mas_equalTo(self.nameStringLabel.mas_bottom).mas_offset(smaillSpace);
        make.height.mas_equalTo(self.nameStringLabel);
        make.width.mas_equalTo(200);
    }];
    [self.stateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-space);
        make.centerY.mas_equalTo(self.headerIconView);
        make.size.mas_equalTo(CGSizeMake(37, 20));
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView);
        make.top.mas_equalTo(self.headerIconView.mas_bottom).mas_offset(smaillSpace);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(Window_W - space*2);
    }];
    [self.coverView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(smaillSpace);
        make.height.mas_equalTo(Window_W*0.56);
        make.width.mas_equalTo(Window_W - space*2);
    }];
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView);
        make.top.mas_equalTo(self.coverView.mas_bottom).mas_offset(smaillSpace);
        make.height.mas_equalTo(self.nameStringLabel);
        make.width.mas_equalTo(200);
    }];
    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-space);
        make.centerY.mas_equalTo(self.descLabel);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.commentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.descLabel);
        make.right.mas_equalTo(self.rightBtn.mas_left).mas_offset(-smaillSpace);
        make.height.mas_equalTo(self.descLabel);
        make.width.mas_equalTo(80);
    }];
    [self.splitView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.bgView);
        make.width.mas_equalTo(self.bgView).mas_offset(0);
        make.height.mas_equalTo(1.0);
    }];
    [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.coverView);
        make.height.mas_equalTo(Window_W*0.56-50);
        make.width.mas_equalTo(160);
    }];
    [self.videoTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.coverView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
//    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.right.mas_equalTo(self.coverView);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(50);
//    }];
    XYWeakSelf;
    [self.headerIconView addTapGestureWithBlock:^(UIView *gestureView) {
        if ([weakSelf.delegate respondsToSelector:@selector(jumpToUserPage:)]) {
            [weakSelf.delegate jumpToUserPage:@""];
        }
    }];
}

- (void)refreshData:(id)data {

}

#pragma mark  -  Get
#pragma  mark  --  tagview 懒加载
- (TagView *)tagView {
    if (!_tagView) {
        _tagView = ({
            TagView *view = [TagView new];
            
            view;
        });
    }
    return _tagView;
}

- (CAGradientLayer *)gradientLayer{
    if(!_gradientLayer){
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.01].CGColor, (__bridge id)[[UIColor blackColor] colorWithAlphaComponent:0.99].CGColor];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    }
    return _gradientLayer;
}

#pragma  mark  --  headIcon 懒加载
//- (STHeaderIconListView *)headerView {
//
//    if (!_headerView) {
//        _headerView = [STHeaderIconListView new];
//    }
//    return _headerView;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(kWidth(30), kWidth(30));
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = -8;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[STHeaderIconCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
    [self.bgView addSubview:collectionView];
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.coverView);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
}
#pragma  mark - UICollectionViewDelegate/DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    STHeaderIconCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.coverImage setCornerImageWithURL:[NSURL URLWithString:@""] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
    //    cell.nameLab.text = @"娜扎";
    //    if (indexPath.row < self.dataArray.count) {
    //        cell.model = (YHWatchingHistoryModel *)self.dataArray[indexPath.row];
    //    }
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//        if ([self.delegate respondsToSelector:@selector(didSelectCommonCell:)]) {
//            [self.delegate didSelectCommonCell:indexPath];
//        }
//}
@end
