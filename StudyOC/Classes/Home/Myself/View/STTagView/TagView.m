//
//  TagView.m
//  XiYuanPlus
//
//  Created by JS-Tiger on 2018/10/18.
//Copyright © 2018年 Hoping. All rights reserved.
//

#define smallMargin 5

#import "TagView.h"

@interface TagView ()
{
    /******最后一个选择按钮的位置*******/
    CGRect _lastFrame;
}

@end

@implementation TagView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark -
- (void)setDataSources:(NSArray *)dataSources {
    _dataSources = dataSources;
    for (UIButton *btn in self.subviews) {
        [btn removeFromSuperview];
    }
    if (!_dataSources.count) {
        return;
    }
    _lastFrame=CGRectMake(-smallMargin, 0, 0, 0);
    int x = 1;
    for (int i=0; i<dataSources.count; i++) {
        UIButton *tipBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        tipBtn.tag = i;
        [tipBtn setBackgroundColor: COLOR_HEX_RGB(0x3A3A44)];
        [tipBtn setTitleColor:color_textBg_C7C7D1 forState:UIControlStateNormal];
        tipBtn.titleLabel.font = FONT_10;
        [tipBtn setTitle:dataSources[i]
                forState:UIControlStateNormal];
        ViewRadius(tipBtn, 2);
        CGSize size = [dataSources[i] sizeWithAttributes:@{NSFontAttributeName:tipBtn.titleLabel.font}];
        if ((self.width - smallMargin - CGRectGetMaxX(_lastFrame)) >= size.width + smallMargin) {
            tipBtn.frame = CGRectMake(CGRectGetMaxX(_lastFrame) + smallMargin,
                                      CGRectGetMinY(_lastFrame),
                                      size.width + smallMargin,
                                      size.height );
        }else{
            tipBtn.frame = CGRectMake(smallMargin,
                                      CGRectGetMaxY(_lastFrame) + smallMargin,
                                      size.width + smallMargin,
                                      size.height );
            x += 1;
        }
//        if ((CGRectGetMinX(_lastFrame)-size.width-smallMargin) >= size.width + smallMargin) {
//            tipBtn.frame = CGRectMake(CGRectGetMinX(_lastFrame) - smallMargin-size.width-10,
//                                      CGRectGetMinY(_lastFrame),
//                                      size.width + 10,
//                                      size.height);
//        }else{
//            tipBtn.frame = CGRectMake(smallMargin,
//                                      CGRectGetMaxY(_lastFrame) + smallMargin,
//                                      size.width + 10,
//                                      size.height );
//            x += 1;
//        }
        _lastFrame=tipBtn.frame;
        if (x<=1) {
            [self addSubview:tipBtn];
        }
    }
}

-(void)tipBtnClicked:(UIButton *)sender {
    if (self.tagButtonClick) {
        self.tagButtonClick(sender.titleLabel.text);
    }
}

- (void)setSelectButtonsArr:(NSMutableArray *)selectButtonsArr {
    _selectButtonsArr = selectButtonsArr;

}

- (void)setListDataArray:(NSArray *)listDataArray {
    _listDataArray = listDataArray;
    _lastFrame= CGRectMake(0, 10, 0, 0);
    int x = 1;
    NSUInteger count = listDataArray.count;
    NSUInteger total = count < 3 ? count : 3;
    for (int i=0; i<total; i++) {
        UIButton *tipBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        tipBtn.titleLabel.font=FONT_12;
        [tipBtn setTitleColor:[UIColor colorWithRed:153/255.0
                                              green:153/255.0
                                               blue:153/255.0
                                              alpha:1]
                     forState:UIControlStateNormal];
        [tipBtn setTitleColor:kWhiteColor forState:UIControlStateSelected];
        tipBtn.layer.borderColor = COLOR_e5e5e5.CGColor;
        tipBtn.layer.borderWidth = 1;
        [tipBtn setTitle:listDataArray[i]
                forState:UIControlStateNormal];
        [tipBtn addTarget:self
                   action:@selector(tipBtnClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(tipBtn, 4);
        CGSize size = [listDataArray[i] sizeWithAttributes:@{NSFontAttributeName:tipBtn.titleLabel.font}];
        CGFloat Y = kHeight(43)/2 - (size.height + 5)/2;
        if ((Window_W - 116 -12 * 2 - CGRectGetMaxX(_lastFrame)) >= size.width + 20) {//SCREEN_WIDTH - 12 * 2 - 116
            tipBtn.frame = CGRectMake(CGRectGetMaxX(_lastFrame) + smallMargin,
                                      Y,
                                      size.width + 20,
                                      size.height + 5);
        }else{
            x += 1;
        }
        _lastFrame = tipBtn.frame;
        if (x <= 1) {
            [self addSubview:tipBtn];
        }
    }
}
@end
