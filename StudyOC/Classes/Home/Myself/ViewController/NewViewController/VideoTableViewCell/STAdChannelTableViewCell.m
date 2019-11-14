//
//  STAdChannelTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/18.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STAdChannelTableViewCell.h"
#import "DRNRealTimeBlurView.h"
@interface STAdChannelTableViewCell ()
@property (strong, nonatomic) UIImageView *leftImageView; //  视图
@property (strong, nonatomic) UILabel *leftLabel; //  标签
@property (nonatomic,strong) UIButton *leftTagButton; //  按钮
@property (strong, nonatomic) UILabel *leftDesLabel; //  标签

@property (strong, nonatomic) UIImageView *rightImageView; //  视图
@property (strong, nonatomic) UILabel *rightLabel; //  标签
@property (nonatomic,strong) UIButton *rightTagButton; //  按钮
@property (strong, nonatomic) UILabel *rightDesLabel; //  标签

@property (nonatomic,strong) UIButton *leftMoreButton; //  按钮
@property (nonatomic,strong) UIButton *rightMoreButton; //  按钮

@property (strong, nonatomic) DRNRealTimeBlurView *blurView; // 视图
@end

@implementation STAdChannelTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView {
    static NSString *ID  = @"STAdChannelTableViewCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self awakeFromNib];
    }
    return self;
}

- (void)dealloc{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kClearColor;
    [self.contentView addSubview:self.bgView];
    [self.bgView setBackgroundColor:kClearColor];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = color_cellBg_151420;
    [self.bgView addSubview:leftView];
    
    UIView *rightView = [[UIView alloc] init];
    [self.bgView addSubview:rightView];
    rightView.backgroundColor = color_cellBg_151420;
    [leftView addSubview:self.leftImageView];
    [leftView addSubview:self.leftLabel];
    [leftView addSubview:self.leftTagButton];
    [leftView addSubview:self.leftDesLabel];
    [leftView addSubview:self.leftMoreButton];
    [rightView addSubview:self.rightImageView];
    [rightView addSubview:self.rightMoreButton];
    [rightView addSubview:self.rightLabel];
    [rightView addSubview:self.rightTagButton];
    [rightView addSubview:self.rightDesLabel];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-12);
    }];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(kkPaddingNormal);
        make.top.mas_equalTo(self.bgView);
        make.bottom.mas_equalTo(self.bgView.mas_bottom);
        make.width.mas_equalTo((Window_W-2*kkPaddingNormal-8)/2);
    }];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftView.mas_right).mas_offset(8);
        make.top.bottom.mas_equalTo(leftView);
        make.right.mas_equalTo(self.bgView).mas_offset(-kkPaddingNormal);
    }];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(leftView);
        make.height.mas_equalTo(kHeight(113));
    }];
    [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(rightView);
        make.height.mas_equalTo(kHeight(113));
    }];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_leftImageView.mas_left).mas_offset(kkPaddingNormal);
        make.right.mas_equalTo(_leftImageView.mas_right).mas_offset(-kkPaddingNormal);
        make.top.mas_equalTo(_leftImageView.mas_bottom).mas_offset(kkPaddingSmall);
        make.height.mas_equalTo(30);
    }];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_rightImageView.mas_left).mas_offset(kkPaddingNormal);
        make.right.mas_equalTo(_rightImageView.mas_right).mas_offset(-kkPaddingNormal);
        make.top.mas_equalTo(_rightImageView.mas_bottom).mas_offset(kkPaddingSmall);
        make.height.mas_equalTo(30);
    }];
    
    [_leftTagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftView.mas_left).mas_offset(kkPaddingSmall);
        make.bottom.mas_equalTo(leftView.mas_bottom).mas_offset(-kkPaddingSmall);
        make.size.mas_equalTo(CGSizeMake(26, 15));
    }];
    [_rightTagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rightView.mas_left).mas_offset(kkPaddingSmall);
        make.bottom.mas_equalTo(rightView.mas_bottom).mas_offset(-kkPaddingSmall);
        make.size.mas_equalTo(CGSizeMake(26, 15));
    }];
    
    [_leftDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_leftTagButton);
        make.left.mas_equalTo(_leftTagButton.mas_right).mas_offset(kkPaddingSmall);
        make.right.mas_equalTo(leftView.mas_right).mas_offset(-30);
        make.height.mas_equalTo(17);
    }];
    [_rightDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_rightTagButton);
        make.left.mas_equalTo(_rightTagButton.mas_right).mas_offset(kkPaddingSmall);
        make.right.mas_equalTo(rightView.mas_right).mas_offset(-30);
        make.height.mas_equalTo(17);
    }];
    [_leftMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(leftView).mas_offset(-kkPaddingSmall);
        make.bottom.mas_equalTo(leftView).mas_offset(-kkPaddingSmall);
        make.size.mas_equalTo(CGSizeMake(11, 11));
    }];
    [_rightMoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightView).mas_offset(-kkPaddingSmall);
        make.bottom.mas_equalTo(rightView).mas_offset(-kkPaddingSmall);
        make.size.mas_equalTo(CGSizeMake(11, 11));
    }];
}
- (void)setIsShowWithdram:(BOOL)isShowWithdram {
    _isShowWithdram = isShowWithdram;
    if (_isShowWithdram) {
          _blurView = [[DRNRealTimeBlurView alloc] initWithFrame:CGRectMake(0, 0, (Window_W-kkPaddingNormalLarge*2), (Window_W-kkPaddingNormalLarge*2)*0.56)];
          TYAttributedLabel *tipLab = [[TYAttributedLabel alloc] init];
          tipLab.frame = _blurView.bounds;
          tipLab.text = @"标题党/封面党\n不看当前频道主：可莱丝的小屋\n刷新后将不在显示";
          tipLab.textColor = kWhiteColor;
          tipLab.font = FONT_12;
          tipLab.textAlignment = kCTTextAlignmentCenter;
          tipLab.verticalAlignment = TYVerticalAlignmentCenter;
          // 文字间隙
          tipLab.characterSpacing = 1;
          // 文本行间隙
          tipLab.linesSpacing = 20;
          tipLab.lineBreakMode = kCTLineBreakByTruncatingTail;
          tipLab.numberOfLines = 3;
          [_blurView addSubview:tipLab];
          [self.coverView addSubview:_blurView];
          
          [self.bgView addSubview:self.withdrawButton];
          [self.withdrawButton mas_makeConstraints:^(MASConstraintMaker *make) {
              make.bottom.mas_equalTo(self.bgView.mas_bottom);
              make.top.mas_equalTo(self.coverView.mas_bottom);
              make.right.left.mas_equalTo(self.coverView);
          }];
    } else {
        [self.withdrawButton removeFromSuperview];
        [self.blurView removeFromSuperview];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark  -  heigth
+ (CGFloat)techHeightForOjb:(id)obj {
    return kHeight(113)+30+kkPaddingSmall+12+17+kkPaddingSmall+kkPaddingSmall;
}

#pragma mark  -  refreshData

- (void)refreshData:(id)data {
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:IMAGE_NAME(STSystemDefaultImageName)];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:IMAGE_NAME(STSystemDefaultImageName)];
    self.leftLabel.text = @"丽的视频就在这里，拍摄了几天，活侗还在开始中的";
    self.rightLabel.text = @"丽的视频就在这里，拍摄了几天，活侗还在开始中的";//丽的视频就在这里，拍摄了几天，活侗还在开始中的
    self.leftDesLabel.text = @"来自附近";
    self.rightDesLabel.text = @"中奇传媒提供";
}
#pragma mark  -  get
- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = ({
            
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
//            ViewBorderRadius(view, kWidth(22), 2, [UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:144.0f/255.0f alpha:1.0f]);
            view;
            
        });
    }
    return _leftImageView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
//            ViewBorderRadius(view, kWidth(22), 2, [UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:144.0f/255.0f alpha:1.0f]);
            view;
        });
    }
    return _rightImageView;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = [UIColor whiteColor];
            view.font = FONT_10;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.numberOfLines = 2;
            view ;
        });
    }
    return _leftLabel;
}
    
- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel =({
            UILabel *view = [UILabel new];
            view.textColor = [UIColor whiteColor];
            view.font = FONT_10;
            view.numberOfLines = 2;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
    }
    return _rightLabel;
}
- (UIButton *)leftTagButton {
    if (!_leftTagButton) {
        _leftTagButton =  ({
           UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
           [btn setTitle:@"广告" forState:UIControlStateNormal];
           btn.titleLabel.font = STFont(9) ;
           btn.layer.masksToBounds = YES ;
           [btn setTitleColor:COLOR_HEX_RGB(0xC7C7D1) forState:UIControlStateNormal];
           btn.layer.borderColor = [[UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:1.0f] CGColor];
           btn.layer.borderWidth = 1;
           btn.layer.cornerRadius = 2;
           btn ;
        });
    }
    return _leftTagButton;
}
- (UIButton *)rightTagButton {
    if (!_rightTagButton) {
        _rightTagButton = ({
           UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
           [btn setTitle:@"广告" forState:UIControlStateNormal];
           btn.titleLabel.font = STFont(9) ;
           btn.layer.masksToBounds = YES ;
           [btn setTitleColor:COLOR_HEX_RGB(0xC7C7D1) forState:UIControlStateNormal];
           btn.layer.borderColor = [[UIColor colorWithRed:178.0f/255.0f green:178.0f/255.0f blue:178.0f/255.0f alpha:1.0f] CGColor];
           btn.layer.borderWidth = 1;
           btn.layer.cornerRadius = 2;
           btn ;
        });
    }
    return _rightTagButton;
}

- (UIButton *)leftMoreButton {
    if (!_leftMoreButton) {
        _leftMoreButton = ({
           UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTag:BUTTON_TAG(11)];
           [btn setImage:IMAGE_NAME(@"ad_more_icon") forState:UIControlStateNormal];
           btn.layer.masksToBounds = YES ;
            [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
           btn ;
        });
    }
    return _leftMoreButton;
}

- (void)clickAction:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:button];
    }
}

- (UIButton *)rightMoreButton {
    if (!_rightMoreButton) {
        _rightMoreButton = ({
           UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTag:BUTTON_TAG(12)];
            [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
           [btn setImage:IMAGE_NAME(@"ad_more_icon") forState:UIControlStateNormal];
           btn.layer.masksToBounds = YES ;
           btn ;
        });
    }
    return _rightMoreButton;
}
- (UILabel *)leftDesLabel {
    if (!_leftDesLabel) {
        _leftDesLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_HEX_RGB(0xC7C7D1);
            view.font = FONT_10;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
    }
    return _leftDesLabel;
}

- (UILabel *)rightDesLabel {
    if (!_rightDesLabel) {
        _rightDesLabel =  ({
                   UILabel *view = [UILabel new];
                   view.textColor = COLOR_HEX_RGB(0xC7C7D1);
                   view.font = FONT_10;
                   view.lineBreakMode = NSLineBreakByTruncatingTail;
                   view.backgroundColor = [UIColor clearColor];
                   view.textAlignment = NSTextAlignmentLeft;
                   view ;
               });
    }
    return _rightDesLabel;
}

- (void)moreBtnClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:button];
    }
}
@end
