//
//  KKRelateVideoCell.m
//  KKToydayNews
//
//  Created by finger on 2017/9/17.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKRelateVideoCell.h"
#define newsTipBtnHeight 15
#define descLabelHeight 20
#define leftBtnSize CGSizeMake(20,11)
#define space 5.0
#define imageWidth ((([UIScreen mainScreen].bounds.size.width - 2 * kkPaddingNormal) - 2 * space) / 3.0)
#define KKTitleWidth ([UIScreen mainScreen].bounds.size.width - 3 * kkPaddingNormal - imageWidth)

@interface KKRelateVideoCell ()
@property(nonatomic,strong)UIImageView *smallImgView ;
@property(nonatomic)UIView *splitViewBottom;
@property (nonatomic,strong) UIButton *followButton; //  按钮
@end

@implementation KKRelateVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBackgroundColor:color_viewBG_1A1929];
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.smallImgView];
    [self.bgView addSubview:self.descLabel];
    [self.bgView addSubview:self.headerIconView];
    [self.bgView addSubview:self.nameStringLabel];
    [self.bgView addSubview:self.subNameStringLabel];
    [self.bgView addSubview:self.rightBtn];
    [self.bgView addSubview:self.followButton];
    [self addSubview:self.splitViewBottom];
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.smallImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).mas_offset(kkPaddingNormal);
        make.left.mas_equalTo(self.bgView).mas_offset(kkPaddingNormal);
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(3 * FONT_18.lineHeight + 5);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.smallImgView).mas_offset(space-5);
        make.left.mas_equalTo(self.smallImgView.mas_right).mas_offset(kkPaddingNormal);
        make.width.mas_equalTo(KKTitleWidth);
        make.height.mas_equalTo(2 * FONT_14.lineHeight + 2 * 3);
    }];
    [self.headerIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(2.5);
        make.width.height.mas_equalTo(30);
    }];
    [self.nameStringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView.mas_right).mas_offset(kkPaddingSmall);
        make.top.mas_equalTo(self.headerIconView);
        make.width.mas_equalTo(Window_W * 0.4);
        make.height.mas_equalTo(16);
    }];
    [self.subNameStringLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerIconView.mas_right).mas_offset(kkPaddingSmall);
        make.top.mas_equalTo(self.nameStringLabel.mas_bottom);
        make.width.mas_equalTo(Window_W * 0.3);
        make.height.mas_equalTo(16);
    }];
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.subNameStringLabel.mas_right).mas_offset(kkPaddingSmall);
        make.centerY.mas_equalTo(self.subNameStringLabel);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(16);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headerIconView);
        make.right.mas_equalTo(self.bgView).mas_offset(-kkPaddingNormal);
    }];
    [self.splitViewBottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    [self.rightBtn setImage:IMAGE_NAME(@"ad_more_icon") forState:UIControlStateNormal];
    
    ViewBorderRadius(self.headerIconView, 15, 2, KKColor(199, 199, 209, 1.0));
    self.nameStringLabel.font = FONT_10;
    self.subNameStringLabel.font = FONT_10;
}
- (void)refreshData:(STVideoChannelModl *)data {
    [self.smallImgView yy_setImageWithURL:[NSURL URLWithString:data.video_thumb] placeholder:STImageViewDefaultImageMacro];
    self.titleLabel.text = data.video_title;
    [self.headerIconView sd_setImageWithURL:[NSURL URLWithString:data.headimg] placeholderImage:STImageViewDefaultImageMacro];
    self.nameStringLabel.text = data.nickname;
    self.subNameStringLabel.text = data.zuozhe_desc;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (CGFloat)techHeightForOjb:(id)obj {
    return 2 * kkPaddingLarge + 3 * FONT_18.lineHeight + 3 * 3 -10;
}
#pragma mark -- 初始化标题文本

//+ (void)initAttriTextData:(KKSummaryContent *)content{
//    if(content.textContainer == nil ){
//        TYTextContainer *item = [TYTextContainer new];
//        item.linesSpacing = 2 ;
//        item.textColor = [UIColor kkColorBlack];
//        item.lineBreakMode = NSLineBreakByTruncatingTail;
//        item.text = content.title;
//        item.font = KKTitleFont ;
//        item.numberOfLines = 2;
//        content.textContainer = [item createTextContainerWithTextWidth:KKTitleWidth];
//    }
//}

#pragma mark -- @property

- (UIImageView *)smallImgView{
    if(!_smallImgView){
        _smallImgView = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            view.layer.cornerRadius = 4;
//            @STweakify(view);
//            @STweakify(self);
            [view addTapGestureWithBlock:^(UIView *gestureView) {
//                @STstrongify(view);
//                @STstrongify(self);
//                if(self.delegate && [self.delegate respondsToSelector:@selector(clickImageWithItem:rect:fromView:image:indexPath:)]){
//                    [self.delegate clickImageWithItem:self.item rect:view.frame fromView:self.bgView image:view.image indexPath:nil];
//                }
            }];
            view ;
        });
    }
    return _smallImgView;
}
- (UIView *)splitViewBottom{
    if(!_splitViewBottom){
        _splitViewBottom = ({
            UIView *view = [UIView new];
            view.backgroundColor = KKColor(35, 34, 48, 1.0);;
            view ;
        });
    }
    return _splitViewBottom;
}
- (UIButton *)followButton {
    if (!_followButton) {
        _followButton = ({
          UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
          [view setTitle:@"已关注" forState:UIControlStateNormal];
          [view.titleLabel setFont:FONT_10];
          view.layer.cornerRadius = 8;
          view.layer.masksToBounds = YES;
          view.layer.backgroundColor = [[UIColor colorWithRed:58.0f/255.0f green:58.0f/255.0f blue:68.0f/255.0f alpha:1.0f] CGColor];
          view.alpha = 1;
          [view setUserInteractionEnabled:YES];
//          [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
          view ;
            
            
        });
    }
    return _followButton;
}
@end
