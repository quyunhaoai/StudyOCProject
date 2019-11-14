//
//  STRegisterInputView.h
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/9.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STRegisterInputView : UIView
@property(weak,nonatomic) id <KKCommonDelegate>delegate;
@property (strong, nonatomic) UITextField *niceTextView;   //  文本域
@property (strong, nonatomic) UITextField *mobileTextView;   //  文本域
@property (strong, nonatomic) UITextField *passWordTextView;   //  文本域
@property (strong, nonatomic) UITextField *VerificationTextField;  //  文本框
@property (strong, nonatomic) UIImageView *headPortraitImageView; //  图片
@property (strong, nonatomic) UILabel *headPortraitLabel; //  标签
@property (nonatomic,strong) UIButton *areaButton; //  按钮
@property (nonatomic,strong) UIButton *verButton; //  按钮
@property (strong, nonatomic) TYAttributedLabel *agreeLabel; //  标签

@property (strong, nonatomic) UIView *line1; //  视图
@property (strong, nonatomic) UIView *line2; //  视图
@property (strong, nonatomic) UIView *line3; //  视图
@property (strong, nonatomic) UIView *line4; //  视图
@property (nonatomic,strong) UIButton *justButton; //  按钮
@property (nonatomic,strong) UIButton *regiserButton; //  按钮

@end

NS_ASSUME_NONNULL_END
