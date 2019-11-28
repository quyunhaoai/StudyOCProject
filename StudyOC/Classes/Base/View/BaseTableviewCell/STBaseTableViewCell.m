//
//  STBaseTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseTableViewCell.h"

@implementation STBaseTableViewCell
+ (CGFloat)techHeightForOjb:(id)obj {
    return 0.f;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshData:(id)data {
    
}

#pragma mark -- 按钮点击

//- (void)shieldBtnClicked{
//    if(self.delegate && [self.delegate respondsToSelector:@selector(shieldBtnClicked:)]){
//        [self.delegate shieldBtnClicked:self.item];
//    }
//}

#pragma mark -- 计算视频时间字符、图片个数字符等宽度

//- (CGFloat)fetchNewsTipWidth{
//    if(self.item.newsTipWidth <= 0 ){
//        NSDictionary *dic = @{NSFontAttributeName:self.newsTipBtn.titleLabel.font};
//        CGSize size = [self.newsTipBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, newsTipBtnHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
//        self.item.newsTipWidth = size.width;
//    }
//    return self.item.newsTipWidth;
//}

#pragma mark -- @property

- (UIView *)bgView{
    if(!_bgView){
        _bgView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor clearColor];
            view ;
        });
    }
    return _bgView;
}

- (TYAttributedLabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = ({
            TYAttributedLabel *view = [TYAttributedLabel new];
            view.textColor = [UIColor kkColorWhite];
            view.font = FONT_14;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.numberOfLines = 0 ;
            view.backgroundColor = [UIColor clearColor];
            view ;
        });
    }
    return _titleLabel;
}

- (UILabel *)nameStringLabel {
    if (!_nameStringLabel) {
        _nameStringLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = [UIColor kkColorWhite];
            view.font = FONT_14;
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
            view.font = FONT_12;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.numberOfLines = 1;
            view ;
        });
    }
    return _subNameStringLabel;
}
- (UIButton *)leftBtn{
    if(!_leftBtn){
        _leftBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            view.titleLabel.font = [UIFont systemFontOfSize:7];
            view.layer.borderWidth = 0.3;
            view.layer.cornerRadius = 2.0;
            view.layer.masksToBounds = YES ;
            view ;
        });
    }
    return _leftBtn;
}

- (UILabel *)descLabel{
    if(!_descLabel){
        _descLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = [UIColor colorWithRed:175.0f/255.0f green:175.0f/255.0f blue:177.0f/255.0f alpha:1.0f];
            view.font = FONT_11;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
            view ;
        });
    }
    return _descLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel =  ({
            UILabel *view = [UILabel new];
            view.textColor = color_textBg_C7C7D1;
            view.font = FONT_10;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.layer.masksToBounds = YES;
            view.layer.cornerRadius = 1;
            view ;
        });
    }
    return _stateLabel;
}

- (UIButton *)rightBtn{
    if(!_rightBtn){
        _rightBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
//            [view setTitleColor:kBlackColor forState:UIControlStateNormal];
            [view setImage:[UIImage imageNamed:@"more_home"] forState:UIControlStateNormal];
            [view addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _rightBtn;
}

- (UIButton *)withdrawButton {
    if (!_withdrawButton) {
        _withdrawButton = ({
               UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
               btn.backgroundColor = COLOR_HEX_RGB(0x3A3A44);
               [btn setTitleColor:color_textBg_C7C7D1 forState:UIControlStateNormal];
               [btn setTitle:@"撤销" forState:UIControlStateNormal];
               [btn setImage:IMAGE_NAME(@"withdarw") forState:UIControlStateNormal];
               btn.titleLabel.font = FONT_11 ;
               btn.layer.masksToBounds = YES ;
               [btn addTarget:self action:@selector(withdrawAction:) forControlEvents:UIControlEventTouchUpInside];
               [btn setEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitlePadding:30];
               btn ;
           });
    }
    return _withdrawButton;
}
- (UIButton *)newsTipBtn{
    if(!_newsTipBtn){
        _newsTipBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
            btn.titleLabel.font = FONT_10 ;
            btn.layer.masksToBounds = YES ;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn ;
        });
    }
    return _newsTipBtn;
}

- (UIButton *)playVideoBtn{
    if(!_playVideoBtn){
        _playVideoBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setImage:[UIImage imageNamed:@"new_play_video_60x60_"] forState:UIControlStateNormal];
            [view setUserInteractionEnabled:YES];
            [view setTag:BUTTON_TAG(100)];
            [view addTarget:self action:@selector(withdrawAction:) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _playVideoBtn;
}

- (UIView *)splitView{//s分割线
    if(!_splitView){
        _splitView = ({
            UIView *view = [UIView new];
            view.backgroundColor = KKColor(244, 245, 246, 1.0);;
            view ;
        });
    }
    return _splitView;
}

- (UIImageView *)headerIconView {
    if (!_headerIconView) {
        _headerIconView =  ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            ViewBorderRadius(view, 4, 2, [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:209.0f/255.0f alpha:1.0f]);
//            ViewBorder(view, [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:209.0f/255.0f alpha:1.0f], 2);
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
- (UIImageView *)coverView {
    if (!_coverView) {
        _coverView = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            view.layer.borderWidth = 0.5;
            view.layer.borderColor = [[UIColor grayColor]colorWithAlphaComponent:0.1].CGColor;
            view;
        });
    }
    return _coverView;
}

- (UIImageView *)coverBgView {
    if (!_coverView) {
        _coverView =  ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            view;
        });
    }
    return _coverView;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel =  ({
            UILabel *view = [UILabel new];
            view.textColor = color_text_AFAFB1;
            view.font = FONT_11;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
    }
    return _commentLabel;
}

-(UILabel *)videoTimeLabel {
    if (!_videoTimeLabel) {
        _videoTimeLabel =   ({
            UILabel *view = [UILabel new];
            view.textColor = [UIColor whiteColor];
            view.font = FONT_12;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentCenter;
            view ;
        });
    }
    return _videoTimeLabel;
}

+ (CGFloat)fetchHeightWithObj:(id)obj {
    return 0;
}

- (void)moreBtnClicked:(UIButton *)button {
    
}
- (void)withdrawAction:(UIButton *)button {
    
}
@end
