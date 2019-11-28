//
//  KKAuthorInfoView.m
//  KKToydayNews
//
//  Created by finger on 2017/9/23.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKAuthorInfoView.h"

#define ConcernWdith 50
#define LabelHeight 20

@interface KKAuthorInfoView()
@property(nonatomic)UIImageView *header;
@property(nonatomic,readwrite)UILabel *nameLabel;
@property(nonatomic,readwrite)UILabel *detailLabel;
@property(nonatomic)UIButton *concernBtn;
@property(nonatomic)UIView *splitViewBottom;
@end

@implementation KKAuthorInfoView

- (instancetype)init{
    self = [super init];
    if(self){
        [self setupUI];
    }
    return self ;
}

#pragma mark -- 初始化UI

- (void)setupUI{
    [self addSubview:self.header];
    [self addSubview:self.nameLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.concernBtn];
    [self addSubview:self.vipImageView];
    
    [self.header mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kkPaddingNormal).priority(998);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(_headerSize);
    }];
    
    [self.concernBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-kkPaddingNormal).priority(998);
        make.centerY.mas_equalTo(self.header);
        make.size.mas_equalTo(CGSizeMake(ConcernWdith, 25));
    }];
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.header.mas_right).mas_offset(10).priority(998);
        make.right.mas_equalTo(self.concernBtn.mas_left).mas_offset(-5).priority(998);
        make.bottom.mas_equalTo(self.header.mas_centerY).mas_offset(-2);
        make.height.mas_equalTo(LabelHeight);
    }];
    
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.header.mas_centerY).mas_offset(2);
        make.height.mas_equalTo(LabelHeight);
    }];
    [self.vipImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.header).mas_offset(26);
        make.left.mas_equalTo(self.header).mas_offset(30);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
}

#pragma mark -- 关注按钮点击

- (void)concernBtnClick:(UIButton *)button{
    NSString *key = [kUserDefaults objectForKey:STUserRegisterInfokey];
    if ([key isNotBlank]) {
         NSDictionary *params = @{@"i":@(1),
                                  @"key":key,
                                  @"uid":@(self.userId),
        };
        [[STHttpResquest sharedManager] requestWithMethod:POST
                                                 WithPath:@"user_center/do_video_guanzhu"
                                               WithParams:params
                                         WithSuccessBlock:^(NSDictionary * _Nonnull dic){
            NSInteger status = [[dic objectForKey:@"state"] integerValue];
            NSString *msg = [[dic objectForKey:@"msg"] description];
            if(status == 200){
                NSDictionary *data = [dic objectForKey:@"data"];
                int flag_type = [[data objectForKey:@"flag_type"] intValue];
                if (flag_type == 1) {
                    button.layer.backgroundColor = [[UIColor colorWithRed:58.0f/255.0f green:58.0f/255.0f blue:68.0f/255.0f alpha:1.0f] CGColor];
                    [button setTitle:@"已订阅" forState:UIControlStateNormal];
                } else {
                    button.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:33.0f/255.0f blue:144.0f/255.0f alpha:1.0f] CGColor];
                    [button setTitle:@"订阅+" forState:UIControlStateNormal];
                }
            }else {
                if (msg.length>0) {
                    [MBManager showBriefAlert:msg];
                }
            }
        } WithFailurBlock:^(NSError * _Nonnull error) {
            
        }];
    } else {
        STLoginViewController *vc = [STLoginViewController new];
        vc.barStyle = [UIApplication sharedApplication].statusBarStyle;
        STBaseNav *nav = [[STBaseNav alloc] initWithRootViewController:vc];
        [kRootViewController presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

#pragma mark -- @property setter

- (void)setShowDetailLabel:(BOOL)showDetailLabel{
    _showDetailLabel = showDetailLabel;
    self.detailLabel.hidden = !showDetailLabel;
    if(_showDetailLabel){
        [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(LabelHeight);
        }];
        [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.header.mas_centerY).mas_offset(-2);
        }];
    }else{
        [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.header.mas_centerY).mas_offset(LabelHeight/2.0);
        }];
    }
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
- (void)setHeaderSize:(CGSize)headerSize{
    _headerSize = headerSize;
    ViewBorderRadius(self.header, 4, 2, [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:209.0f/255.0f alpha:1.0f]);
    [self.header mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(_headerSize);
    }];
}

- (void)setName:(NSString *)name{
    self.nameLabel.text = name;
}

- (void)setHeadUrl:(NSString *)headUrl{
    if(!headUrl.length){
        headUrl = @"";
    }
    [self.header yy_setImageWithURL:[NSURL URLWithString:headUrl] placeholder:IMAGE_NAME(STSystemDefaultImageName)];
}

- (void)setDetail:(NSString *)detail{
    self.detailLabel.text = detail;
}

- (void)setIsConcern:(BOOL)isConcern{
    self.concernBtn.selected = isConcern ;
    if(isConcern){
        self.concernBtn.layer.borderColor = [UIColor grayColor].CGColor;
    }else{
        self.concernBtn.layer.borderColor = [UIColor redColor].CGColor;
    }
}

- (void)setShowBottomSplit:(BOOL)showBottomSplit{
    self.splitViewBottom.hidden = !showBottomSplit;
}

#pragma mark -- @property getter

- (UIImageView *)header{
    if(!_header){
        _header = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;

            @STweakify(self);
            [view addTapGestureWithBlock:^(UIView *gestureView) {
                @STstrongify(self);
                if(self.delegate && [self.delegate respondsToSelector:@selector(clickedUserHeadWithUserId:)]){
                    [self.delegate clickedUserHeadWithUserId:STRING_FROM_INTAGER(self.userId)];
                }
            }];
            
            view ;
        });
    }
    return _header;
}

- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = ({
            UILabel *view = [UILabel new];
            view.textAlignment = NSTextAlignmentLeft;
            view.textColor = color_textBg_C7C7D1;
            view.font = [UIFont systemFontOfSize:(iPhone5)?14:15];
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view ;
        });
    }
    return _nameLabel;
}

- (UILabel *)detailLabel{
    if(!_detailLabel){
        _detailLabel = ({
            UILabel *view = [UILabel new];
            view.textAlignment = NSTextAlignmentLeft;
            view.textColor = color_text_AFAFB1;
            view.font = [UIFont systemFontOfSize:12];
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view ;
        });
    }
    return _detailLabel;
}

- (UIButton *)concernBtn{
    if(!_concernBtn){
        _concernBtn = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            [view setTitle:@"+关注" forState:UIControlStateNormal];
            [view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [view setBackgroundImage:[UIImage imageWithColor:COLOR_HEX_RGB(0xFF2190)] forState:UIControlStateNormal];
//            [view setTitle:@"已关注" forState:UIControlStateSelected];
//            [view setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
//            [view setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected];
            [view.titleLabel setFont:[UIFont systemFontOfSize:10]];
//            [view.layer setBorderWidth:0.7];
//            [view.layer setBorderColor:[UIColor redColor].CGColor];
            [view addTarget:self action:@selector(concernBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//            [view setSelected:NO];
            [view.layer setCornerRadius:3];
            [view.layer setMasksToBounds:YES];
            view ;
        });
    }
    return _concernBtn;
}

@end
