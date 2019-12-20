//
//  ViewController.h
//  ZJIndexContacts
//
//  Created by ZeroJ on 16/10/10.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDragableNavBaseView.h"
@protocol ZJContactViewControllerDelegate <NSObject>

@optional

/**
 Delegate 回调所选国家代码

 @param personName 所选人名
 */
-(void)returnPersonName:(NSString *)personName ;

@end
@interface ZJContactViewController : KKDragableNavBaseView
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) id<ZJContactViewControllerDelegate> delegate;    //
@end

