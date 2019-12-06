//
//  EmotionSelector.h
//  Douyin
//
//  Created by Qiao Shi on 2018/7/30.
//  Copyright © 2018年 Qiao Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SafeAreaBottomHeight ((ScreenHeight >= 812.0) && [[UIDevice currentDevice].model isEqualToString:@"iPhone"]  ? 30 : 0)
#define EmotionSelectorHeight   220 + SafeAreaBottomHeight
#define ColorSmoke RGBA(230.0, 230.0, 230.0, 1.0)
@protocol EmotionSelectorDelegate
@required
-(void)onDelete;
-(void)onSend;
-(void)onSelect:(NSString *)emotionKey;
@end

@interface EmotionSelector : UIView
@property (nonatomic, strong) UIView                     *container;
@property (nonatomic, strong) UICollectionView           *collectionView;
@property (nonatomic, weak) id<EmotionSelectorDelegate>  delegate;
-(void)addTextViewObserver:(UITextView *)textView;
- (void)removeTextViewObserver:(UITextView *)textView;
@end

@interface EmotionCell:UICollectionViewCell
@property (nonatomic, strong) UIImageView     *emotion;
@property (nonatomic, copy) NSString          *emotionKey;
- (void)setDelete;
- (void)initData:(NSString *)key;
@end
