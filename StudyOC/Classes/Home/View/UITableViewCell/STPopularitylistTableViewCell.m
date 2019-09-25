//
//  STPopularitylistTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STPopularitylistTableViewCell.h"
@implementation STPersonCollectionViewCell

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
        make.size.mas_equalTo(CGSizeMake(kWidth(50), kWidth(50)));
    }];
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverImage.mas_left);
        make.top.mas_equalTo(self.coverImage.mas_bottom).offset(6);
        make.width.mas_equalTo(self.coverImage.mas_width);
        make.height.mas_equalTo(33);
    }];
    self.nameLab.numberOfLines = 1;
    self.nameLab.textAlignment = NSTextAlignmentCenter;
}

@end

@interface STPopularitylistTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

static NSString *identifier = @"STPopularityColletionViewCell";

@implementation STPopularitylistTableViewCell

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
    layout.itemSize = CGSizeMake(kWidth(70), kWidth(100));
    layout.minimumInteritemSpacing = 3;
    layout.minimumLineSpacing = 3;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, kWidth(100)) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.tag = 2;
    [collectionView registerClass:[STPersonCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView = collectionView;
    [self.contentView addSubview:collectionView];
    [self.contentView addSubview:self.splitView];
    [self.splitView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-1.0);
        make.width.mas_equalTo(self.contentView).mas_offset(0);
        make.height.mas_equalTo(1.0);
    }];
    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(kkMarginTiny);
        make.top.mas_equalTo(collectionView.mas_bottom).mas_offset(0);
        make.width.mas_equalTo(self.contentView).mas_offset(0);
        make.height.mas_equalTo(19.0);
    }];
    self.descLabel.text = @"每周人气王推荐";
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
    
    STPersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [cell.coverImage setCornerImageWithURL:[NSURL URLWithString:@""] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
    cell.nameLab.text = @"娜扎";
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
