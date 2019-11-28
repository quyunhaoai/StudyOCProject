//
//  STLocationChannelTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/17.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STLocationChannelTableViewCell.h"
@interface STLocationChannelTableViewCell()
@property (strong, nonatomic) UIImageView *liveIconImageView; //  视图

@end
@implementation STLocationChannelTableViewCell

+ (instancetype)initializationCellWithTableView:(UITableView *)tableView {
    static NSString *ID  = @"STLocationChannelTableViewCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

+ (CGFloat)techHeightForOjb:(id)obj {
    return (Window_W-kkPaddingNormalLarge*2)*0.56 + 40 +34 + 20;
}

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
    self.backgroundColor = kClearColor;
    [self.contentView addSubview:self.bgView];
    self.bgView.backgroundColor = COLOR_HEX_RGB(0x151420);
    [self.bgView addSubview:self.coverView];
    [self.bgView addSubview:self.headerIconView];
    [self.bgView addSubview:self.vipImageView];
    [self.bgView addSubview:self.nameStringLabel];
    [self.bgView addSubview:self.subNameStringLabel];

    [self.bgView addSubview:self.stateLabel];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.descLabel];
    [self.bgView addSubview:self.rightBtn];
    [self.bgView addSubview:self.videoTimeLabel];
    [self.bgView addSubview:self.liveIconImageView];
    [self addViews];
    [self.coverView.layer insertSublayer:self.gradientLayer below:self.videoTimeLabel.layer];
    [self.coverView.layer insertSublayer:self.gradientLayer1 below:self.titleLabel.layer];
    self.gradientLayer1.frame = CGRectMake(0, 0, Window_W-kkPaddingNormalLarge-kkPaddingNormalLarge, Window_W*0.17);
    self.gradientLayer.frame = CGRectMake(0, Window_W*0.28, Window_W-kkPaddingNormalLarge-kkPaddingNormalLarge, Window_W*0.28);
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-20);
    }];
    [self.headerIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(kkPaddingNormalLarge);
        make.top.mas_equalTo(self.bgView).mas_offset(7);
        make.size.mas_equalTo(CGSizeMake(kWidth(44), kWidth(44)));
    }];
    [self.vipImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerIconView).mas_offset(kWidth(26));
        make.left.mas_equalTo(self.headerIconView).mas_offset(kWidth(33));
        make.size.mas_equalTo(CGSizeMake(kWidth(16), kWidth(16)));
    }];
    [self.nameStringLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(kWidth(67));
        make.top.mas_equalTo(self.bgView).mas_offset(14);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(200);
    }];
    [self.coverView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(kkPaddingNormalLarge);
        make.top.mas_equalTo(self.nameStringLabel.mas_bottom).mas_offset(kkPaddingSmall);
        make.height.mas_equalTo((Window_W-kkPaddingNormalLarge*2)*0.56);
        make.width.mas_equalTo(Window_W - kkPaddingNormalLarge*2);
    }];
    [self.stateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.coverView.mas_right).mas_offset(0);
        make.centerY.mas_equalTo(self.nameStringLabel);
        make.size.mas_equalTo(CGSizeMake(54, 20));
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverView).mas_offset(kkPaddingLarge);
        make.top.mas_equalTo(self.headerIconView.mas_bottom).mas_offset(3);
        make.height.mas_equalTo(41);
        make.width.mas_equalTo(Window_W - kkPaddingNormalLarge*4);
    }];
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).mas_offset(-42);
        make.bottom.mas_equalTo(self.bgView).mas_offset(-8);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(200);
    }];
    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-kkPaddingNormalLarge);
        make.bottom.mas_equalTo(self.bgView).mas_offset(-8);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.liveIconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.stateLabel);
        make.right.mas_equalTo(self.stateLabel.mas_left).mas_offset(-kkPaddingMin);
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    self.activityView = [[SPActivityIndicatorView alloc] initWithType:SPActivityIndicatorAnimationTypeLineScalePulseOut tintColor:kWhiteColor size:11];
    self.activityView.frame = CGRectMake(kkPaddingNormalLarge+kkPaddingNormalLarge+8, (Window_W-kkPaddingNormalLarge*2)*0.56 + 40-14-16-kkPaddingSmall, 11, 11);
    [self.bgView addSubview:self.activityView];
    self.videoTimeLabel.frame = CGRectMake(kkPaddingNormalLarge+kkPaddingNormalLarge+kkPaddingNormalLarge+11, (Window_W-kkPaddingNormalLarge*2)*0.56 + 40-17-16-kkPaddingSmall, 100, 17);

    XYWeakSelf;
    [self.headerIconView addTapGestureWithBlock:^(UIView *gestureView) {
        if ([weakSelf.delegate respondsToSelector:@selector(jumpToUserPage:)]) {
            [weakSelf.delegate jumpToUserPage:@""];
        }
    }];
    
    self.vipImageView.hidden = NO;
    self.stateLabel.font = FONT_14;
    [self.stateLabel sizeToFit];
    self.stateLabel.textColor = color_tipYellow_FECE24;
    
    [self.bgView addSubview:self.smallWindosView];
    [self.smallWindosView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.coverView.mas_right);
        make.bottom.mas_equalTo(self.coverView.mas_bottom);
        make.width.mas_equalTo(165);
        make.height.mas_equalTo(109);
    }];
    ViewBorderRadius(self.headerIconView, kWidth(22), 2, color_tipFeng_FF2190);
}

- (void)refreshData:(id)data {
    [self.activityView startAnimating];
    [self.headerIconView setCornerImageWithURL:[NSURL URLWithString:@""] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
    self.titleLabel.text = @"最靓丽的视频就在这里，拍摄了几天，容纳了众多美女参与";
    self.nameStringLabel.text = @"蔚蓝的天空";
    NSRange dddd = NSMakeRange(4, 4);
    self.descLabel.text = @"本视频有光引科技赞助";
    SetRichTextLabel(self.descLabel, FONT_10,dddd, [UIColor colorWithRed:245.0f/255.0f green:207.0f/255.0f blue:56.0f/255.0f alpha:1.0f]);
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:IMAGE_NAME(@"微信图片_20191006211832")];
    [self.stateLabel setText:@"直播中"];
    self.videoTimeLabel.text = @"2.5万 3.05";
}
- (void)moreBtnClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:button];
    }
}
#pragma  mark  --  smallWindows 懒加载
- (UIView *)smallWindosView {
    
    if (!_smallWindosView) {
        _smallWindosView = ({
            
            UIView *view = [[UIView alloc]init];
            view.userInteractionEnabled = NO;
            view.hidden = YES;
            view.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
            view.layer.borderWidth = 1;
            view.alpha = 1;
            view;
            
        });
    }
    return _smallWindosView;
}
#pragma  mark  --  gradientLayer 懒加载

- (CAGradientLayer *)gradientLayer1{
    if(!_gradientLayer1){
        _gradientLayer1 = [CAGradientLayer layer];
        _gradientLayer1.colors = @[(__bridge id)[UIColor colorWithRed:48.0f/255.0f green:55.0f/255.0f blue:66.0f/255.0f alpha:0.90f].CGColor,(__bridge id)[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.01f].CGColor];
        _gradientLayer1.startPoint = CGPointMake(1, 0);
        _gradientLayer1.endPoint = CGPointMake(1.0, 1.0);
    }
    return _gradientLayer1;
}
- (CAGradientLayer *)gradientLayer{
    if(!_gradientLayer){
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.01f].CGColor, (__bridge id)[UIColor colorWithRed:48.0f/255.0f green:55.0f/255.0f blue:66.0f/255.0f alpha:0.90f].CGColor];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    }
    return _gradientLayer;
}
#pragma  mark  --  liveIconImageView 懒加载
- (UIImageView *)liveIconImageView {
    
    if (!_liveIconImageView) {
        _liveIconImageView = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            [view setImage:IMAGE_NAME(@"live_type_icon")];
            view;
            
        });
    }
    return _liveIconImageView;
}
#pragma  mark  --  headIcon 懒加载

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addViews {
    UIView *imageListView = [UIView new];
    [self.bgView addSubview:imageListView];
    [imageListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView);
        make.left.mas_equalTo(self.coverView).mas_offset(kkPaddingMin);
        make.width.mas_equalTo(159+kkPaddingNormalLarge);
        make.height.mas_equalTo(46);
    }];
    for (int i=0; i<5; i++) {
        UIImageView *icon = [[UIImageView alloc] init];
        [imageListView addSubview:icon];//175-4*4
        icon.frame = CGRectMake((159/5 * i) , 0, 35, 35);
        ViewBorderRadius(icon, 17.5, 2, kWhiteColor);
        [icon setCornerImageWithURL:[NSURL URLWithString:@""] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
    }
}

#pragma mark  -  resetplayView

- (void)resetPlayerView {
    if (self.smallWindosView) {
//        [self.smallWindosView removeFromSuperview];
//        self.smallWindosView = nil;
        self.smallWindosView.hidden = YES;
    }
}

@end
