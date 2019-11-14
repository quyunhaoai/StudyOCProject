//
//  STTextSinglegraphTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/18.
//  Copyright © 2019 研学旅行. All rights reserved.
//
#define space 5.0
#define imageWidth ((([UIScreen mainScreen].bounds.size.width - 2 * kkPaddingNormal) - 2 * space) / 3.0)
#define KKTitleWidth ([UIScreen mainScreen].bounds.size.width - 3 * kkPaddingNormal - imageWidth)
#define LineSpace 3
#import "STTextSinglegraphTableViewCell.h"
@interface STTextSinglegraphTableViewCell ()
@property (strong, nonatomic) UIImageView *smallImgView; //  视图

@end
@implementation STTextSinglegraphTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView {
    static NSString *ID  = @"STTextSinglegraphTableViewCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        self.selectionStyle = UITableViewCellSelectionStyleNone ;
        [self awakeFromNib];
    }
    return self;
}

- (void)dealloc{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = kClearColor;
    [self.contentView addSubview:self.bgView];
    self.bgView.backgroundColor = color_cellBg_151420;
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.smallImgView];
    [self.bgView addSubview:self.newsTipBtn];
    [self.bgView addSubview:self.leftBtn];
    [self.bgView addSubview:self.descLabel];
    [self.bgView addSubview:self.rightBtn];
    [self.bgView addSubview:self.commentLabel];
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-20);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).mas_offset(kkPaddingLarge);
        make.left.mas_equalTo(self.bgView).mas_offset(kkPaddingNormal);
        make.width.mas_equalTo(KKTitleWidth);
        make.height.mas_equalTo(3 * STFont(18).lineHeight + 4 * LineSpace);
    }];
    
    [self.smallImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView).mas_offset(kkPaddingLarge);
        make.right.mas_equalTo(self.bgView).mas_offset(-kkPaddingNormal);
        make.width.mas_equalTo(imageWidth);
        make.height.mas_equalTo(3 * STFont(18).lineHeight + 4 * LineSpace);
    }];
    
    [self.leftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).mas_offset(-kkPaddingNormal);
        make.width.mas_offset(13);
        make.height.mas_equalTo(13);
    }];
    
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftBtn.mas_right).mas_offset(space);
        make.centerY.mas_equalTo(self.leftBtn.mas_centerY);
//        make.right.mas_lessThanOrEqualTo(self.shieldBtn.mas_left).mas_offset(-kkPaddingNormal);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-kkPaddingNormalLarge);
        make.centerY.mas_equalTo(self.descLabel.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.commentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.descLabel.mas_centerY);
        make.right.mas_equalTo(self.rightBtn.mas_left).mas_offset(-kkPaddingMax);
        make.left.mas_equalTo(self.descLabel.mas_left).mas_offset(space);
        make.height.mas_equalTo(20);
    }];
    self.descLabel.textAlignment = NSTextAlignmentLeft;
    self.commentLabel.textAlignment = NSTextAlignmentRight;
    [self.leftBtn setTitleColor:color_tipYellow_FECE24 forState:UIControlStateNormal];
    [self.leftBtn setBackgroundColor:KKColor(57, 55, 56, 1)];
//    self.titleLabel.linesSpacing = 22;
    self.titleLabel.numberOfLines = 3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark -- 界面刷新
- (void)refreshData:(id)data {
    self.titleLabel.text = @"人民网评:敬畏事实上海市政府市长作分工明确副市长工作分工明确作分工明确作分工明确";
    self.titleLabel.linesSpacing = 22;
    self.descLabel.text = @"已订阅·人民日报  5分钟前";
    [self.smallImgView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:IMAGE_NAME(STSystemDefaultImageName)];
    self.commentLabel.text = @"23 评论";
    [self.leftBtn setTitle:@"热" forState:UIControlStateNormal];
    SetAnthorRichTextLabel(self.commentLabel, FONT_15, @"23", kWhiteColor);
}

+ (CGFloat)techHeightForOjb:(id)obj{
//    [KKMiddleCorverCell initAttriTextData:item];
//
//    if(item.itemCellHeight <= 0){
//        if(item.textContainer.attriTextHeight >= 3 * KKTitleFont.lineHeight + 3 * item.textContainer.linesSpacing){
//            item.itemCellHeight = 2 * kkPaddingLarge + 3 * KKTitleFont.lineHeight + 3 * item.textContainer.linesSpacing + descLabelHeight + 5;
//        }else{
//            item.itemCellHeight = 2 * kkPaddingLarge + 3 * KKTitleFont.lineHeight + 4 * item.textContainer.linesSpacing + 5 ;
//        }
//    }//3 * STFont(18).lineHeight + 4 * LineSpace
    return  2 * kkPaddingLarge + 3 * STFont(18).lineHeight + 4 * LineSpace  + 40;
}

#pragma mark -- @property

- (UIImageView *)smallImgView{
    if(!_smallImgView){
        _smallImgView = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            view.layer.borderWidth = 0.5;
            view.layer.borderColor = [[UIColor grayColor]colorWithAlphaComponent:0.1].CGColor;
//            @weakify(view);
//            @weakify(self);
            [view addTapGestureWithBlock:^(UIView *gestureView) {
//                @strongify(view);
//                @strongify(self);
//                if(self.delegate && [self.delegate respondsToSelector:@selector(clickImageWithItem:rect:fromView:image:indexPath:)]){
//                    [self.delegate clickImageWithItem:self.item rect:view.frame fromView:self.bgView image:view.image indexPath:nil];
//                }
            }];
            view ;
        });
    }
    return _smallImgView;
}

- (void)moreBtnClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:button];
    }
}
@end
