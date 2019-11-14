//
//  STBaseCollectionViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseCollectionViewCell.h"

@implementation STBaseCollectionViewCell
//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setupUI];
//    }
//    return self;
//}
//
//- (void) setupUI {
//    [self.contentView addSubview:self.coverImage];
//    [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(kWidth(144), kWidth(81)));
//    }];
//    [self.contentView addSubview:self.nameLab];
//    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.coverImage.mas_left);
//        make.top.mas_equalTo(self.coverImage.mas_bottom).offset(6);
//        make.width.mas_equalTo(self.coverImage.mas_width);
//        make.height.mas_equalTo(13);
//    }];
//}
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textColor = COLOR_666666;
        _nameLab.font = FONT_13;
        _nameLab.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLab;
}

- (UIImageView *)coverImage {
    if (!_coverImage) {
        _coverImage = [[UIImageView alloc] init];
        _coverImage.contentMode = UIViewContentModeScaleAspectFill;
        _coverImage.clipsToBounds = YES;
        _coverImage.userInteractionEnabled = YES;
    }
    return _coverImage;
}
@end
