//
//  SmallSectionHeader.m
//  Comment布局
//
//  Created by Geb on 16/2/20.
//  Copyright © 2016年 OE. All rights reserved.
//

#import "SmallSectionHeader.h"
#define NAMEFONE 15
#define ADDRESSFONE 17
@implementation SmallSectionHeader
- (instancetype)init {
    if (self = [super init]) {
        [self loadAllViews];
    }
    return self;
}

- (void)loadAllViews {
//    self.backgroundColor = kRedColor;
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.moreBtn];
}

- (void)setSmallCommentModel:(CommentModel *)smallCommentModel {
    
    _smallCommentModel = smallCommentModel;
//    self.nameLabel.frame = CGRectMake(10, 5, [self getContentSizeWithContent:smallCommentModel.name sizeFont:NAMEFONE].width, [self getContentSizeWithContent:smallCommentModel.name sizeFont:NAMEFONE].height);
//    self.nameLabel.text = smallCommentModel.name;
//
//    self.addressLabel.frame = CGRectMake(CGRectGetMinX(self.nameLabel.frame) + 5, CGRectGetMaxY(self.nameLabel.frame) + 5, [self getContentSizeWithContent:smallCommentModel.address sizeFont:ADDRESSFONE].width, [self getContentSizeWithContent:smallCommentModel.address sizeFont:ADDRESSFONE].height);
//    self.addressLabel.text = smallCommentModel.address;
    if (smallCommentModel.first_hasmore) {
        self.moreBtn.hidden = NO;
        self.moreBtn.frame = CGRectMake(15+34+10, 0 + 5, 90, 20);
        [self.moreBtn setTitle:@"显示更多回复" forState:UIControlStateNormal];
        [self.moreBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self.moreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        
    }else {
        self.moreBtn.frame = CGRectZero;
        self.moreBtn.hidden = YES;
    }
    
}
- (CGSize)getContentSizeWithContent:(NSString *)content sizeFont:(CGFloat)font {
    
    return [content boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}
+ (CGFloat)getSmallSectioHeaderHeight :(CommentModel *)model{

    if (model.first_hasmore) {
        return 20 + 10;
    }
    return 0.000f;
}
@end
