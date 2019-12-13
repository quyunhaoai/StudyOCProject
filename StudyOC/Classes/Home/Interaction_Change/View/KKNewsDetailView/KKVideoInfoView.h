//
//  KKVideoInfoView.h
//  KKToydayNews
//
//  Created by finger on 2017/10/7.
//  Copyright © 2017年 finger. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKVideoInfoView : UIView
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *descText;
@property (strong, nonatomic) UILabel *commentLabel; //  视图
@property (strong, nonatomic) UILabel *likeLabel; //  标签
@property (strong, nonatomic) UIButton *likeBtn; //  标签
@property (nonatomic,strong) UIButton *commentButton; // 按钮
@property (nonatomic,strong) KKButton *moreButton; //  按钮
@property(nonatomic,assign,readonly)CGFloat viewHeight;

@property(nonatomic,copy)void(^changeViewHeight)(CGFloat height) ;

@property (strong, nonatomic) NSArray *tagArray;   // 数组
@end
