//
//  STMultigraphTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/18.
//  Copyright © 2019 研学旅行. All rights reserved.
//
#define kkPaddingNormal 5.0
#define KKTitleWidth ([UIScreen mainScreen].bounds.size.width - 2 * kkPaddingNormal)
#define imageWidth ((KKTitleWidth - 2 * kkPaddingNormal) / 3.0)
#define imageHeight (imageWidth * 3 / 4)
#import "STMultigraphTableViewCell.h"
@interface STMultigraphTableViewCell()
@property(nonatomic,strong)UIView *imageContentView;
@end
@implementation STMultigraphTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView {
    static NSString *ID  = @"STMultigraphTableViewCell";
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
    [self.bgView addSubview:self.imageContentView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.leftBtn];
    [self.bgView addSubview:self.descLabel];
    [self.bgView addSubview:self.newsTipBtn];
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
        make.height.mas_equalTo(21);
    }];
    
    [self.imageContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(kkPaddingNormal);
        make.width.mas_equalTo(KKTitleWidth);
        make.height.mas_equalTo(imageHeight);
    }];
    
    UIImageView *lastView = nil ;
    for(NSInteger i = 0 ; i < 3 ; i++ ){
        UIImageView *view = [self createImageView];
        view.tag = 1000 + i ;
        [self.imageContentView addSubview:view];
        if(i == 0){
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.imageContentView);
                make.left.mas_equalTo(self.imageContentView);
                make.width.mas_equalTo(imageWidth);
                make.height.mas_equalTo(imageHeight);
            }];
        }else{
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView);
                make.left.mas_equalTo(lastView.mas_right).mas_offset(kkPaddingNormal);
                make.width.mas_equalTo(imageWidth);
                make.height.mas_equalTo(imageHeight);
            }];
        }
        lastView = view ;
    }

    [self.leftBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(lastView.mas_bottom).mas_offset(kkPaddingNormal + 3);
        make.width.mas_offset(13);
        make.height.mas_equalTo(13);
    }];
    
    [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftBtn.mas_right).mas_offset(kkPaddingNormal);
        make.centerY.mas_equalTo(self.leftBtn.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(14);
    }];
    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView.mas_right).mas_offset(-kkPaddingNormalLarge);
        make.centerY.mas_equalTo(self.descLabel.mas_centerY).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    [self.commentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.descLabel.mas_centerY);
        make.right.mas_equalTo(self.rightBtn.mas_left).mas_offset(-kkPaddingMax);
//        make.width.mas_equalTo(100);
        make.left.mas_equalTo(self.descLabel.mas_left).mas_offset(kkPaddingNormal);
        make.height.mas_equalTo(20);
    }];
    self.descLabel.textAlignment = NSTextAlignmentLeft;
    self.commentLabel.textAlignment = NSTextAlignmentRight;
    [self.leftBtn setTitleColor:color_tipYellow_FECE24 forState:UIControlStateNormal];
    [self.leftBtn setBackgroundColor:KKColor(57, 55, 56, 1)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark -- 界面刷新

- (void)refreshData:(id)data {
    self.titleLabel.text = @"人民网评:敬畏事实上海市政府市长";
    self.descLabel.text = @"已订阅·人民日报  5分钟前";
    self.commentLabel.text = @"23 评论";
    SetAnthorRichTextLabel(self.commentLabel, FONT_15, @"23", kWhiteColor);
//    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    for(NSInteger i = 0 ; i < 3 ; i++){
//        NSString *url = [item.image_list safeObjectAtIndex:i].url;
//        if(!url.length || [url isKindOfClass:[NSNull class]]){
//            url = @"";
//        }
        UIImageView *view = [self.bgView viewWithTag:1000+i];
        [view sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:IMAGE_NAME(STSystemDefaultImageName)];
//        [imageCache queryCacheOperationForKey:url done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
//            if(image){
//                [view setImage:image];
//            }else{
//                [view kk_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]] animate:YES];
//            }
//        }];
    }
    
    [self.leftBtn setTitle:@"热" forState:UIControlStateNormal];
}
+ (CGFloat)techHeightForOjb:(id)obj{
    return  2 * kkPaddingLarge + 2 * kkPaddingNormal + imageHeight + 20 + 17 +20;
}

#pragma mark -- 初始化标题文本

- (UIImageView *)createImageView{
    UIImageView *view = [UIImageView new];
    view.contentMode = UIViewContentModeScaleAspectFill;
    view.layer.masksToBounds = YES ;
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [[UIColor grayColor]colorWithAlphaComponent:0.1].CGColor;
    return view ;
}

#pragma mark --imageContentView

- (UIView *)imageContentView{
    if(!_imageContentView){
        _imageContentView = ({
            UIView *view = [UIView new];
            view.userInteractionEnabled = YES ;

            view ;
        });
    }
    return _imageContentView;
}
- (void)moreBtnClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:button];
    }
}

@end
