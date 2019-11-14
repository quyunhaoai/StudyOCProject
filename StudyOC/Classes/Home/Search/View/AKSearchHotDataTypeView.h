//
//  AKSearchHotDataTypeView.h
//  zoneTry
//
//  Created by Zonetry on 16/7/19.
//  Copyright © 2016年 ZoneTry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKSearchHotDataTypeView : UIView
@property (assign, nonatomic) BOOL isShowAll; 
/******类方法创建对象*******/
+ (id)searchHotDataTypeViewWithFrame:(CGRect)frame category:(NSArray *)category;

/*
 *  AKSearchHotCell label click block
 */
@property (copy, nonatomic) void(^searchHotCellLabelClickButton)(NSInteger tag);

@property (strong, nonatomic) NSMutableArray *categortArray;  //  数组

@end
