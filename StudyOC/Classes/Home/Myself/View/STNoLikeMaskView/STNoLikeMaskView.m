//
//  STNoLikeMaskView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/29.
//  Copyright © 2019 研学旅行. All rights reserved.
//
#define maskHeight (377+HOME_INDICATOR_HEIGHT)
#import "STNoLikeMaskView.h"
@interface STNoLikeMaskView ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_contentView;
}
@property (strong, nonatomic) UITableView *tableView; //  视图
@property (strong, nonatomic) NSMutableArray *btnArray;  //  数组
@property (strong, nonatomic) NSMutableDictionary *datadict;  //  数组

@end
@implementation STNoLikeMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupContent];
    }
    return self;
}

- (void)setupContent {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
//    self.backgroundColor = kYellowColor;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissMaskView)]];
    
    if (_contentView == nil) {
        
//        CGFloat margin = 15;
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, Window_H - maskHeight, Window_W, maskHeight)];
        _contentView.backgroundColor = COLOR_HEX_RGB(0x393738);
        [self addSubview:_contentView];
        // 右上角关闭按钮
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(_contentView.width - 20 - 15, 15, 20, 20);
        [closeBtn setImage:[UIImage imageNamed:@"nolikeBack_icon"] forState:UIControlStateNormal];
//        [closeBtn setTitle:@"X" forState:UIControlStateNormal];
        [closeBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(dissMaskView) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:closeBtn];
        
//        [_contentView addSubview:self.tableView];
//        [self.tableView masMakeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.mas_equalTo(self->_contentView);
//            make.top.mas_equalTo(closeBtn.mas_bottom);
//            make.bottom.mas_equalTo(self->_contentView);
//        }];
//        return;
        UILabel *titleLab = [[UILabel alloc] init];
        [_contentView addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->_contentView.mas_left).mas_offset(35);
            make.top.mas_equalTo(self->_contentView.mas_top).mas_offset(17);
            make.height.mas_equalTo(17);
            make.width.mas_equalTo(86);
        }];
        titleLab.text = @"我要投诉";
        titleLab.textColor = kWhiteColor;
        titleLab.font = FONT_12;
//        return;
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:kWhiteColor];
        [_contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLab.mas_bottom).mas_offset(12);
            make.height.mas_equalTo(1);
            make.left.mas_equalTo(self->_contentView.mas_left).mas_offset(28);
            make.right.mas_equalTo(self->_contentView.mas_right).mas_offset(-19);
        }];
        
        UILabel *sublabel1 = [[UILabel alloc] init];
        [sublabel1 setTextColor:color_textBg_C7C7D1];
        [_contentView addSubview:sublabel1];
        [sublabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(titleLab.mas_left);
            make.top.mas_equalTo(line.mas_bottom).mas_offset(kkPaddingNormal);
            make.right.mas_equalTo(self->_contentView.mas_right).mas_offset(-23);
            make.height.mas_equalTo(17);
        }];
        sublabel1.text = @"反馈（选择后将优化频道区内容推荐）";
        sublabel1.font = FONT_10;
        SetAnthorRichTextLabel(sublabel1, FONT_12, @"反馈", kWhiteColor);
        int SPNum = 2;//水平一行放几个
        CGFloat JGGMinX = kWidth(36);//起始x值
        CGFloat JGGMinY = 88;//起始y值
        CGFloat SPspace = kWidth(62);//水平距离
        CGFloat CXspace = kHeight(10);//垂直距离
        CGFloat widthJGG = (Window_W- JGGMinX * 2 -SPspace * (SPNum-1)) / SPNum ;//九宫格宽
        CGFloat heightJGG = 25;//九宫格高
        NSArray *titleArr = @[@"标题党/封面党",@"低俗色情",@"恐怖血腥",@"内容不实",@"垃圾内容",@"旧闻重复"];
        self.btnArray = [NSMutableArray arrayWithCapacity:6];
        for (int i=0; i<titleArr.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = STFont(11) ;
            btn.layer.masksToBounds = YES ;
            [btn setTitleColor:COLOR_HEX_RGB(0xAFAFB1) forState:UIControlStateNormal];
            btn.layer.borderColor = COLOR_HEX_RGB(0x535353).CGColor;
            btn.layer.borderWidth = 1;
            btn.layer.cornerRadius = 2;
            btn.tag = BUTTON_TAG(15+i);
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [_contentView addSubview:btn];
            [self.btnArray addObject:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make){
                make.left.mas_equalTo(JGGMinX + i % SPNum * (widthJGG + SPspace));
                make.top.mas_equalTo(JGGMinY + i / SPNum * (heightJGG + CXspace));
                make.width.mas_equalTo(widthJGG);
                make.height.mas_equalTo(heightJGG);
                //不能再这里跟新约束，否则会警告,控件错位
            }];
        }
        UILabel *subLab2 = [[UILabel alloc] init];
        [_contentView addSubview:subLab2];
        [subLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(sublabel1.mas_left);
            make.top.mas_equalTo(self->_contentView.mas_top).mas_offset(202);
            make.height.mas_equalTo(17);
            make.right.mas_equalTo(self->_contentView.mas_right).mas_offset(-23);
        }];
        subLab2.text = @"屏蔽频道（选择后将减少该频道主发布的内容）";
        subLab2.font = FONT_10;
        subLab2.textColor = color_textBg_C7C7D1;
        SetAnthorRichTextLabel(subLab2, FONT_12, @"屏蔽频道", kWhiteColor);
        UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagButton setTitle:@"当前频道主：可莱丝的小屋" forState:UIControlStateNormal];
        tagButton.titleLabel.font = STFont(11) ;
        tagButton.layer.masksToBounds = YES ;
        [tagButton setTitleColor:COLOR_HEX_RGB(0xAFAFB1) forState:UIControlStateNormal];
        tagButton.layer.borderColor = COLOR_HEX_RGB(0x535353).CGColor;
        tagButton.layer.borderWidth = 1;
        tagButton.layer.cornerRadius = 2;
        tagButton.tag = BUTTON_TAG(22);
        [tagButton addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:tagButton];
        [tagButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(sublabel1.mas_left);
            make.top.mas_equalTo(subLab2.mas_bottom).mas_offset(12);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(157);
        }];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self->_contentView);
            make.height.mas_equalTo(44);
            make.bottom.mas_equalTo(self->_contentView.mas_bottom).mas_offset(-HOME_INDICATOR_HEIGHT);
        }];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn.titleLabel setFont:FONT_12];
        [cancelBtn setTitleColor:color_B2B2B2 forState:UIControlStateNormal];
        [cancelBtn setTag:BUTTON_TAG(13)];
        [cancelBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIView *lineBig1 = [[UIView alloc] init];
        lineBig1.backgroundColor = COLOR_HEX_RGB(0x2D2D2D);
        [_contentView addSubview:lineBig1];
        [lineBig1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self->_contentView);
            make.height.mas_equalTo(5);
            make.bottom.mas_equalTo(cancelBtn.mas_top);
        }];
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentView addSubview:sureBtn];
        [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self->_contentView);
            make.height.mas_equalTo(44);
            make.bottom.mas_equalTo(lineBig1.mas_top).mas_offset(0);
        }];
        [sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setTag:BUTTON_TAG(14)];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn.titleLabel setFont:FONT_12];
        [sureBtn setTitleColor:color_B2B2B2 forState:UIControlStateNormal];
        self.sureButton = sureBtn;
        UIView *lineBig2 = [[UIView alloc] init];
        lineBig2.backgroundColor = COLOR_HEX_RGB(0x2D2D2D);
        [_contentView addSubview:lineBig2];
        [lineBig2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self->_contentView);
            make.height.mas_equalTo(5);
            make.bottom.mas_equalTo(sureBtn.mas_top);
        }];
    }
    self.datadict = [NSMutableDictionary dictionaryWithCapacity:0];
}
- (void)clickBtn:(UIButton *)button {
    button.selected = !button.isSelected;
    if (button.tag == BUTTON_TAG(13)) {//取消
        [self dissMaskView];
    } else if(button.tag == BUTTON_TAG(14)){//确定
        if (self.btnClickedBlock) {
            self.btnClickedBlock(button,self.datadict);
        }
        [self dissMaskView];
    } else if(button.tag == BUTTON_TAG(22)){//频道选择
        if (button.selected) {
            [self.datadict setValue:button.titleLabel.text forKey:@"channel"];
            button.backgroundColor = COLOR_HEX_RGB(0x535353);
        } else {
            button.backgroundColor = kClearColor;
            [self.datadict setValue:@"" forKey:@"channel"];
        }
    }else{//内容选择
        if (button.selected) {
            [self.datadict setValue:button.titleLabel.text forKey:@"content"];
            button.backgroundColor = COLOR_HEX_RGB(0x535353);
        } else {
            button.backgroundColor = kClearColor;
            [self.datadict setValue:@"" forKey:@"content"];
        }
        for (UIButton *btn in self.btnArray) {
            if (![btn isEqual:button]) {
                btn.backgroundColor = kClearColor;
            }
        }
    }
}

- (void)showMaskViewIn:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, Window_H, Window_W, maskHeight)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [self->_contentView setFrame:CGRectMake(0, Window_H - maskHeight , Window_W, maskHeight)];
        
    } completion:nil];
    
    
}
- (void)dissMaskView {
    [_contentView setFrame:CGRectMake(0, Window_H - maskHeight, Window_W, maskHeight)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         
                         self.alpha = 0.0;
                         
                         [self->_contentView setFrame:CGRectMake(0, Window_H, Window_W, maskHeight)];
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                         [self->_contentView removeFromSuperview];
                         
                     }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view_subtable";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = COLOR_e5e5e5;
//        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;

}
#pragma mark  - tableview - datasoure

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

#pragma mark  -  tableview - delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"tableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@%ld",identifier,indexPath.row];
//    uitableViewCellStyleDefault，//带有文本标签和可选图像视图的简单单元格（iphoneos 2.x中uitableViewCell的行为）
//    uitableViewCellStyleValue1，//leaft-aligned label on left and right-aligned label on right with blue text（用于设置）
//    uitableViewCellStyleValue2，//左对齐标签，蓝色文本，右对齐标签（用于电话/联系人）
//    uitableViewCellStyleSubtitle//顶部为左对齐标签，底部为左对齐标签，带灰色文本（用于iPod）。
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [MBManager showBriefAlert:[NSString stringWithFormat:@"你点击了第%ld个Cell ",indexPath.row]];
    [self dissMaskView];
}

@end
