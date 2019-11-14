//
//  STSearchTextFildeView.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/22.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STSearchTextFildeView.h"

@implementation STSearchTextFildeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.layer.borderColor =[[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] CGColor];;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.font = FONT_11;
    self.textColor =kWhiteColor;
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    // 计算占位文字的 Size
    CGSize placeholderSize = [self.placeholder sizeWithAttributes:
                              @{NSFontAttributeName : self.font}];
    
    [self.placeholder drawInRect:CGRectMake(0,
                                            (rect.size.height - placeholderSize.height)/2,
                                            rect.size.width, rect.size.height)
                  withAttributes:
     @{NSForegroundColorAttributeName : [UIColor colorWithRed:112.0f/255.0f green:112.0f/255.0f blue:112.0f/255.0f alpha:1.0f] ,
       NSFontAttributeName : self.font}];
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 46, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 46, 0);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 46, 0);
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 15; //像右边偏15
    return iconRect;
}

////UITextField 文字与输入框的距离
//- (CGRect)textRectForBounds:(CGRect)bounds{
//
//    return CGRectInset(bounds, 45, 0);
//
//}
//
////控制文本的位置
//- (CGRect)editingRectForBounds:(CGRect)bounds{
//
//    return CGRectInset(bounds, 45, 0);
//}
@end
