//
//  STVideoChannelTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/16.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STVideoChannelTableViewCell.h"
#import "DRNRealTimeBlurView.h"
#import "TagView.h"
@interface STVideoChannelTableViewCell()
@property (strong, nonatomic) UILabel *shareLab; //  视图
@property (strong, nonatomic) UILabel *likeLabel; //  标签
@property (strong, nonatomic) UILabel *stateLabel2; //  标签
@property (strong, nonatomic) DRNRealTimeBlurView *blurView; // 视图
@property (strong, nonatomic) TagView *tagView; // 视图
@property (strong, nonatomic) UIView *headerIconListView; //  图片

@end
@implementation STVideoChannelTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView {
    static NSString *ID  = @"STVideoChannelTableViewCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
+ (CGFloat)techHeightForOjb:(id)obj {
    return (Window_W-kkPaddingNormalLarge*2)*0.56 + kWidth(44) + kkPaddingNormalLarge + kkPaddingSmall*2 + 24+kkPaddingSmall + 30;
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
    [self.bgView addSubview:self.headerIconView];
    [self.bgView addSubview:self.nameStringLabel];
    [self.bgView addSubview:self.subNameStringLabel];
    [self.bgView addSubview:self.coverView];
    [self.coverView addSubview:self.titleLabel];
    [self.bgView addSubview:self.descLabel];
    [self.bgView addSubview:self.commentLabel];
    [self.bgView addSubview:self.rightBtn];
    [self.coverView addSubview:self.playSmallImageView];
    [self.coverView addSubview:self.videoTimeLabel];
    [self.bgView addSubview:self.vipImageView];
    [self addViews];
    [self.coverView.layer insertSublayer:self.gradientLayer below:self.videoTimeLabel.layer];
    [self.coverView.layer insertSublayer:self.gradientLayer1 below:self.titleLabel.layer];
    self.gradientLayer1.frame = CGRectMake(0, 0, Window_W-kkPaddingNormalLarge-kkPaddingNormalLarge, Window_W*0.17);
    self.gradientLayer.frame = CGRectMake(0, Window_W*0.28, Window_W-kkPaddingNormalLarge-kkPaddingNormalLarge, Window_W*0.28);
    [self.coverView bringSubviewToFront:self.playSmallImageView];
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-20);
    }];
    [self.headerIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.bgView).mas_offset(kkPaddingNormalLarge);
        make.size.mas_equalTo(CGSizeMake(kWidth(44), kWidth(44)));
    }];
    [self.vipImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerIconView).mas_offset(kWidth(30));
        make.left.mas_equalTo(self.headerIconView).mas_offset(kWidth(33));
        make.size.mas_equalTo(CGSizeMake(kWidth(16), kWidth(16)));
    }];
    [self.nameStringLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView.mas_right).mas_offset(kkPaddingSmall);
        make.top.mas_equalTo(self.headerIconView).mas_equalTo(kkPaddingMin);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(200);
    }];
    [self.subNameStringLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameStringLabel);
        make.top.mas_equalTo(self.nameStringLabel.mas_bottom).mas_offset(kkPaddingSmall);
        make.height.mas_equalTo(self.nameStringLabel);
        make.width.mas_equalTo(240);
    }];
    [self.coverView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView);
        make.top.mas_equalTo(self.headerIconView.mas_bottom).mas_offset(kkPaddingSmall);
        make.height.mas_equalTo((Window_W-kkPaddingNormalLarge*2)*0.56);
        make.width.mas_equalTo(Window_W - kkPaddingNormalLarge*2);
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverView).mas_offset(kkPaddingLarge);
        make.top.mas_equalTo(self.coverView.mas_top).mas_offset(kkPaddingNormalLarge);
        make.height.mas_equalTo(41);
        make.width.mas_equalTo(Window_W - kkPaddingNormalLarge*4);
    }];
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.coverView);
        make.centerY.mas_equalTo(self.nameStringLabel.mas_bottom).mas_offset(-6);
        make.height.mas_equalTo(self.nameStringLabel);
        make.width.mas_equalTo(200);
    }];

    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-kkPaddingNormalLarge);
        make.centerY.mas_equalTo(self.commentLabel);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.playSmallImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.coverView).mas_offset(-kkPaddingNormalLarge);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(24);
    }];
    [self.videoTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playSmallImageView.mas_right).mas_offset(kkPaddingSmall+3);
        make.bottom.mas_equalTo(self.coverView).mas_offset(-kkPaddingNormalLarge);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(100);
    }];
    [self.bgView addSubview:self.shareLab];
    [self.bgView addSubview:self.likeLabel];

    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverView.mas_bottom).mas_offset(kkPaddingNormal);
        make.left.mas_equalTo(self.coverView.mas_left).mas_offset(kkMarginMin);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(100);
    }];
    [self.shareLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.likeLabel);
        make.left.mas_equalTo(self.likeLabel.mas_right).mas_offset(kkMarginSmall);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(100);
    }];
    [self.commentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.likeLabel);
        make.left.mas_equalTo(self.shareLab.mas_right).mas_offset(kkMarginSmall);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(100);
    }];
    
    XYWeakSelf;
    [self.headerIconView addTapGestureWithBlock:^(UIView *gestureView) {
        if ([weakSelf.delegate respondsToSelector:@selector(jumpToUserPage:)]) {
            [weakSelf.delegate jumpToUserPage:@""];
        }
    }];
    
    self.vipImageView.hidden = NO;
    self.stateLabel.backgroundColor = COLOR_HEX_RGB(0x3A3A44);
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.bgView addSubview:self.smallWindosView];
    [self.smallWindosView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.coverView.mas_right);
        make.bottom.mas_equalTo(self.coverView.mas_bottom);
        make.width.mas_equalTo(165);
        make.height.mas_equalTo(109);
    }];
    self.tagView = [[TagView alloc] initWithFrame:CGRectMake(kWidth(223), 12+18+10, Window_W-(kWidth(230)), kHeight(28))];
    [self.bgView addSubview:self.tagView];
}

- (void)refreshData:(STVideoChannelModl *)model {
    if (model) {
        [self.headerIconView yy_setImageWithURL:[NSURL URLWithString:model.headimg] placeholder:STImageViewDefaultImageMacro];
        
        self.titleLabel.text = model.video_title;
        self.nameStringLabel.text = model.nickname;
        NSDate *dat = [NSString getDateFormat:model.add_time Format:@"YYYY-MM-dd HH:mm"];//yyyy-MM-dd,今天,HH:mm
        NSString *sendTimeStr = [NSDate compareCurrentTime:dat];
        if (model.zuozhe_desc.length>0) {
            self.subNameStringLabel.text =[NSString stringWithFormat:@"%@·%@",sendTimeStr,model.zuozhe_desc];
        } else {
            self.subNameStringLabel.text =[NSString stringWithFormat:@"%@",sendTimeStr];
        }
        NSString *video_sponsor = @"";
        if (model.video_sponsor.count) {
            for (int i = 0; i<model.video_sponsor.count; i++) {
                NSDictionary *dict = model.video_sponsor[i];
                [video_sponsor stringByAppendingString:@","];
                [video_sponsor stringByAppendingString:[dict objectForKey:@"nickname"]];
            }
            self.descLabel.text =[NSString stringWithFormat:@"本视频有%@赞助",video_sponsor];
            SetAnthorRichTextLabel(self.descLabel,
                                   FONT_10,video_sponsor,
                                   [UIColor colorWithRed:245.0f/255.0f
                                                   green:207.0f/255.0f
                                                    blue:56.0f/255.0f
                                                   alpha:1.0f]);
        }
        self.commentLabel.text = [NSString stringWithFormat:@"%ld评论",model.comment_volume];
        SetAnthorRichTextLabel(self.commentLabel, FONT_15, STRING_FROM_INTAGER(model.comment_volume), kWhiteColor);
        self.likeLabel.text = [NSString stringWithFormat:@"%ld获赞",model.zan_volume];
        SetAnthorRichTextLabel(self.likeLabel, FONT_15,  STRING_FROM_INTAGER(model.zan_volume), kWhiteColor);
        self.shareLab.text = [NSString stringWithFormat:@"%ld分享",model.share_volume];
        SetAnthorRichTextLabel(self.shareLab, FONT_15, STRING_FROM_INTAGER(model.share_volume), kWhiteColor);
        [self.coverView sd_setImageWithURL:[NSURL URLWithString:model.video_thumb] placeholderImage:STImageViewDefaultImageMacro];
        
        self.videoTimeLabel.text = [NSString stringWithFormat:@"%@ %@'",[NSString tenThousandTfromInt:(int)model.play_volume],model.video_duration] ;
        self.tagView.dataSources= model.video_type;
        if (!model.is_v) {
            self.vipImageView.hidden = YES;
            self.headerIconView.layer.borderColor = [[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] CGColor];
        } else {
            self.vipImageView.hidden = NO;
            if (model.sex) {
                self.headerIconView.layer.borderColor = [[UIColor colorWithRed:0.0f/255.0f green:166.0f/255.0f blue:193.0f/255.0f alpha:1.0f] CGColor];
            } else {
                self.headerIconView.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:144.0f/255.0f alpha:1.0f] CGColor];
            }
        }
        for (int i=0; i<model.video_team.count; i++) {
            if (model.video_team.count !=5) {
                break;
            }
            UIImageView *icon = [[UIImageView alloc] init];
            [self.headerIconListView addSubview:icon];//175-4*4
            icon.frame = CGRectMake((159/5 * i) , 0, 35, 35);
            ViewBorderRadius(icon, 17.5, 2, kWhiteColor);
            NSDictionary *dic = model.video_team[i];
            [icon setCornerImageWithURL:[NSURL URLWithString:[dic objectForKey:@"headimg"]] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
        }
        //备注 headimg：发布者图像 nickname： 发布者姓名 is_v： 发布者是否加V 1是 0否 sex： 发布者性别 1男 0女 zuozhe_desc：发布者简介 video_title： 视频标题 video_thumb：视频缩略图 video_url：视频资源地址 play_volume：播放次数 zan_volume：点赞数 share_volume：分享数 comment_volume：评论数（不算回复的，只算直接评论） video_duration：视频时长 add_time：发布时间 video_type：视频标签类型 video_team：视频团队成员 video_sponsor：赞助商
    }
}

- (void)setIsShowWithdram:(BOOL)isShowWithdram {
    _isShowWithdram = isShowWithdram;
    if (_isShowWithdram) {
          _blurView = [[DRNRealTimeBlurView alloc] initWithFrame:CGRectMake(0, 0, (Window_W-kkPaddingNormalLarge*2), (Window_W-kkPaddingNormalLarge*2)*0.56)];
          TYAttributedLabel *tipLab = [[TYAttributedLabel alloc] init];
          tipLab.frame = _blurView.bounds;
          tipLab.text = [NSString stringWithFormat:@"%@\n%@\n刷新后将不在显示",checkNull(self.withdrawDic[@"content"]),checkNull(self.withdrawDic[@"channel"])];
          tipLab.textColor = kWhiteColor;
          tipLab.font = FONT_12;
          tipLab.textAlignment = kCTTextAlignmentCenter;
          tipLab.verticalAlignment = TYVerticalAlignmentCenter;
          tipLab.characterSpacing = 1;
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
            view;
        });
    }
    return _smallWindosView;
}

#pragma  mark  --  statelab2 懒加载
- (UILabel *)stateLabel2 {
    
    if (!_stateLabel2) {
        _stateLabel2 =({
            UILabel *view = [UILabel new];
            view.textColor = color_textBg_C7C7D1;
            view.font = FONT_10;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor =  COLOR_HEX_RGB(0x3A3A44);
            view.textAlignment = NSTextAlignmentCenter;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 1;
            view ;
        });
    }
    return _stateLabel2;
}

#pragma  mark  --  shareLab 懒加载
- (UILabel *)shareLab {
    
    if (!_shareLab) {
        _shareLab = ({
                   UILabel *view = [UILabel new];
                   view.textColor = color_text_AFAFB1;
                   view.font = FONT_11;
                   view.lineBreakMode = NSLineBreakByTruncatingTail;
                   view.backgroundColor = [UIColor clearColor];
                   view.textAlignment = NSTextAlignmentLeft;
                   view ;
               });
    }
    return _shareLab;
}

- (UILabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = ({
                   UILabel *view = [UILabel new];
                   view.textColor = color_text_AFAFB1;
                   view.font = FONT_11;
                   view.lineBreakMode = NSLineBreakByTruncatingTail;
                   view.backgroundColor = [UIColor clearColor];
                   view.textAlignment = NSTextAlignmentLeft;
                   view ;
               });
    }
    return _likeLabel;
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

#pragma  mark  --  headIcon 懒加载
- (UIImageView *)playSmallImageView {
    if (!_playSmallImageView) {
        _playSmallImageView = ({
           UIImageView *view = [UIImageView new];
           view.contentMode = UIViewContentModeScaleAspectFill ;
           view.layer.masksToBounds = YES ;
           view.userInteractionEnabled = YES ;
           [view setImage:IMAGE_NAME(@"video_play_icon_home")];
            
           view;
        });
    }
    return _playSmallImageView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addViews {
    UIView *imageListView = [UIView new];
    [self.coverView addSubview:imageListView];
    [imageListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.coverView);
        make.width.mas_equalTo(159+kkPaddingNormalLarge);
        make.height.mas_equalTo(46);
    }];
    self.headerIconListView = imageListView;
//    for (int i=0; i<5; i++) {
//        UIImageView *icon = [[UIImageView alloc] init];
//        [imageListView addSubview:icon];//175-4*4
////        icon.frame = CGRectMake((159-35-normalSpace-(159/5 * i)) , 0, 35, 35);从右向左b排序
//        icon.frame = CGRectMake((159/5 * i) , 0, 35, 35);
//        ViewBorderRadius(icon, 17.5, 2, kWhiteColor);
//        [icon setCornerImageWithURL:[NSURL URLWithString:@""] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
//    }
}

- (void)withdrawAction:(UIButton *)button {
    self.isShowWithdram = NO;
}
@end
