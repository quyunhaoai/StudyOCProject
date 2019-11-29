//
//  KKNewsCommentCell.m
//  KKToydayNews
//
//  Created by finger on 2017/9/21.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKNewsCommentCell.h"
#import "KKAttributeTextView.h"
#import "TYAttributedLabel.h"
#import "ImageTitleButton.h"
#define HorizSpace 8
#define VeritSpace 5
#define ImageWH 35
#define TextViewWidth (Window_W - 2 * kkPaddingNormal - HorizSpace - ImageWH)
#define replayTextWidth (TextViewWidth - 2 * kkPaddingNormal)
#define LabelHeight 20
#define ButtonHeight 25
#define LineSpace 5 //文字的上下间距

#define commentTextFont [UIFont systemFontOfSize:(iPhone5)?15:16]
#define replyFont [UIFont systemFontOfSize:14]

#define MaxReplyCount 5

@interface KKNewsCommentCell()<TYAttributedLabelDelegate>
@property(nonatomic)UIView *bgView;
@property(nonatomic)UIImageView *headImageView;
@property(nonatomic)UILabel *nameLabel;
@property(nonatomic)ImageTitleButton *diggBtn;
@property(nonatomic)TYAttributedLabel *commentTexyView;
@property(nonatomic)UILabel *createTimeLabel;
@property(nonatomic)UILabel *totalCommentLabel;
//@property(nonatomic)UIView *replayView;
@property (nonatomic, assign) CTFrameRef  frameRef;
//@property(nonatomic,weak)KKCommentItem *item ;
//@property(nonatomic,weak)KKCommentObj *obj ;

@end

@implementation KKNewsCommentCell

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
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)dealloc{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

#pragma mark -- 设置UI

- (void)setupUI{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.headImageView];
    [self.bgView addSubview:self.diggBtn];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.commentTexyView];
    [self.bgView addSubview:self.createTimeLabel];
    [self.bgView addSubview:self.totalCommentLabel];
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
    
    [self.headImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(kkPaddingNormal);
        make.top.mas_equalTo(self.bgView).mas_offset(kkPaddingNormal);
        make.size.mas_equalTo(CGSizeMake(ImageWH, ImageWH));
    }];
    
    [self.diggBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).mas_offset(-kkPaddingNormal);
        make.top.mas_equalTo(self.headImageView.mas_centerY).mas_offset(-2);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(40);
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.headImageView.mas_centerY).mas_offset(-2);
        make.left.mas_equalTo(self.headImageView.mas_right).mas_offset(HorizSpace);
        make.right.mas_equalTo(self.diggBtn.mas_left).mas_offset(-HorizSpace);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    [self.commentTexyView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(VeritSpace);
        make.width.mas_equalTo(TextViewWidth);
        make.height.mas_equalTo(0);
    }];
    
    [self.createTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentTexyView.mas_right).mas_equalTo(VeritSpace);
        make.top.mas_equalTo(self.commentTexyView).mas_offset(2);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    [self.totalCommentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.createTimeLabel.mas_right).mas_offset(HorizSpace);
        make.centerY.mas_equalTo(self.createTimeLabel);
        make.height.mas_equalTo(ButtonHeight);
        make.width.mas_equalTo(0);
    }];

    [self setData];
}
- (void)setData {
    [self.headImageView setImage:IMAGE_NAME(STSystemDefaultImageName)];
    self.nameLabel.text = @"美美";
    TYTextContainer *data = [TYTextContainer new];
    data.font = commentTextFont;
    data.linesSpacing = LineSpace ;
    data.textColor = [UIColor whiteColor];
    data.text = @"搞笑视频自媒体团体";
    data.numberOfLines = 6 ;
    data.isWidthToFit = YES;
    data.lineBreakMode = NSLineBreakByTruncatingTail;
    [data createTextContainerWithTextWidth:TextViewWidth];
    self.commentTexyView.textContainer = data;
    [self.commentTexyView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(data.attriTextHeight);
        make.width.mas_equalTo(data.attriTextWidth);
    }];
    
    self.createTimeLabel.text = @"22:11";
    [self.diggBtn setTitle:@"80" forState:UIControlStateNormal];
}

- (UILabel *)createShowAllLabel{
    UILabel *view = [UILabel new];
    view.font = replyFont;
    view.textColor = KKColor(25, 93, 157, 1);;
    view.lineBreakMode = NSLineBreakByTruncatingTail;
    view.textAlignment = NSTextAlignmentLeft;
    view.width = replayTextWidth;
    view.userInteractionEnabled = YES ;
    
//    @weakify(self);
//    [view addTapGestureWithBlock:^(UIView *gestureView) {
//        @strongify(self);
//        if(self.delegate && [self.delegate respondsToSelector:@selector(showAllComment:)]){
//            [self.delegate showAllComment:self.item.comment.Id];
//        }
//    }];
    return view ;
}

#pragma mark -- TYAttributedLabelDelegate

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point{
    if ([TextRun isKindOfClass:[TYLinkTextStorage class]]) {
        id linkStr = ((TYLinkTextStorage*)TextRun).linkData;
        if ([linkStr isKindOfClass:[NSString class]]) {
            if(self.delegate && [self.delegate respondsToSelector:@selector(jumpToUserPage:)]){
                [self.delegate jumpToUserPage:linkStr];
            }
        }
    }
}

#pragma mark -- @property getter

- (UIView *)bgView{
    if(!_bgView){
        _bgView = ({
            UIView *view = [UIView new];
            view ;
        });
    }
    return _bgView;
}

- (UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.userInteractionEnabled = YES ;
            view.clipsToBounds = YES;
            view.layer.cornerRadius = ImageWH/2;
//            @weakify(self);
//            [view addTapGestureWithBlock:^(UIView *gestureView) {
//                @strongify(self);
//                if(self.delegate && [self.delegate respondsToSelector:@selector(jumpToUserPage:)]){
//                    NSString *userId = self.item.comment.user_id;
//                    if(!userId.length){
//                        userId = self.obj.user.user_id;
//                    }
//                    NSString *mediaId = self.item.comment.media_info.media_id;
//                    if(!mediaId.length){
//                        mediaId = self.obj.media_info.media_id;
//                    }
//                    [self.delegate jumpToUserPage:userId];
//                }
//            }];
//
            view ;
        });
    }
    return _headImageView;
}

- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = ({
            UILabel *view = [UILabel new];
            view.textColor = color_textBg_C7C7D1;
            view.textAlignment = NSTextAlignmentLeft;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.font = [UIFont systemFontOfSize:14];
            view.userInteractionEnabled = YES ;
         
//            @weakify(self);
//            [view addTapGestureWithBlock:^(UIView *gestureView) {
//                @strongify(self);
//                if(self.delegate && [self.delegate respondsToSelector:@selector(jumpToUserPage:)]){
//                    NSString *userId = self.item.comment.user_id;
//                    if(!userId.length){
//                        userId = self.obj.user.user_id;
//                    }
//                    NSString *mediaId = self.item.comment.media_info.media_id;
//                    if(!mediaId.length){
//                        mediaId = self.obj.media_info.media_id;
//                    }
//                    [self.delegate jumpToUserPage:userId];
//                }
//            }];
            
            view;
        });
    }
    return _nameLabel;
}

- (ImageTitleButton *)diggBtn{
    if(!_diggBtn){
        _diggBtn = ({
            ImageTitleButton *view = [ImageTitleButton buttonWithType:UIButtonTypeCustom];
            [view setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateNormal];
            [view setImage:[UIImage imageNamed:@"like_icon_video"] forState:UIControlStateSelected];
            [view.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [view.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [view setTitleColor:color_textBg_C7C7D1 forState:UIControlStateNormal];
            [view setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            view.style = EImageTopTitleBottom;
//            @weakify(self);
//            [view addTapGestureWithBlock:^(UIView *gestureView) {
//                @strongify(self);
//                if(self.delegate && [self.delegate respondsToSelector:@selector(diggBtnClick:callback:)]){
//                    @weakify(self);
//                    [self.delegate diggBtnClick:self.item.comment.Id callback:^(BOOL suc) {
//                        @strongify(self);
//                        self.diggBtn.selected = suc ;
//                    }];
//                }
//            }];
            
            view ;
        });
    }
    return _diggBtn;
}

- (TYAttributedLabel *)commentTexyView{
    if(!_commentTexyView){
        _commentTexyView = ({
            TYAttributedLabel *view = [TYAttributedLabel new];
            view.textColor = KKColor(240, 240, 219, 1.0);
            view.font = commentTextFont;
            view.numberOfLines = 0 ;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.textAlignment = NSTextAlignmentLeft;
            view.backgroundColor = [UIColor clearColor];
            view.delegate = self ;
            view ;
        });
    }
    return _commentTexyView;
}

- (UILabel *)createTimeLabel{
    if(!_createTimeLabel){
        _createTimeLabel = ({
            UILabel *view = [UILabel new];
            view.font = [UIFont systemFontOfSize:14];
            view.textColor = color_textBg_C7C7D1;
            view.textAlignment = NSTextAlignmentLeft;
            view;
        });
    }
    return _createTimeLabel;
}

- (UILabel *)totalCommentLabel{
    if(!_totalCommentLabel){
        _totalCommentLabel = ({
            UILabel *view = [UILabel new];
            view.font = [UIFont systemFontOfSize:12];
            view.textColor = KKColor(40, 40, 40, 1.0);
            view.textAlignment = NSTextAlignmentCenter;
            view.backgroundColor = KKColor(244, 245, 246, 1.0);
            view.layer.masksToBounds = YES ;
            view.layer.cornerRadius = ButtonHeight / 2.0 ;
            view;
        });
    }
    return _totalCommentLabel;
}

@end
