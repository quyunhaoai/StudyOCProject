//
//  STSmallPlayShopTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/12/4.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STSmallPlayShopTableViewCell.h"
#import "FavoriteView.h"
#import "FocusView.h"
@interface STSmallPlayShopTableViewCell ()
@property (nonatomic, strong) FocusView        *focus;
@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UIImageView *share;
@property (nonatomic, strong) UILabel *shareNum;

@property (nonatomic, strong) UIImageView *comment;
@property (nonatomic, strong) UILabel *commentNum;

@property (nonatomic, strong) FavoriteView *favorite;
@property (nonatomic, strong) UILabel *favoriteNum;

@property (nonatomic, weak)IBOutlet UIImageView *avatar;
//@property (nonatomic, strong) UIButton *focus;

@property (nonatomic, weak)IBOutlet UILabel *nameLabel;
@property (nonatomic, weak)IBOutlet UILabel *artistLabel;
@property (strong, nonatomic) UILabel *detailLabel; //  标签
@property (strong, nonatomic) UIImageView *vipImageView; //  图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMar;
@property (weak, nonatomic) IBOutlet UIImageView *grybbb;
@property (weak, nonatomic) IBOutlet UIImageView *gryccc;
@property (weak, nonatomic) IBOutlet UIButton *liveIconBtn;

@end
@implementation STSmallPlayShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.coverImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.coverImageView];
    self.imageView.backgroundColor = [UIColor blackColor];
    self.contentView.backgroundColor = [UIColor blackColor];
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    self.playerFatherView = [[UIView alloc] init];
    [self.contentView addSubview:self.playerFatherView];
    [self.playerFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    CAGradientLayer *gradientLayer = [CAGradientLayer new];
    
    gradientLayer.frame = CGRectMake(SCREEN_WIDTH - 100 , 0, 100 , SCREEN_HEIGHT);
    //colors存放渐变的颜色的数组
    gradientLayer.colors=@[(__bridge id)RGBA(0, 0, 0, 0.5).CGColor,(__bridge id)RGBA(0, 0, 0, 0.0).CGColor];
//        gradientLayer.locations = @[@0.3, @0.5, @1.0];
    /**
     * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
     */
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    //    layer.frame = self.messageLabel.bounds;
    [self.contentView.layer addSublayer:gradientLayer];

    _share = [[UIImageView alloc]init];
    _share.contentMode = UIViewContentModeCenter;
    _share.image = [UIImage imageNamed: @"moreWhiteIcon"];
    _share.userInteractionEnabled = YES;
    [self.contentView addSubview:_share];
    
    _comment = [[UIImageView alloc]init];
    _comment.contentMode = UIViewContentModeCenter;
    _comment.image = [UIImage imageNamed:@"commentWhiteSmallVideo"];
    _comment.userInteractionEnabled = YES;
    [self.contentView addSubview:_comment];
    
    _commentNum = [[UILabel alloc]init];
    _commentNum.text = @"0";
    _commentNum.textColor = [UIColor whiteColor];//ColorWhite;
    _commentNum.font = [UIFont systemFontOfSize:12 ];//SmallFont;
    [self.contentView addSubview:_commentNum];
    _commentNum.layer.shadowColor = [[UIColor blackColor] CGColor];
    _commentNum.layer.shadowOpacity = 0.3;
    _commentNum.layer.shadowOffset = CGSizeMake(0, 1);
    
    _favorite = [FavoriteView new];
    [self.contentView addSubview:_favorite];
    
    _favoriteNum = [[UILabel alloc]init];
    _favoriteNum.text = @"0";
    _favoriteNum.textColor = [UIColor whiteColor];//ColorWhite;
    _favoriteNum.font = [UIFont systemFontOfSize:12 ];//SmallFont;
    [self.contentView addSubview:_favoriteNum];
    _favoriteNum.layer.shadowColor = [[UIColor blackColor] CGColor];
    _favoriteNum.layer.shadowOpacity = 0.3;
    _favoriteNum.layer.shadowOffset = CGSizeMake(0, 1);
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.textColor = kWhiteColor;
    _detailLabel.font = FONT_14;
    _detailLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    _detailLabel.layer.shadowOpacity = 0.3;
    _detailLabel.layer.shadowOffset = CGSizeMake(0, 1);
    _detailLabel.numberOfLines = 2;
    [self.contentView addSubview:_detailLabel];
    [self.contentView addSubview:_vipImageView];
    @STweakify(self);
    _favorite.clickBlock = ^(BOOL isChoose) {
        @STstrongify(self);
        [self favoriteOrDelVideo:isChoose];
    };
    [_avatar whenTapped:^{
        @STstrongify(self);
        [self pushToPersonalMessageVC];
    }];

    [_share whenTapped:^{
        @STstrongify(self);
        [self shareVideo];
    }];
    [_comment whenTapped:^{
        @STstrongify(self);
        [self commentVidieo];
    }];
    
    [_share mas_makeConstraints:^(MASConstraintMaker *make) {
        if(isIphoneX) {
            make.bottom.with.offset(-100 );
        } else {
            make.bottom.with.offset(-40 );
        }
        make.right.with.offset(-10 );
        make.width.mas_equalTo(50 );
        make.height.mas_equalTo(45 );
    }];
    [_comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.share.mas_top).with.offset(-25 );
        make.right.equalTo(self).with.offset(-10 );
        make.width.mas_equalTo(50 );
        make.height.mas_equalTo(45 );
    }];
    [_commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.comment.mas_bottom);
        make.centerX.equalTo(self.comment);
    }];
    [_favorite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.comment.mas_top).with.offset(-25 );
        make.right.equalTo(self).with.offset(-10 );
        make.width.mas_equalTo(50 );
        make.height.mas_equalTo(45 );
    }];
    [_favoriteNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.favorite.mas_bottom);
        make.centerX.equalTo(self.favorite);
    }];
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.width.mas_equalTo(Window_W-40);
        if(isIphoneX) {
            make.top.equalTo(self.contentView.mas_top).with.offset(NAVIGATION_BAR_HEIGHT+10);
        } else {
            make.top.equalTo(self.contentView.mas_top).with.offset(NAVIGATION_BAR_HEIGHT+10);
        }
    }];
    [self.contentView bringSubviewToFront:self.leftStackview];
    self.bottomMar.constant = TAB_BAR_HEIGHT+6;
    UIView *personView = [self.leftStackview viewWithTag:100];
    UIView *shop1View = [self.leftStackview viewWithTag:101];
    UIView *shop2View = [self.leftStackview viewWithTag:102];
    [shop2View addTapGestureWithTarget:self action:@selector(pushToPersonalMessageVC)];
    [shop1View addTapGestureWithTarget:self action:@selector(pushToPersonalMessageVC)];
    [personView addTapGestureWithTarget:self action:@selector(pushToPersonalMessageVC)];
    //init focus action
    _focus = [FocusView new];
    [self.contentView addSubview:_focus];
    [_focus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.avatar.mas_left).mas_offset(3);
        make.centerY.equalTo(self.avatar.mas_centerY);
        make.width.height.mas_equalTo(14);
    }];
//    [_focus whenTapped:^{
//        @STstrongify(self);
//        [self addConcern];
//    }];
//    [self.focus addTapGestureWithTarget:self action:@selector(addConcern)];
    [self.contentView bringSubviewToFront:self.liveIconBtn];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForReuse {
    [super prepareForReuse];
    [_favorite resetView];
    [_focus resetView];
}

- (void)setModel:(SmallVideoModel *)model {
    _model = model;
      self.nameLabel.text = model.name;
      CGFloat width = [model.name widthWithFont:FONT_14 constrainedToHeight:17];
      [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
          make.width.mas_equalTo(width);
      }];
      
      self.artistLabel.text = model.artist;
      self.detailLabel.text = @"最靓丽的视频就在这里，拍摄了几天，容摄了几摄了几众多";
      if(model.aspect >= 1.4) {
          self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
      } else {
          self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
      }
      
      [self.coverImageView sd_setImageWithURL:[NSURL URLWithString: model.cover_url]];
      [self.avatar sd_setImageWithURL:[NSURL URLWithString:model.head_url] placeholderImage:[UIImage imageNamed:STSystemDefaultImageName]];
//    if (model.rid == 1) {
//        self.focus.hidden = YES;
//        self.favorite.isChoose = YES;
//    } else {
        self.focus.hidden = NO;
        self.favorite.isChoose = NO;
//    }


    
    UIView *shop1View = [self.leftStackview viewWithTag:101];
    UIView *shop2View = [self.leftStackview viewWithTag:102];
    if (model.rid == 1) {
        shop1View.hidden = YES;
        shop2View.hidden = YES;
        self.liveIconBtn.hidden = YES;
//        self.grybbb.hidden = YES;
//        self.gryccc.hidden = YES;
//        [self.leftStackview removeArrangedSubview:shop1View];
//        [self.leftStackview removeArrangedSubview:shop2View];
//        [shop2View removeFromSuperview];
//        [shop1View removeFromSuperview];
    } else {
        shop1View.hidden = NO;
        shop2View.hidden = NO;
        self.liveIconBtn.hidden = NO;
//        UIView *shop1View = [self.leftStackview viewWithTag:101];
//        UIView *shop2View = [self.leftStackview viewWithTag:102];
//        self.grybbb.hidden = NO;
//        self.gryccc.hidden = NO;
//        [self.leftStackview addSubview:shop2View];
//        [self.leftStackview addSubview:shop1View];
//        [self.leftStackview insertArrangedSubview:shop2View atIndex:0];
//        [self.leftStackview insertArrangedSubview:shop1View atIndex:1];
    }
}

#pragma mark - Action

//关注
- (void)addConcern {
//    [[QYHTools sharedInstance] followBtnClick:[self.model.uid intValue] andButton:[UIButton new]];
    NSLog(@"点击了关注！1");
//    if([self.delegate respondsToSelector:@selector(handleAddConcerWithVideoModel:)]) {
//        [self.delegate handleAddConcerWithVideoModel:self.model];
//    }
}

//进入个人主页
- (void)pushToPersonalMessageVC {
    if ([self.delegate respondsToSelector:@selector(handleClickPersonIcon:)]) {
        [self.delegate handleClickPersonIcon:self.model];
    }
}

//收藏视频
- (void)favoriteOrDelVideo:(BOOL)choose {
    if([self.delegate respondsToSelector:@selector(handleFavoriteVdieoModel:)] && choose) {
        [self.delegate handleFavoriteVdieoModel:self.model ];
    } else if([self.delegate respondsToSelector:@selector(handleDeleteFavoriteVdieoModel:)] && !choose) {
        [self.delegate handleDeleteFavoriteVdieoModel:self.model];
    }
}

//评论
- (void)commentVidieo {
    if([self.delegate respondsToSelector:@selector(handleCommentVidieoModel:)]) {
        [self.delegate handleCommentVidieoModel:self.model];
    }
}

//分享
- (void)shareVideo {
    if([self.delegate respondsToSelector:@selector(handleShareVideoModel:)]) {
        [self.delegate handleShareVideoModel:self.model];
    }
}

- (void)dealloc {
    NSLog(@"销毁了");
}

@end
