//
//  STBaseTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/20.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STBaseTableViewCell.h"

@implementation STBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//+ (CGFloat)fetchHeightWithItem:(KKSummaryContent *)item{
//    return 0 ;
//}

//- (void)refreshWithItem:(KKSummaryContent *)item{
//
//}

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
            view.textColor = [UIColor kkColorBlack];
            view.font = FONT_14;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.numberOfLines = 0 ;
            view.backgroundColor = [UIColor clearColor];
            view ;
        });
    }
    return _titleLabel;
}

- (TYAttributedLabel *)nameStringLabel {
    if (!_subNameStringLabel) {
        _nameStringLabel = ({
            TYAttributedLabel *view = [TYAttributedLabel new];
            view.textColor = [UIColor kkColorBlack];
            view.font = FONT_14;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.numberOfLines = 1;
            view ;
        });
    }
    return _nameStringLabel;
}
- (TYAttributedLabel *)subNameStringLabel {
    if (!_subNameStringLabel) {
        _subNameStringLabel = ({
            TYAttributedLabel *view = [TYAttributedLabel new];
            view.textColor = [UIColor kkColorLightgray];
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
            view.textColor = [UIColor kkColorLightgray];
            view.font = FONT_10;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
    }
    return _descLabel;
}

- (UILabel *)stateLabel {
    if (!_stateLabel) {
        _stateLabel =  ({
            UILabel *view = [UILabel new];
            view.textColor = [UIColor kkColorLightgray];
            view.font = FONT_10;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view ;
        });
    }
    return _stateLabel;
}

- (UIButton *)rightBtn{
    if(!_rightBtn){
        _rightBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitleColor:kBlackColor forState:UIControlStateNormal];
//            [view setImage:[UIImage imageNamed:@"shield"] forState:UIControlStateNormal];
//            [view addTarget:self action:@selector(shieldBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            view ;
        });
    }
    return _rightBtn;
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
            [view setImage:[UIImage imageNamed:@"video_play_icon_44x44_"] forState:UIControlStateNormal];
            [view setUserInteractionEnabled:NO];
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
            view;
        });
    }
    return _headerIconView;
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
            view.textColor = [UIColor kkColorLightgray];
            view.font = FONT_10;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
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
            view.font = FONT_10;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentRight;
            view ;
        });
    }
    return _videoTimeLabel;
}


@end
