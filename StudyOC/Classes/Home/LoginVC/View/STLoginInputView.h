//
//  STLoginInputView.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/9.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STLoginInputView : UIView
@property (weak,nonatomic) id <KKCommonDelegate>delegate;
@property (strong, nonatomic) UITextField *niceTextView;   //  文本域
@property (strong, nonatomic) UITextField *mobileTextView;   //  文本域
@property (strong, nonatomic) UITextField *passWordTextView;   //  文本域
@property (strong, nonatomic) UILabel *titleLabelView; // 视图
@property (strong, nonatomic) UIImageView *headIconImageView; //  图片

@end

NS_ASSUME_NONNULL_END
