//
//  STSubscribeVideoTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/12.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STSubscribeVideoTableViewCell.h"
#import "TagView.h"
#import "DRNRealTimeBlurView.h"
@interface STSubscribeVideoTableViewCell()
@property (strong, nonatomic) UILabel *shareLab; //  视图
@property (strong, nonatomic) UILabel *likeLabel; //  标签
@property (strong, nonatomic) UIButton *likeBtn; //  标签
@property (nonatomic,strong) UIButton *commentButton; // 按钮
@property (strong, nonatomic) DRNRealTimeBlurView *blurView; // 视图
@property (strong, nonatomic) TagView *tagView; // 视图
@property (strong, nonatomic) UIView *headerIconListView; //  图片
@property (nonatomic,strong) UIButton *addButton; //  按钮
@end

@implementation STSubscribeVideoTableViewCell

+ (instancetype)initializationCellWithTableView:(UITableView *)tableView {
    static NSString *ID  = @"STSubscribeVideoTableViewCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
+ (CGFloat)techHeightForOjb:(id)obj {
//    return (Window_W)*0.56 + kWidth(44) + kkPaddingNormalLarge + kkPaddingSmall*2 + 24+kkPaddingSmall + 15;
    return kkPaddingNormalLarge + kWidth(50) + kkPaddingSmall + kkPaddingTiny + Window_W*0.56 + 50;
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
    [self.bgView addSubview:self.rightBtn];
    [self.coverView addSubview:self.playVideoBtn];
    [self.coverView addSubview:self.videoTimeLabel];
    [self.bgView addSubview:self.vipImageView];
    [self.bgView addSubview:self.tagView];
    [self addViews];
    [self.coverView.layer insertSublayer:self.gradientLayer below:self.videoTimeLabel.layer];
    [self.coverView.layer insertSublayer:self.gradientLayer1 below:self.titleLabel.layer];
    self.gradientLayer1.frame = CGRectMake(0, 0, Window_W, Window_W*0.17);
    self.gradientLayer.frame = CGRectMake(0, Window_W*0.28, Window_W, Window_W*0.28);
    [self.coverView bringSubviewToFront:self.playSmallImageView];
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-5);
    }];
    [self.headerIconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.bgView).mas_offset(kkPaddingNormalLarge);
        make.size.mas_equalTo(CGSizeMake(kWidth(50), kWidth(50)));
    }];
    [self.vipImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerIconView).mas_offset(kWidth(36));
        make.left.mas_equalTo(self.headerIconView).mas_offset(kWidth(39));
        make.size.mas_equalTo(CGSizeMake(kWidth(16), kWidth(16)));
    }];
    [self.nameStringLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView.mas_right).mas_offset(kkPaddingNormalLarge);
        make.top.mas_equalTo(self.headerIconView).mas_equalTo(kkPaddingTiny);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(200);
    }];
    [self.subNameStringLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameStringLabel);
        make.top.mas_equalTo(self.nameStringLabel.mas_bottom).mas_offset(kkPaddingTiny);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(240);
    }];
//    [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.nameStringLabel);
//        make.top.mas_equalTo(self.subNameStringLabel.mas_bottom).mas_offset(kkPaddingNormalLarge);
//        make.height.mas_equalTo(18);
//        make.width.mas_equalTo(240);
//    }];
    self.tagView.frame = CGRectMake(kWidth(50)+kkPaddingNormalLarge+kkPaddingNormalLarge, kkPaddingNormalLarge+kkPaddingTiny+18+kkPaddingTiny+14+kkPaddingMin, 240, 20);
    [self.coverView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView);
        make.top.mas_equalTo(self.headerIconView.mas_bottom).mas_offset(kkPaddingSmall+kkPaddingTiny);
        make.height.mas_equalTo((Window_W)*0.56);
        make.width.mas_equalTo(Window_W);
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverView).mas_offset(kkPaddingNormalLarge);
        make.top.mas_equalTo(self.coverView.mas_top).mas_offset(kkPaddingNormal);
        make.height.mas_equalTo(41);
        make.width.mas_equalTo(Window_W - kkPaddingNormalLarge*2);
    }];
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.coverView).mas_offset(kkPaddingNormalLarge);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-15);//45-18/2
        make.height.mas_equalTo(self.nameStringLabel);
        make.width.mas_equalTo(200);
    }];

    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.descLabel.mas_right).mas_offset(kkPaddingSmall);
        make.centerY.mas_equalTo(self.descLabel);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.playVideoBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.coverView);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    [self.videoTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgView.mas_centerX).mas_offset(0);
        make.bottom.mas_equalTo(self.coverView).mas_offset(-kkPaddingNormalLarge);
        make.height.mas_equalTo(17);
        make.width.mas_equalTo(100);
    }];

    [self.bgView addSubview:self.likeBtn];
    [self.bgView addSubview:self.likeLabel];
    [self.bgView addSubview:self.commentButton];
    [self.bgView addSubview:self.commentLabel];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rightBtn.mas_right).mas_offset(kkPaddingNormalLarge);
        make.centerY.mas_equalTo(self.rightBtn);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.likeBtn.mas_right).mas_offset(kkPaddingSmall);
        make.centerY.mas_equalTo(self.rightBtn);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.likeLabel.mas_right).mas_offset(kkPaddingNormalLarge);
       make.centerY.mas_equalTo(self.rightBtn);
       make.width.mas_equalTo(25);
       make.height.mas_equalTo(25);
    }];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentButton.mas_right).mas_offset(kkPaddingSmall);
        make.centerY.mas_equalTo(self.rightBtn);
        make.right.mas_equalTo(self.bgView).mas_offset(-kkPaddingNormalLarge);
        make.height.mas_equalTo(15);
    }];
//    [self.bgView addSubview:self.addButton];
//    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.headerIconView);
//        make.right.mas_equalTo(self.bgView).mas_offset(-kkPaddingNormalLarge);
//        make.height.mas_equalTo(21);
//        make.width.mas_equalTo(60);
//    }];
    
    XYWeakSelf;
    [self.headerIconView addTapGestureWithBlock:^(UIView *gestureView) {
        if ([weakSelf.delegate respondsToSelector:@selector(jumpToUserPage:)]) {
            [weakSelf.delegate jumpToUserPage:@""];
        }
    }];
    self.commentLabel.textColor = KKColor(214, 216, 228, 1.0);
    self.vipImageView.hidden = NO;
    [self.descLabel setTextAlignment:NSTextAlignmentLeft];
    self.commentLabel.font = FONT_14;
    [self setData];
//    [self.playVideoBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.coverView.userInteractionEnabled = NO;
}

- (void)playBtnClick:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickImageWithItem:rect:fromView:image:indexPath:)]) {
        [self.delegate clickImageWithItem:@"" rect:self.coverView.frame fromView:self.contentView image:self.coverView.image indexPath:nil];
    }
//    _playerView = [[SuperPlayerView alloc] init];
//
//    _playerView.fatherView = self.coverView;//b播放器的父视图
////    self.playerView.delegate = self;
//    SPWeiboControlView *weiboStly = [[SPWeiboControlView alloc] init];
//    weiboStly.moreBtn.hidden = YES;
//    weiboStly.muteBtn.hidden = YES;
//    self.playerView.controlView = weiboStly;
//    SuperPlayerModel *playerModel = [[SuperPlayerModel alloc] init];
//    playerModel.videoURL = @"http://mp.youqucheng.com/addons/project/data/uploadfiles/video/1_06257727562426755.mp4?t=0.7643188466880166";
//    self.playerView.autoPlay = YES;
//    self.playerView.loop = YES;
//    [_playerView playWithModel:playerModel];
}
- (void)setData {
    [self.headerIconView setCornerImageWithURL:[NSURL URLWithString:@""] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
    self.titleLabel.text = @"最靓丽的视频就在这里，拍摄了几天，容纳了众多美女排";
    self.nameStringLabel.text = @"玩转粉号";
    self.subNameStringLabel.text = @"搞笑视频自媒体团体";
    NSRange dddd = NSMakeRange(4, 4);
    self.descLabel.text = @"本视频有光引科技赞助";
    SetRichTextLabel(self.descLabel, FONT_10,dddd, [UIColor colorWithRed:245.0f/255.0f
    green:207.0f/255.0f
     blue:56.0f/255.0f
    alpha:1.0f]);
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:IMAGE_NAME(STSystemDefaultImageName)];
    self.videoTimeLabel.text = @"0次播放";
    self.likeLabel.text = @"156";
    self.commentLabel.text = @"0";
    self.tagView.dataSources = @[@"原创",@"短片",@"订阅"];

}

- (void)layoutSubviews {
    [super layoutSubviews];
//    [self.tagView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.nameStringLabel);
//        make.top.mas_equalTo(self.subNameStringLabel.mas_bottom).mas_offset(kkPaddingNormalLarge);
//        make.height.mas_equalTo(18);
//        make.width.mas_equalTo(240);
//    }];
}
- (void)refreshData:(STVideoChannelModl *)model {
    if (model) {
        [self.headerIconView yy_setImageWithURL:[NSURL URLWithString:model.headimg] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
        
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

        
        [self.coverView sd_setImageWithURL:[NSURL URLWithString:model.video_thumb] placeholderImage:STImageViewDefaultImageMacro];
        
        self.videoTimeLabel.text = [NSString stringWithFormat:@"%@次播放",[NSString tenThousandTfromInt:(int)model.play_volume]] ;
        self.tagView.dataSources= model.video_type;
        if (!model.is_v) {
            self.vipImageView.hidden = YES;
        } else {
            self.vipImageView.hidden = NO;
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
          _blurView = [[DRNRealTimeBlurView alloc] initWithFrame:CGRectMake(0, 0, (Window_W), Window_W*0.56)];
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
#pragma  mark  --  addBtn 懒加载
- (UIButton *)addButton {
    
    if (!_addButton) {
        _addButton =({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"订阅+" forState:UIControlStateNormal];
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
//- (void)addBtnClick:(UIButton *)button {
//    button.selected = !button.isSelected;
//    if (button.selected) {
//        button.layer.backgroundColor = [[UIColor colorWithRed:58.0f/255.0f green:58.0f/255.0f blue:68.0f/255.0f alpha:1.0f] CGColor];
//        [button setTitle:@"已订阅" forState:UIControlStateNormal];
//    } else {
//        button.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:144.0f/255.0f alpha:1.0f] CGColor];
//        [button setTitle:@"订阅+" forState:UIControlStateNormal];
//    }
//}
- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn =  ({
                   UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
                   [view setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
                   [view setUserInteractionEnabled:YES];
                   view ;
               });
    }
    return _likeBtn;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = ({
                   UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
                   [view setImage:[UIImage imageNamed:@"comment_icon_video"] forState:UIControlStateNormal];
                   [view setUserInteractionEnabled:YES];
                   view ;
               });
    }
    return _commentButton;
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
                   view.textColor = KKColor(214, 216, 228, 1.0);
                   view.font = FONT_14;
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
}

- (void)withdrawAction:(UIButton *)button {
    if (button.tag == BUTTON_TAG(100)) {
        [self playBtnClick:button];
    } else {
        self.isShowWithdram = NO;
    }

}

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

@end
