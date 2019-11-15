//
//  STLocationThemeTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/11/14.
//  Copyright © 2019 研学旅行. All rights reserved.
//
#define bigVerticalMargin 10
#define smallVerticalMargin 8
#define bigHorizontalMargin 12
#define smallHorizontalMargin 8
#import "STLocationThemeTableViewCell.h"
@interface STLocationThemeTableViewCell()
{
    CGRect _lastFrame;
}
@end
@implementation STLocationThemeTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView {
    static NSString *ID  = @"STLocationThemeTableViewCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
+ (CGFloat)techHeightForOjb:(id)obj {
    return (Window_W-kkPaddingNormalLarge*2)*0.56 + kWidth(44) + kkPaddingNormalLarge + kkPaddingSmall*2 + 24+kkPaddingSmall + 30;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = color_cellBg_151420;
    self.isShowAll = NO;

}
- (void)setCategortArray:(NSMutableArray *)categortArray {
    _categortArray = categortArray;
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(16, 12, 44, 20)];
    lab.text = @"#主题";
    lab.textColor = KKColor(214, 216, 228, 1.0);
    lab.font = FONT_12;
    [self addSubview:lab];
    _lastFrame = CGRectMake(60, bigHorizontalMargin, 0, 0);
    int line = 1;
     @autoreleasepool {
            for (int i = 0; i < _categortArray.count; i++) {
                CGFloat windth = [NSString calculateFrameWidth:Window_W-bigHorizontalMargin*2 text:_categortArray[i] height:20 fontsize:13.f];
                
                UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(bigHorizontalMargin + CGRectGetMaxX(_lastFrame), bigVerticalMargin+CGRectGetMaxY(_lastFrame), floor(windth + 20), 20.f)];
                baseLabel.tag = 1008611 + i;
                if (windth + 20 + bigHorizontalMargin*2 + CGRectGetMaxX(_lastFrame) > Window_W - 20) {
                    baseLabel.x = bigHorizontalMargin;
                    baseLabel.y = CGRectGetMaxY(_lastFrame) + 15;
                    if (!self.isShowAll && line>1) {
                        break;
                    } else {
                    }
                    line +=1;
                } else {
                    baseLabel.y = CGRectGetMinY(_lastFrame);
                }
                if (line == 2 && !self.isShowAll && baseLabel.x+windth+20+bigHorizontalMargin*2 > Window_W- 68) {
                    baseLabel.font = FONT_11;
                    baseLabel.textColor = color_textBg_C7C7D1;
                    baseLabel.text = @"全部 >";
                    baseLabel.tag = BUTTON_TAG(110);
                    baseLabel.textAlignment = NSTextAlignmentCenter;
                    baseLabel.userInteractionEnabled = YES;
                } else {
                    baseLabel.font = FONT_11;
                    baseLabel.textColor = color_textBg_C7C7D1;
                    baseLabel.backgroundColor = [UIColor colorWithRed:38.0f/255.0f green:38.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
                    baseLabel.text = _categortArray[i];
                    baseLabel.layer.cornerRadius = 10.f;
                    baseLabel.clipsToBounds = YES;
                    baseLabel.textAlignment = NSTextAlignmentCenter;
                    baseLabel.userInteractionEnabled = YES;
                }

                _lastFrame = baseLabel.frame;
                [self addSubview:baseLabel];
                baseLabel.userInteractionEnabled = YES;
                
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapLabel:)];

                tap.numberOfTapsRequired = 1;
                tap.numberOfTouchesRequired = 1;
                [baseLabel addGestureRecognizer:tap];
            }
            self.height = CGRectGetMaxY(_lastFrame) + 0 + 15;
        }
}
- (void)onTapLabel:(UITapGestureRecognizer *)tap {
    if (self.searchHotCellLabelClickButton) {
        UILabel *label = (UILabel *)tap.view;
        if (label.tag == BUTTON_TAG(110)) {
//            label.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:166.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
//            label.textColor = kWhiteColor;
            self.isShowAll = YES;
            self.searchHotCellLabelClickButton(label.tag,self);
        } else {
            label.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:166.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
            label.textColor = kWhiteColor;
            self.searchHotCellLabelClickButton(label.tag - 1008611,self);
        }

        XYLog(@"1111111111111111");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 5;
    [super setFrame:frame];
}
@end
