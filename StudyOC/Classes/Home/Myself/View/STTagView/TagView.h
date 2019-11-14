//
//  TagView.h
//  XiYuanPlus
//
//  Created by JS-Tiger on 2018/10/18.
//Copyright © 2018年 Hoping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagView : UIView

@property (nonatomic,copy) void(^tagButtonClick)(NSString *title);
@property (nonatomic,strong) NSArray        *dataSources;
@property (nonatomic,strong) NSMutableArray *selectButtonsArr;// 标签按钮数组
@property (strong, nonatomic) NSArray       *listDataArray;   // 数组
@property (nonatomic,copy) NSString         *identifier;
@end
