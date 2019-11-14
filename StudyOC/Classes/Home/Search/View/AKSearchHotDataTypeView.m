//
//  AKSearchHotDataTypeView.m
//  zoneTry
//
//  Created by Zonetry on 16/7/19.
//  Copyright © 2016年 ZoneTry. All rights reserved.
//

#define bigVerticalMargin 10
#define smallVerticalMargin 8
#define bigHorizontalMargin 12
#define smallHorizontalMargin 8

#import "AKSearchHotDataTypeView.h"

@interface AKSearchHotDataTypeView() {
    /******运营数据分类数组*******/
    NSMutableArray *_categories;
    /******所有的选择按钮*******/
    
    /******最后一个选择按钮的位置*******/
    CGRect _lastFrame;
}

@property (nonatomic,strong) UIView *maskView;

@property (nonatomic,strong) UIView *bgView;

@property (strong, nonatomic) NSMutableArray *allBtns;;  // 全部button 数组

@end

@implementation AKSearchHotDataTypeView

#pragma mark Init Method
+ (id)searchHotDataTypeViewWithFrame:(CGRect)frame category:(NSArray *)category {
    return [[AKSearchHotDataTypeView alloc] initWithFrame:frame category:category];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        _categories = [NSMutableArray array];
        _lastFrame = CGRectMake(0, 0, 0, 0);
        self.backgroundColor = kClearColor;
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame category:(NSArray *)category {
    if (self = [super initWithFrame:frame]) {
        _categories = (NSMutableArray *)category;
        _lastFrame = CGRectMake(0, 0, 0, 0);
        self.backgroundColor = kClearColor;
        self.userInteractionEnabled = YES;
        [self setUpUI];
    }
    return self;
}
- (void)setCategortArray:(NSMutableArray *)categortArray {
    _categortArray = categortArray;
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    _lastFrame = CGRectMake(0, 0, 0, 0);
     @autoreleasepool {
            for (int i = 0; i < _categortArray.count; i++) {
                CGFloat windth = [NSString calculateFrameWidth:Window_W-bigHorizontalMargin*2 text:_categortArray[i] height:20 fontsize:13.f];
                
                UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(bigHorizontalMargin + CGRectGetMaxX(_lastFrame), bigVerticalMargin+CGRectGetMaxY(_lastFrame), floor(windth + 20), 20.f)];
                if (windth + 20 + bigHorizontalMargin*2 + CGRectGetMaxX(_lastFrame) > Window_W - 20) {
                    baseLabel.x = bigHorizontalMargin;
                    baseLabel.y = CGRectGetMaxY(_lastFrame) + 15;
                    if (!self.isShowAll) {
                        return;
                    } else {
    
                    }
                } else {
                    baseLabel.y = CGRectGetMinY(_lastFrame);
                }
                baseLabel.font = FONT_11;
                baseLabel.textColor = color_textBg_C7C7D1;
                baseLabel.backgroundColor = [UIColor colorWithRed:66.0f/255.0f green:65.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
                baseLabel.text = _categortArray[i];
                baseLabel.layer.cornerRadius = 3.f;
                baseLabel.clipsToBounds = YES;
                baseLabel.textAlignment = NSTextAlignmentCenter;
                baseLabel.userInteractionEnabled = YES;
                _lastFrame = baseLabel.frame;
                [self addSubview:baseLabel];
                baseLabel.userInteractionEnabled = YES;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapLabel:)];
                baseLabel.tag = 1008611 + i;
                tap.numberOfTapsRequired = 1;
                tap.numberOfTouchesRequired = 1;
                [baseLabel addGestureRecognizer:tap];
            }
            self.height = CGRectGetMaxY(_lastFrame) + 30 + 15;
        }
}
- (void)setUpUI {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    @autoreleasepool {
        for (int i = 0; i < _categories.count; i++) {
            CGFloat windth = [NSString calculateFrameWidth:Window_W-bigHorizontalMargin*2 text:_categories[i] height:20 fontsize:13.f];
            
            UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(bigHorizontalMargin + CGRectGetMaxX(_lastFrame), bigVerticalMargin+CGRectGetMaxY(_lastFrame), floor(windth + 20), 20.f)];
            if (windth + 20 + bigHorizontalMargin*2 + CGRectGetMaxX(_lastFrame) > Window_W - 20) {
                baseLabel.x = bigHorizontalMargin;
                baseLabel.y = CGRectGetMaxY(_lastFrame) + 15;
//                if (!self.isShowAll) {
//                    return;
//                } else {
//
//                }
            } else {
                baseLabel.y = CGRectGetMinY(_lastFrame);
            }
            baseLabel.font = FONT_11;
            baseLabel.textColor = color_textBg_C7C7D1;
            baseLabel.backgroundColor = [UIColor colorWithRed:66.0f/255.0f green:65.0f/255.0f blue:83.0f/255.0f alpha:1.0f];
            baseLabel.text = _categories[i];
            baseLabel.layer.cornerRadius = 3.f;
            baseLabel.clipsToBounds = YES;
            baseLabel.textAlignment = NSTextAlignmentCenter;
            baseLabel.userInteractionEnabled = YES;
            _lastFrame = baseLabel.frame;
            [self addSubview:baseLabel];
            baseLabel.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapLabel:)];
            baseLabel.tag = 1008611 + i;
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [baseLabel addGestureRecognizer:tap];
        }
        self.height = CGRectGetMaxY(_lastFrame) + 30 + 15;
    }
}

- (void)onTapLabel:(UITapGestureRecognizer *)tap {
    if (self.searchHotCellLabelClickButton) {
        UILabel *label = (UILabel *)tap.view;
        self.searchHotCellLabelClickButton(label.tag - 1008611);
        XYLog(@"1111111111111111");
    }
}

@end
