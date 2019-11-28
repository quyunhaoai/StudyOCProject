//
//  STHeaderPersonView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/12.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STHeaderPersonView.h"

@implementation STHeaderPersonView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self==[super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.headerIconView];
    [self addSubview:self.vipImageView];
    [self addSubview:self.nameStringLabel];
    [self addSubview:self.subNameStringLabel];
    [self addSubview:self.tagView];
    [self addSubview:self.addButton];
//    [self addSubview:self.detailLabel];
    [self addSubview:self.typeLabel];
    [self.headerIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(17);
        make.top.mas_equalTo(self).mas_offset(20);
        make.width.height.mas_equalTo(kWidth(51));
    }];
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView).mas_offset(36);
        make.top.mas_equalTo(self.headerIconView).mas_offset(39);
        make.width.height.mas_equalTo(kWidth(16));
    }];
    [self.nameStringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView.mas_right).mas_offset(kkPaddingNormal);
        make.top.mas_equalTo(self.headerIconView.mas_top).mas_offset(1);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(18);
    }];
    [self.subNameStringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameStringLabel);
        make.top.mas_equalTo(self.nameStringLabel.mas_bottom).mas_offset(kkPaddingSmall);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(240);
    }];
    self.tagView.frame = CGRectMake(17+kWidth(51)+kkPaddingNormal, 20+kkPaddingMin+18+kkPaddingSmall+14+kkPaddingSmall, 240, 20);
    self.tagView.dataSources = @[@"郑州",@"大师",@"美女"];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headerIconView.mas_centerY);
        make.right.mas_equalTo(self).mas_offset(-13);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(22);
    }];
    
    self.nameStringLabel.text = @"王晓丽";
    CGFloat with = STRINGFONT_2_WIDTH(self.nameStringLabel.text, 18, FONT_14);
    [self.nameStringLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(with);
    }];
    self.subNameStringLabel.text = @"我的粉号：958560";
    self.headerIconView.image = IMAGE_NAME(@"userhead");
    //Base style for 直线 222
    UIView *style = [[UIView alloc] initWithFrame:CGRectZero];
    style.layer.borderColor = [[UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:50.0f/255.0f alpha:1.0f] CGColor];
    style.layer.borderWidth = 1;
    style.alpha = 1;
    [self addSubview:style];
    [style mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.top.mas_equalTo(self.headerIconView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(2);
        make.width.mas_equalTo(Window_W-24);
    }];
//    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self);
//        make.top.mas_equalTo(style.mas_bottom);
//        make.bottom.mas_equalTo(self);
//    }];
//    self.detailLabel.textContainer = @"关注我的567   关注我的234   关注我的123";
//    TYTextContainer *container = [[TYTextContainer alloc] init];
//    NSString *text = @"关注我的567   我关注的234   访问我的123";
//    container.text = text;
//    container.textColor = color_text_AFAFB1;
//    container.textAlignment = kCTTextAlignmentCenter;
//    container.font = FONT_10;
//    TYTextStorage *storage = [[TYTextStorage alloc] init];
//    storage.textColor = kWhiteColor;
//    storage.range = [text rangeOfString:@"567"];
//    storage.font = FONT_13;
//    [container addTextStorage:storage];
//    TYTextStorage *storage2 = [[TYTextStorage alloc] init];
//    storage2.textColor = kWhiteColor;
//    storage2.range = [text rangeOfString:@"234"];
//    storage2.font = FONT_13;
//    [container addTextStorage:storage2];
//    TYTextStorage *storage3 = [[TYTextStorage alloc] init];
//    storage3.textColor = kWhiteColor;
//    storage3.range =[text rangeOfString:@"123"];
//    storage3.font = FONT_13;
//    [container addTextStorage:storage3];
    
//    self.detailLabel.textContainer = container;
    [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameStringLabel.mas_right).mas_offset(kkPaddingMin);
        make.centerY.mas_equalTo(self.nameStringLabel);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(11);
    }];
    self.typeLabel.text = @"官方";
}
- (void)setTitleLabArray:(NSArray *)titleLabArray {
    _titleLabArray = titleLabArray;
    
    NSMutableArray *tolAry = [NSMutableArray new];
    for (int i = 0; i <_titleLabArray.count; i ++) {
        TYAttributedLabel *view = [TYAttributedLabel new];
        view.textColor = color_text_AFAFB1;
        view.font = FONT_10;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.numberOfLines = 1;
        view.text = _titleLabArray[i];
        [self addSubview:view];
        [tolAry addObject:view];
    }
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:kWidth(70) tailSpacing:kWidth(70)];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0).mas_offset(-5);
        make.height.equalTo(@20);
    }];
}
#pragma  mark  --  addBtn 懒加载

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel =({
            
            UILabel *view = [UILabel new];
            view.textColor = kWhiteColor;
            view.font = STFont(8);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = color_tipYellow_FECE24	;
            view.textAlignment = NSTextAlignmentCenter;
            view.numberOfLines = 1;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 2;
            view ;
            
            
        });
    }
    return _typeLabel;
}
- (TYAttributedLabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = ({
            
            TYAttributedLabel *view = [TYAttributedLabel new];
//            view.textColor = color_text_AFAFB1;
//            view.font = FONT_10;
//            view.lineBreakMode = NSLineBreakByTruncatingTail;
//            view.backgroundColor = [UIColor clearColor];
//            view.textAlignment = NSTextAlignmentCenter;
//            view.numberOfLines = 1;
            view ;
            
            
        });
    }
    return _detailLabel;
}
- (TagView *)tagView {
    if (!_tagView) {
        _tagView = [TagView new];
    }
    return _tagView;
}
- (UIButton *)addButton {
    
    if (!_addButton) {
        _addButton =({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"关注+" forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_11];
            view.layer.cornerRadius = 2;
            view.layer.masksToBounds = YES;
            view.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:144.0f/255.0f alpha:1.0f] CGColor];
            view.alpha = 1;
            [view setUserInteractionEnabled:YES];
            [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            view ;
            
        });
    }
    return _addButton;
}

- (void)addBtnClick:(UIButton *)button {
    button.selected = !button.isSelected;
    if (button.selected) {
        button.layer.backgroundColor = [[UIColor colorWithRed:58.0f/255.0f green:58.0f/255.0f blue:68.0f/255.0f alpha:1.0f] CGColor];
        [button setTitle:@"已关注" forState:UIControlStateNormal];
    } else {
        button.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:144.0f/255.0f alpha:1.0f] CGColor];
        [button setTitle:@"关注+" forState:UIControlStateNormal];
    }
}

- (UILabel *)nameStringLabel {
    if (!_nameStringLabel) {
        _nameStringLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = [UIColor kkColorWhite];
            view.font = FONT_12;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.numberOfLines = 1;
            view ;
        });
    }
    return _nameStringLabel;
}

- (UILabel *)subNameStringLabel {
    if (!_subNameStringLabel) {
        _subNameStringLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_HEX_RGB(0xAFAFB1);
            view.font = FONT_10;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.numberOfLines = 1;
            view ;
        });
    }
    return _subNameStringLabel;
}

- (UIImageView *)headerIconView {
    if (!_headerIconView) {
        _headerIconView =  ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            ViewBorderRadius(view, 4, 2, [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:209.0f/255.0f alpha:1.0f]);
            view;
        });
    }
    return _headerIconView;
}

- (UIImageView *)vipImageView {
    if (!_vipImageView) {
        _vipImageView =  ({
                   UIImageView *view = [UIImageView new];
                   view.contentMode = UIViewContentModeScaleAspectFill ;
                   view.layer.masksToBounds = YES ;
                   view.userInteractionEnabled = YES ;
                   [view setImage:IMAGE_NAME(@"vip_home_headIcon")];
                   view.hidden = YES;
                   view;
               });
    }
    return _vipImageView;
}


@end
