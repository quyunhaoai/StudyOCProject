//
//  STSearchAllViewController.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/21.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STSearchAllViewController.h"
#import "STSearchHotTableViewCell.h"
#import "STSearchHistoryTableViewCell.h"

#import "STSearchTableViewSetionHeaderView.h"
@interface STSearchAllViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIButton *rightNavBtn; //  按钮
@property (strong, nonatomic) UITextField *searchTextField;  // 文本框
@end

@implementation STSearchAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI {
    self.view.userInteractionEnabled = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    [self customNavBarWithSearchTitle:@"" andRightButtonStr:@"" andLeftStr:@""];
}
#pragma mark  -  搜索框和左右边按钮
- (void)customNavBarWithSearchTitle:(NSString *)searchTltle andRightButtonStr:(NSString *)rightBtnStr andLeftStr:(NSString *)title{
    

    //搜索框
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, NAVIGATION_BAR_HEIGHT)];
    [self.view addSubview:searchView];
    searchView.userInteractionEnabled = YES;
    searchView.backgroundColor = kBlackColor;

    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(8, 6, 16, 16)];
    [searchView addSubview:searchImage];
    searchImage.image = ImageNamed(@"searchIcon");
    
    UITextField *titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(17, STATUS_BAR_HEIGHT+10, searchView.frame.size.width-16-75, 25)];
    titleTextField.textColor =kWhiteColor;
    titleTextField.font = FONT_11;
    [searchView addSubview:titleTextField];
    titleTextField.text = searchTltle;
    [titleTextField setUserInteractionEnabled:YES];
    titleTextField.leftView = searchImage;
    titleTextField.placeholder = @"请输入搜索关键词";
    titleTextField.placeholderColor = [UIColor colorWithRed:112.0f/255.0f green:112.0f/255.0f blue:112.0f/255.0f alpha:1.0f] ;
    titleTextField.borderStyle = UITextBorderStyleBezel;
    titleTextField.clearButtonMode = UITextFieldViewModeAlways;
    titleTextField.layer.masksToBounds = YES;
    titleTextField.layer.cornerRadius = 8;
    titleTextField.layer.borderColor = [[UIColor colorWithRed:83.0f/255.0f green:83.0f/255.0f blue:83.0f/255.0f alpha:1.0f] CGColor];
    titleTextField.layer.borderWidth = 1;
    titleTextField.alpha = 1;
    self.searchTextField = titleTextField;
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"请输入搜索关键词"];
//    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Nirmala UI" size:5.5f] range:NSMakeRange(0, 8)];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:112.0f/255.0f green:112.0f/255.0f blue:112.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 8)];
//    self.searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, searchView.size.width, searchView.size.height)];
//    [searchView addSubview:self.searchBtn];
//    [self.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];

    self.rightNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightNavBtn.frame = CGRectMake(Window_W - 40 - 12, STATUS_BAR_HEIGHT+3, 40, 40);
    [self.rightNavBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.rightNavBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.rightNavBtn setTitleColor:color_textBg_C7C7D1 forState:UIControlStateNormal];
    self.rightNavBtn.titleLabel.font = FONT_16;
    [self.rightNavBtn setUserInteractionEnabled:YES];
    [searchView addSubview:self.rightNavBtn];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchTextField resignFirstResponder];
}
- (void)rightBtnClick:(UIButton *)button {
    [self.searchTextField resignFirstResponder];
    
//    [_contentView setFrame:CGRectMake(0, Window_H - maskHeight, Window_W, maskHeight)];
      [UIView animateWithDuration:0.3f
                       animations:^{
                           
                           self.view.alpha = 0.0;
                           
//                           [self->_contentView setFrame:CGRectMake(0, Window_H, Window_W, maskHeight)];
                       }
                       completion:^(BOOL finished){
                           
                           [self.view removeFromSuperview];
//                           [self->_contentView removeFromSuperview];
                           
                       }];
}
#pragma mark - tableview delegate dataSource protocol
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [STSearchHotTableViewCell initializationCellWithTableView:tableView];
        
    } else {
        cell = [STSearchHistoryTableViewCell initializationCellWithTableView:tableView];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
//    if (indexPath.section == 0) {
//        CGFloat height = 0.001f;
//        @autoreleasepool {
//            CGRect lastFrame = CGRectMake(0, 0, 0, 0);
//            for (int i = 0; i < self.recommendModelArray.count; i++) {
//                CGFloat windth = [NSString calculateFrameWidth:kScreenWidth-bigHorizontalMargin*2 text:self.recommendModelArray[i] height:30 fontsize:13.f];
//
//                UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(bigHorizontalMargin + CGRectGetMaxX(lastFrame), bigVerticalMargin+CGRectGetMaxY(lastFrame), windth + 20, 30.f)];
//                if (windth + 20 + bigHorizontalMargin*2 + CGRectGetMaxX(lastFrame) > Window_W - 20) {
//                    baseLabel.x = bigHorizontalMargin;
//                    baseLabel.y = CGRectGetMaxY(lastFrame) + 15;
//                }
//                else {
//                    baseLabel.y = CGRectGetMinY(lastFrame);
//                }
//                lastFrame = baseLabel.frame;
//                height = baseLabel.y + 30 + 15;
//            }
//        }
//        return height;
//    } else {
//        if (self.historyArray.count > 0) {
//            CGFloat height = 0.001f;
//            @autoreleasepool {
//                CGRect lastFrame = CGRectMake(0, 0, 0, 0);
//                for (int i = 0; i < self.historyArray.count; i++) {
//                    CGFloat windth = [NSString calculateFrameWidth:kScreenWidth-bigHorizontalMargin*2 text:self.historyArray[i] height:30 fontsize:13.f];
//
//                    UILabel *baseLabel = [[UILabel alloc] initWithFrame:CGRectMake(bigHorizontalMargin + CGRectGetMaxX(lastFrame), bigVerticalMargin+CGRectGetMaxY(lastFrame), windth + 20, 30.f)];
//                    if (windth + 20 + bigHorizontalMargin*2 + CGRectGetMaxX(lastFrame) > Window_W - 20) {
//                        baseLabel.x = bigHorizontalMargin;
//                        baseLabel.y = CGRectGetMaxY(lastFrame) + 15;
//                    }
//                    else {
//                        baseLabel.y = CGRectGetMinY(lastFrame);
//                    }
//                    lastFrame = baseLabel.frame;
//                    height = baseLabel.y + 30 + 15;
//                }
//            }
//            return height;
//        }
//        else {
//            return .00001f;
//        }
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        STSearchTableViewSetionHeaderView *headerView = [[STSearchTableViewSetionHeaderView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 40)];
        headerView.itemLabel.text = @"大家都在搜";
//        headerView.itemButton.hidden = YES;
        [headerView.itemButton addTarget:self action:@selector(openItem:) forControlEvents:(UIControlEventTouchUpInside)];
        return headerView;
    } else {
        STSearchTableViewSetionHeaderView *headerView = [[STSearchTableViewSetionHeaderView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 40)];
        headerView.itemLabel.text = @"搜索历史";
        [headerView.itemButton setBackgroundImage:[UIImage imageNamed:@"search_delete"] forState:(UIControlStateNormal)];
        [headerView.itemButton addTarget:self action:@selector(openItem:) forControlEvents:(UIControlEventTouchUpInside)];
//        if (self.historyArray.count == 0) {
//            headerView.itemButton.hidden = YES;
//        }else{
//            headerView.itemButton.hidden = NO;
//        }
        return headerView;
    }
//                return [[UIView alloc] init];
}
- (void)openItem:(UIButton *)button {
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        return [[UIView alloc] init];
//    } else {
//        if (self.historyArray.count == 0) {
//            self.footerView = [self layoutFooterViewMethod:@"暂无历史搜索"];
//            return self.footerView;
//        }
//        else {
            return [[UIView alloc] init];
//        }
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    if (section == 0) {
//        return 0.00001f;
//    } else {
//        if (self.historyArray.count == 0) {
//            return 45 * 11;
//        }
//        else {
            return 0.00001f;
//        }
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchTextField resignFirstResponder];
}

@end
