//
//  STNoLikeMaskView.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/9/29.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STNoLikeMaskView : UIView
@property (nonatomic,strong) UIButton *sureButton; //  按钮
@property (nonatomic, copy) void (^btnClickedBlock)(UIButton *sender,NSMutableDictionary *dict);
- (void)showMaskViewIn:(UIView *)view;

- (void)dissMaskView;
@end

NS_ASSUME_NONNULL_END
