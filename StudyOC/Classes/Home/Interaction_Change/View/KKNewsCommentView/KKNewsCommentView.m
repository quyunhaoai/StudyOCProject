//
//  KKNewsCommentView.m
//  KKToydayNews
//
//  Created by finger on 2017/10/3.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKNewsCommentView.h"
#import "KKLoadingView.h"
#import "KKBottomBar.h"
#import "KKNewsCommentCell.h"
#import "ZMCusCommentListView.h"
#import "LKContentModel.h"

#define BottomBarHeight (HOME_INDICATOR_HEIGHT + 44)

static NSString *commentCellReuseable = @"commentCellReuseable";

@interface KKNewsCommentView ()<KKBottomBarDelegate,KKCommentDelegate>
@property(nonatomic)KKBottomBar *bottomBar;
@property(nonatomic)KKLoadingView *loadingView;
@property(nonatomic)NSMutableArray *commentArray;//评论数组
@property (nonatomic, strong) ZMCusCommentListView *commentListView;
/** 数据模型 */
@property (nonatomic, strong) NSMutableArray *modelArr;
@end

@implementation KKNewsCommentView
- (NSMutableArray *)modelArr
{
    if (_modelArr == nil)
    {
        _modelArr = [NSMutableArray array];
    }
    return _modelArr;
}
- (instancetype)initWithNewsBaseInfo:(id)newsInfo{
    self = [super init];
    if(self){
        self.topSpace = 0 ;
        self.navContentOffsetY = 0 ;
        self.navTitleHeight = 44 ;
        self.contentViewCornerRadius = 10 ;
        self.cornerEdge = UIRectCornerTopRight|UIRectCornerTopLeft;
        [self initUI];
    }
    return self ;
}

#pragma mark -- 视图的显示和消失

- (void)viewWillAppear{
    [super viewWillAppear];
//    [self initUI];
}

- (void)viewWillDisappear{
    [super viewWillDisappear];
}

#pragma mark -- 初始化UI

- (void)initUI{
    // 创建表格
    if (!_commentListView) {
        _commentListView = [[ZMCusCommentListView alloc] initWithFrame:CGRectZero];
        [self.dragContentView addSubview:_commentListView];
        [_commentListView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.navTitleView.mas_bottom);
            make.left.width.mas_equalTo(self.dragContentView);
            make.height.mas_equalTo(self.dragContentView).mas_offset(-BottomBarHeight-self.navTitleHeight).priority(998);
        }];
    }
    [self.dragContentView insertSubview:self.bottomBar aboveSubview:self.commentListView];
    [self initNavBar];
    [self.bottomBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.dragContentView);
        make.bottom.mas_equalTo(self.dragContentView);
        make.width.mas_equalTo(self.dragContentView).priority(998);
        make.height.mas_equalTo(BottomBarHeight);
    }];
    self.bottomBar.splitView.backgroundColor = kBlackColor;
    [self sss];
}
- (void)sss {
    // 请求数据
      NSArray *dataArr = @[
                          @{@"username":@"橘瑠衣",
                            @"identifier":@"aaa1",
                            @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿",
                            @"replay":@[
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb1",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"},
                                      @{@"username":@"橘阳菜",
                                        @"identifier":@"bbb2",
                                        @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"}
                                      ]
                            },
                          
                          @{@"username":@"橘瑠衣",
                            @"identifier":@"aaa2",
                            @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿0",
                            @"replay":@[
                                    @{@"username":@"橘阳菜",
                                      @"identifier":@"bbbb1",
                                      @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿1"},
                                    @{@"username":@"橘阳菜",
                                      @"identifier":@"bbbb3",
                                      @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿2"},
                                    @{@"username":@"橘阳菜",
                                      @"identifier":@"bbbb4",
                                      @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿3"}
                                    
                                    ]
                            },
                          
                          @{@"username":@"橘瑠衣",
                            @"identifier":@"aaa3",
                            @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿",
                            @"replay":@[
                                    @{@"username":@"橘阳菜",
                                      @"identifier":@"bbbbb",
                                      @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿"}
                                    
                                    ]
                            },
                          
                          @{@"username":@"橘瑠衣",
                            @"identifier":@"aaa4",
                            @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿",
                            @"replay":@[
                                    ]
                            },
                          
                          @{@"username":@"橘瑠衣",
                            @"identifier":@"aaa5",
                            @"content":@"人生若只如初见何事秋风悲画扇等闲变却故人心却道故人心易变骊山语罢清宵半泪雨零铃终不怨何如薄幸锦衣郎比翼连枝当日愿",
                            @"replay":@[
                                    ]
                            }
                          
                          ];
      [self.modelArr removeAllObjects];
      for (NSDictionary *dic in dataArr)
      {
          LKContentModel *model = [LKContentModel modelWithDict:dic];
          model.moreText = [NSString stringWithFormat:@"展开%ld条回复",model.maxReplayCount];
          [self.modelArr addObject:model];
      }
      // 发送通知数据
      NSDictionary *dict = @{@"data":self.modelArr};
      [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHCONTENTDATA" object:nil userInfo:dict];
}
#pragma mark -- 导航栏

- (void)initNavBar{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 30, 30)];
    [backButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(startHide) forControlEvents:UIControlEventTouchUpInside];
    self.navTitleView.rightBtns = @[backButton];
    self.navTitleView.title = @"评论";
    self.navTitleView.titleLabel.textColor = kWhiteColor;
    self.navTitleView.splitView.backgroundColor = KKColor(21, 20, 21, 1.0);
}

#pragma mark -- 加载评论

- (void)loadCommentData{

}

#pragma mark -- 显示个人评论详情视图

- (void)showPersonalCommentWithId:(NSString *)commentId{

}

#pragma mark -- KKBottomBarDelegate

- (void)sendCommentWidthText:(NSString *)text{
    NSLog(@"%@",text);
}

#pragma mark -- KKCommentDelegate

- (void)diggBtnClick:(NSString *)commemtId callback:(void (^)(BOOL))callback{
    NSLog(@"commentId:%@",commemtId);
}

- (void)showAllComment:(NSString *)commentId{
    [self showPersonalCommentWithId:commentId];
}

- (void)jumpToUserPage:(NSString *)userId{

}

- (void)setConcern:(BOOL)isConcern userId:(NSString *)userId callback:(void (^)(BOOL))callback{
    if(callback){
        callback(YES);
    }
    NSLog(@"isConcern:%d,userId:%@",isConcern,userId);
}

#pragma mark -- 开始、拖拽中、结束拖拽

- (void)dragBeginWithPoint:(CGPoint)pt{
    
}

- (void)dragingWithPoint:(CGPoint)pt{
    self.commentListView.tableView.scrollEnabled = NO ;
}

- (void)dragEndWithPoint:(CGPoint)pt shouldHideView:(BOOL)hideView{
    self.commentListView.tableView.scrollEnabled = YES ;
}

#pragma mark -- @property

- (KKBottomBar *)bottomBar{
    if(!_bottomBar){
        _bottomBar = ({
            KKBottomBar *view = [[KKBottomBar alloc]initWithBarType:KKBottomBarTypePictureComment];
            view.backgroundColor = kBlackColor;
            view.delegate = self ;
            view ;
        });
    }
    return _bottomBar;
}

- (NSMutableArray *)commentArray{
    if(!_commentArray){
        _commentArray = [NSMutableArray arrayWithArray:@[@"",@"",@"",@""]];
    }
    return _commentArray;
}

@end
