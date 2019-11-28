//
//  SmallVideoPlayCell.m
//  RingtoneDuoduo
//
//  Created by 唐天成 on 2019/1/5.
//  Copyright © 2019年 duoduo. All rights reserved.
//

#import "SmallVideoPlayCell.h"
#import "FavoriteView.h"
//#import "ReactiveCocoa.h"


@interface SmallVideoPlayCell ()

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UIImageView *share;
@property (nonatomic, strong) UILabel *shareNum;

@property (nonatomic, strong) UIImageView *comment;
@property (nonatomic, strong) UILabel *commentNum;

@property (nonatomic, strong) FavoriteView *favorite;
@property (nonatomic, strong) UILabel *favoriteNum;

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UIButton *focus;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *artistLabel;
@property (strong, nonatomic) UILabel *detailLabel; //  标签
@property (strong, nonatomic) UIImageView *vipImageView; //  图片

@end

@implementation SmallVideoPlayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
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
        
        _avatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        [_avatar createBordersWithColor:[UIColor whiteColor] withCornerRadius:2  andWidth:1];
        _avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatar];
        
        _focus = [UIButton buttonWithType:UIButtonTypeCustom];
        _focus.backgroundColor = RGBA(222, 67, 88, 1);
        [_focus setBackgroundColor:color_tipFeng_FF2190];
        ViewRadius(_focus, 2);
        [_focus setTitle:@"+关注" forState:UIControlStateNormal];
        [_focus setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_focus.titleLabel setFont:FONT_10];
        [self.contentView addSubview:_focus];
        
        _artistLabel = [[UILabel alloc] init];
        _artistLabel.textColor = RGBA(255, 255, 255, 1);
        _artistLabel.font = [UIFont systemFontOfSize:12];
        _artistLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        _artistLabel.layer.shadowOpacity = 0.3;
        _artistLabel.layer.shadowOffset = CGSizeMake(0, 1);
        [self.contentView addSubview:_artistLabel];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.numberOfLines = 0;
        _nameLabel.textColor = RGBA(255, 255, 255, 1);;//RGBA(165, 165, 165, 1);
        _nameLabel.font = FONT_14;
        _nameLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        _nameLabel.layer.shadowOpacity = 0.3;
        _nameLabel.layer.shadowOffset = CGSizeMake(0, 1);
        [self.contentView addSubview:_nameLabel];
        
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
        [_focus whenTapped:^{
            @STstrongify(self);
            [self addConcern];
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
        [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.with.offset(15);
            if(isIphoneX) {
                make.top.equalTo(self.contentView.mas_bottom).with.offset(-(193  - 10 ));
            } else {
                make.top.equalTo(self.contentView.mas_bottom).with.offset(-193 );
            }
            make.width.height.mas_equalTo(50 );
        }];
        [_vipImageView masMakeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(self.avatar).mas_offset(3);
            make.width.height.mas_equalTo(16);
        }];
        [_artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(75);
            make.width.mas_equalTo(Window_W*0.6);
            make.height.mas_equalTo(19);
            make.top.mas_equalTo(self.avatar.mas_centerY).offset(2);
        }];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.with.offset(75);
            make.width.mas_equalTo(15);
            make.top.equalTo(_avatar.mas_top).with.offset(1);
        }];
        [_focus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(18);
            make.left.equalTo(self.nameLabel.mas_right).mas_offset(10);
            make.centerY.equalTo(self.nameLabel.mas_centerY);
        }];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.width.mas_equalTo(Window_W-80);
            if(isIphoneX) {
                make.top.equalTo(self.contentView.mas_bottom).with.offset(-(133-5));
            } else {
                make.top.equalTo(self.contentView.mas_bottom).with.offset(-133);
            }
        }];
    }
    return self;
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
  
    self.focus.hidden = NO;
    self.favorite.isChoose = NO;
    
}
- (UIImageView *)vipImageView {
    if (!_vipImageView) {
        _vipImageView =  ({
                   UIImageView *view = [UIImageView new];
                   view.contentMode = UIViewContentModeScaleAspectFill ;
                   view.hidden = YES ;
                   view.userInteractionEnabled = YES ;
                   [view setImage:IMAGE_NAME(@"vip_home_headIcon")];
                   view;
               });
    }
    return _vipImageView;
}
#pragma mark - Action

//关注
- (void)addConcern {
    
    if([self.delegate respondsToSelector:@selector(handleAddConcerWithVideoModel:)]) {
        [self.delegate handleAddConcerWithVideoModel:self.model];
    }
}

//进入个人主页
- (void)pushToPersonalMessageVC {
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
