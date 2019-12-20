//
//  KKVideoInfoView.m
//  KKToydayNews
//
//  Created by finger on 2017/10/7.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKVideoInfoView.h"
#import "KKButton.h"

#define space 5
#define ShowMoreWH 20
#define LabelHeight 20
#define ButtonWH 0
#define VeritSpace 10
#define TitleWidth (Window_W - 2 * kkPaddingNormal - ShowMoreWH - space)

@interface KKVideoInfoView ()
@property(nonatomic)UILabel *titleLabel;
@property(nonatomic)UIImageView *showMoreLabel;
@property(nonatomic)UILabel *showMoreMask;
@property(nonatomic)UIView *descView;
@property(nonatomic)UILabel *descLabel;
@property(nonatomic)UIView *splitViewBottom;

@property(nonatomic,assign)BOOL showDescView;
@property(nonatomic,assign)CGFloat titleHeight;
@property(nonatomic,assign)CGFloat descViewHeight;
@property (strong, nonatomic) UIView *tagView; //  视图

@end

@implementation KKVideoInfoView

- (instancetype)init{
    self = [super init];
    if(self){
        [self initUI];
    }
    return self ;
}

- (void)initUI{
    self.backgroundColor = color_viewBG_1A1929;
    [self addSubview:self.titleLabel];
    [self addSubview:self.showMoreLabel];
    [self addSubview:self.showMoreMask];
    [self addSubview:self.descView];
    [self.descView addSubview:self.descLabel];
    [self addSubview:self.splitViewBottom];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kkPaddingSmall);
        make.left.mas_equalTo(self).mas_offset(kkPaddingNormal);
        make.width.mas_equalTo(TitleWidth);
        make.height.mas_equalTo(0);
    }];
    
    [self.showMoreLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-kkPaddingNormal);
        make.top.mas_equalTo(self.titleLabel).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(16, 8));
    }];

    [self.showMoreMask mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.descView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(VeritSpace);
        make.height.mas_equalTo(0);
    }];
    
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descView.mas_top);
        make.left.mas_equalTo(self).mas_offset(kkPaddingNormal);
        make.height.mas_equalTo(0);
        make.width.mas_equalTo(self.descView).mas_offset(-2 * kkPaddingNormal).priority(998);
    }];
    
    [self.splitViewBottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(5.0);
    }];
    
    [self addSubview:self.moreButton];
    [self addSubview:self.likeBtn];
    [self addSubview:self.likeLabel];
    [self addSubview:self.commentButton];
    [self addSubview:self.commentLabel];
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(Window_W*0.4);
        make.bottom.mas_equalTo(self).mas_offset(-kkPaddingLarge);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
    }];
    [self.moreButton layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeftRight imageTitleSpace:5];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.moreButton.mas_right).mas_offset(kkPaddingNormalLarge);
        make.centerY.mas_equalTo(self.moreButton);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.likeBtn.mas_right).mas_offset(kkPaddingSmall);
        make.centerY.mas_equalTo(self.moreButton);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(15);
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.likeLabel.mas_right).mas_offset(kkPaddingNormalLarge);
       make.centerY.mas_equalTo(self.moreButton);
       make.width.mas_equalTo(25);
       make.height.mas_equalTo(25);
    }];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentButton.mas_right).mas_offset(kkPaddingSmall);
        make.centerY.mas_equalTo(self.moreButton);
        make.right.mas_equalTo(self).mas_offset(-kkPaddingNormalLarge);
        make.height.mas_equalTo(15);
    }];
    [self addSubview:self.tagView];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(0);
        make.bottom.mas_equalTo(self).mas_offset(-kkPaddingLarge);
        make.width.mas_equalTo(Window_W*0.4);
        make.height.mas_equalTo(25);
    }];
}

- (UIView *)tagView {
    if (!_tagView) {
        _tagView = [UIView new];
    }
    return _tagView;
}

- (void)setTagArray:(NSArray *)tagArray {
    _tagArray = tagArray;
    for (UIView *vvv in self.tagView.subviews) {
        [vvv removeFromSuperview];
    }
    if (!_tagArray.count) {
        return;
    }
    CGRect _lastFrame=CGRectMake(0, 5, 0, 0);
    int x = 1;
    for (int i=0; i<_tagArray.count; i++) {
        UIButton *tipBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        tipBtn.tag = i;
        [tipBtn setBackgroundColor: COLOR_HEX_RGB(0x3A3A44)];
        NSString *title = _tagArray[i];
        if ([title containsString:@"#"]) {
            [tipBtn setTitleColor:COLOR_HEX_RGB(0xFFE95D) forState:UIControlStateNormal];
        } else {
            [tipBtn setTitleColor:color_textBg_C7C7D1 forState:UIControlStateNormal];
        }
        tipBtn.titleLabel.font = FONT_10;
        [tipBtn setTitle:title
                forState:UIControlStateNormal];
        [tipBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        CGSize size = [_tagArray[i] sizeWithAttributes:@{NSFontAttributeName:tipBtn.titleLabel.font}];
        tipBtn.frame = CGRectMake(CGRectGetMaxX(_lastFrame) + 10,
                                  CGRectGetMinY(_lastFrame),
                                  size.width + 20,
                                  size.height+ 5);
        ViewRadius(tipBtn,(size.height+ 5)/2);
        _lastFrame=tipBtn.frame;
        if (x<=1) {
            [self.tagView addSubview:tipBtn];
        }
    }
}

- (void)clickBtn:(UIButton *)button {
    STSearchView *searchVC = [[STSearchView alloc] initWithFrame:CGRectMake(0, 0, Window_W, Window_H)];
//    searchVC.currentViewController = self;
    [[UIApplication sharedApplication].keyWindow addSubview:searchVC];
    [UIView animateWithDuration:0.3 animations:^{
        searchVC.alpha = 1.0;
        searchVC.frame = CGRectMake(0, 0, Window_W, Window_H);
    } completion:nil];
}
#pragma mark -- @property setter

- (void)setTitle:(NSString *)title{
    _title = title;
    NSDictionary *dic = @{NSFontAttributeName:self.titleLabel.font};
    CGSize size = [title boundingRectWithSize:CGSizeMake(TitleWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    if(size.height > 2 * self.titleLabel.font.lineHeight){
        size.height = 2 * self.titleLabel.font.lineHeight ;
    }
    self.titleHeight = size.height + 0;
    self.titleLabel.text = _title;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.titleLabel.font.lineHeight);
    }];
}

- (void)setDescText:(NSString *)descText{
    _descText = descText;
    NSDictionary *dic = @{NSFontAttributeName:self.descLabel.font};
    CGSize size = [descText boundingRectWithSize:CGSizeMake(TitleWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.descViewHeight = size.height + LabelHeight + 15;
    self.descLabel.text = descText;
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height + 5);
    }];
}

- (void)setShowDescView:(BOOL)showDescView{
    _showDescView = showDescView;
    CGFloat height = 0 ;
    if(showDescView){
        height = self.descViewHeight;
    }
    [self.descView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    if(self.changeViewHeight){
        self.changeViewHeight(showDescView ? self.height + self.descViewHeight : self.height - self.descViewHeight);
    }
}

#pragma mark -- @property getter

- (CGFloat)viewHeight{
    [self layoutIfNeeded];
    if(self.showDescView){
        return self.titleHeight + LabelHeight + VeritSpace + self.descViewHeight + ButtonWH + 2 * kkPaddingNormal;
    }else{
        return self.titleHeight + LabelHeight + VeritSpace + ButtonWH + 2 * kkPaddingNormal;
    }
    return 0;
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = [UIColor whiteColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.numberOfLines = 0 ;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.font = [UIFont systemFontOfSize:14];
            view;
        });
    }
    return _titleLabel;
}

- (UIImageView *)showMoreLabel{
    if(!_showMoreLabel){
        _showMoreLabel = ({
            UIImageView *view = [UIImageView new];
            view.image = IMAGE_NAME(@"locationWhiteIcon");
            view;
        });
    }
    return _showMoreLabel;
}

- (UILabel *)showMoreMask{
    if(!_showMoreMask){
        _showMoreMask = ({
            UILabel *view = [UILabel new];
            view.userInteractionEnabled = YES ;

            @STweakify(self);
            [view addTapGestureWithBlock:^(UIView *gestureView) {
                @STstrongify(self);
                self.showDescView = !self.showDescView;
                if(self.showDescView){
                    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(self.titleHeight);
                    }];
                }else{
                    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(self.titleLabel.font.lineHeight);
                    }];
                }
                CGAffineTransform transform = CGAffineTransformRotate(self.showMoreLabel.transform,M_PI);
                [UIView beginAnimations:@"rotate" context:nil ];
                [UIView setAnimationDuration:0.2];
                [UIView setAnimationDelegate:self];
                [self.showMoreLabel setTransform:transform];
                [UIView commitAnimations];
            }];
            view;
        });
    }
    return _showMoreMask;
}

- (UIView *)descView{
    if(!_descView){
        _descView = ({
            UIView *view = [UIView new];
            view.layer.masksToBounds = YES ;
            view ;
        });
    }
    return _descView;
}

- (UILabel *)descLabel{
    if(!_descLabel){
        _descLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = [UIColor grayColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.lineBreakMode = NSLineBreakByCharWrapping;
            view.font = [UIFont systemFontOfSize:14];
            view.numberOfLines = 0 ;
            view;
        });
    }
    return _descLabel;
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

- (KKButton *)moreButton {
    if (!_moreButton) {
        _moreButton = ({
            KKButton *view = [KKButton buttonWithType:UIButtonTypeCustom];
            [view setTitleColor:color_textBg_C7C7D1 forState:UIControlStateNormal];
            [view setImage:[UIImage imageNamed:@"more_home"] forState:UIControlStateNormal];
            [view setTitle:@"更多" forState:UIControlStateNormal];
            [view.titleLabel setFont:FONT_10];
            [view addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [view layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeftRight imageTitleSpace:5];
            view ;
        });
    }
    return _moreButton;
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
        }
        else {
            [sender popInsideWithDuration:0.4];
            [sender setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
        }
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

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel =({
            UILabel *view = [UILabel new];
            view.textColor = KKColor(214, 216, 228, 1.0);
            view.font = FONT_14;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
    }
    return _commentLabel;
}

#pragma mark  -  moreBtnClick
- (void)moreBtnClicked:(KKButton *)button {
    
}
@end
