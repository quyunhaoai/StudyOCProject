//
//  STHomeVideoTableViewCell.m
//  
//
//  Created by 研学旅行 on 2019/11/7.
//

#import "STHomeVideoTableViewCell.h"
#import "TagView.h"
#import <MCFireworksButton.h>
#import "DRNRealTimeBlurView.h"
@interface STHomeVideoTableViewCell()

@property (strong, nonatomic) UILabel *shareLab; //  视图
@property (strong, nonatomic) UILabel *likeLabel; //  标签
@property (strong, nonatomic) MCFireworksButton *likeBtn; //  标签
@property (nonatomic,strong) UIButton *commentButton; // 按钮
@property (strong, nonatomic) DRNRealTimeBlurView *blurView; // 视图
@property (strong, nonatomic) TagView *tagView; // 视图
@property (strong, nonatomic) UIView *headerIconListView; //  图片
@property (nonatomic,strong) UIButton *addButton; //  按钮
@property (strong, nonatomic) SuperPlayerView *playerView; //  视图
@property (strong, nonatomic) STVideoChannelModl *model;    //
@end
@implementation STHomeVideoTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView {
    static NSString *ID  = @"STVideoChannelTableViewCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
+ (CGFloat)techHeightForOjb:(id)obj {
    return kkPaddingNormalLarge + kWidth(44) + kkPaddingSmall + kkPaddingTiny + Window_W*0.56 + 50;
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
        make.size.mas_equalTo(CGSizeMake(kWidth(44), kWidth(44)));
    }];
    [self.vipImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerIconView).mas_offset(kWidth(30));
        make.left.mas_equalTo(self.headerIconView).mas_offset(kWidth(33));
        make.size.mas_equalTo(CGSizeMake(kWidth(16), kWidth(16)));
    }];
    [self.nameStringLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView.mas_right).mas_offset(kkPaddingNormalLarge);
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
        make.width.mas_equalTo((Window_W-24)/2);
    }];
    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.descLabel.mas_right).mas_offset(kkPaddingNormalLarge);
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
    [self.bgView addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headerIconView);
        make.right.mas_equalTo(self.bgView).mas_offset(-kkPaddingNormalLarge);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(60);
    }];
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
}
- (void)addPlayView {
    [self playBtnClick:nil];
}

- (void)playBtnClick:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickImageWithItem:rect:fromView:image:indexPath:)]) {
        [self.delegate clickImageWithItem:self.model rect:self.coverView.frame fromView:self.contentView image:self.coverView.image indexPath:self.indexPath];
    }
}

- (void)refreshData:(STVideoChannelModl *)model {
    if (model) {
        self.model=model;
        [self.headerIconView yy_setImageWithURL:[NSURL URLWithString:model.headimg] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
        
        self.titleLabel.text = model.video_title;
        self.nameStringLabel.text = model.nickname;
        self.subNameStringLabel.text = model.zuozhe_desc;
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
        self.likeLabel.text = model.zan_volume?STRING_FROM_INTAGER(model.zan_volume):@"赞";
        self.commentLabel.text = model.comment_volume?STRING_FROM_INTAGER(model.comment_volume):@"评论";
        //备注 headimg：发布者图像 nickname： 发布者姓名 is_v： 发布者是否加V 1是 0否 sex： 发布者性别 1男 0女 zuozhe_desc：发布者简介 video_title： 视频标题 video_thumb：视频缩略图 video_url：视频资源地址 play_volume：播放次数 zan_volume：点赞数 share_volume：分享数 comment_volume：评论数（不算回复的，只算直接评论） video_duration：视频时长 add_time：发布时间 video_type：视频标签类型 video_team：视频团队成员 video_sponsor：赞助商
        //备注 headimg：发布者图像 nickname： 发布者姓名 is_v： 发布者是否加V 1是 0否 sex： 发布者性别 1男 0女 zuozhe_desc：发布者简介 video_title： 视频标题 video_thumb：视频缩略图 video_url：视频资源地址 play_volume：播放次数 zan_volume：点赞数 share_volume：分享数 comment_volume：评论数（不算回复的，只算直接评论）
    }
}

- (void)moreBtnClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:self.model];
    }
}
- (void)commentBtnClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(clickButtonWithType:item:)]) {
        [self.delegate clickButtonWithType:KKBarButtonTypeComment item:self.model];
    }
}
#pragma  mark  --  addBtn 懒加载
- (UIButton *)addButton {
    if (!_addButton) {
        _addButton =({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"主页" forState:UIControlStateNormal];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpToUserPage:)]) {
        [self.delegate jumpToUserPage:@""];
    }
}

- (MCFireworksButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn =  ({
           MCFireworksButton *view = [MCFireworksButton buttonWithType:UIButtonTypeCustom];
             view.particleImage = [UIImage imageNamed:@"like_icon_video"];
             view.particleScale = 0.05;
             view.particleScaleRange = 0.02;
            [view setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
            [view setUserInteractionEnabled:YES];
             [view addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
           view ;
       });
    }
    return _likeBtn;
}

- (void)likeBtnClick:(MCFireworksButton *)sender {
    sender.selected= !sender.selected;
    if (sender.selected) {
        [sender popOutsideWithDuration:0.5];
        [sender setImage:[UIImage imageNamed:@"smallVideo_home_like_after"] forState:UIControlStateNormal];
        self.likeLabel.textColor = KKColor(243, 55, 102, 1);
    }
    else {
        [sender popInsideWithDuration:0.4];
        [sender setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
        self.likeLabel.textColor = color_textBg_C7C7D1;
    }
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = ({
           UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
           [view setImage:[UIImage imageNamed:@"comment_icon_video"] forState:UIControlStateNormal];
           [view setUserInteractionEnabled:YES];
            [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
           view ;
       });
    }
    return _commentButton;
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

@end
