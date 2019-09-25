//
//  STRecommendTopTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STRecommendTopTableViewCell.h"

@implementation STRecommendTopCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    [self.contentView addSubview:self.coverImage];
    [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kWidth(144), kWidth(81)));
    }];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImage.mas_left);
        make.top.mas_equalTo(self.coverImage.mas_bottom).offset(6);
        make.width.mas_equalTo(self.coverImage.mas_width);
        make.height.mas_equalTo(33);
    }];
    self.nameLab.numberOfLines = 2;
}

@end

@interface STRecommendTopTableViewCell()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView; // collectionView 视图

@end

@implementation STRecommendTopTableViewCell
static NSString *identifier = @"stRecommendVideoCollectionViewcell";
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self awakeFromNib];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    layout.itemSize = CGSizeMake(kWidth(144), kWidth(120));
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, kWidth(120)) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.tag = 1;
    [collectionView registerClass:[STRecommendTopCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
    [self.contentView addSubview:collectionView];
}
#pragma mark - model
//- (void)setDataArray:(NSArray *)dataArray {
//    _dataArray = dataArray;
//    [self.collectionView reloadData];
//}
#pragma  mark - UICollectionViewDelegate/DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    STRecommendTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.coverImage.image = IMAGE_NAME(STSystemDefaultImageName);
    cell.nameLab.text = @"光阴似箭";
//    if (indexPath.row < self.dataArray.count) {
//        cell.model = (YHWatchingHistoryModel *)self.dataArray[indexPath.row];
//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didSelectWithView:andCommonCell:)]) {
        [self.delegate didSelectWithView:collectionView andCommonCell:indexPath];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
