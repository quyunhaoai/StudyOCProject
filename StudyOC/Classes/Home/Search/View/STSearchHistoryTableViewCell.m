//
//  STSearchHistoryTableViewCell.m
//  StudyOC
//
//  Created by 研学旅行 on 2019/10/21.
//  Copyright © 2019 研学旅行. All rights reserved.
//

#import "STSearchHistoryTableViewCell.h"
#import "AKSearchHotDataTypeView.h"
@implementation STSearchHistoryTableViewCell
+ (instancetype)initializationCellWithTableView:(UITableView *)tableView {
    static NSString *ID  = @"STSearchHistoryTableViewCell";
    id cell  = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kClearColor;
    }
    return self;
}

- (void)initCell {
    _searchHotDataTypeView = [[AKSearchHotDataTypeView alloc] initWithFrame:CGRectMake(0,
                                                                                       5,
                                                                                       Window_W,
                                                                                       self.frame.size.height)];
    XYWeakSelf;
    _searchHotDataTypeView.searchHotCellLabelClickButton = ^(NSInteger tag) {
        weakSelf.searchHotCellLabelClickButton(tag);
    };
    [self addSubview:_searchHotDataTypeView];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setHistoryArray:(NSMutableArray *)historyArray {
    _historyArray = historyArray;
    self.searchHotDataTypeView.categortArray = _historyArray;
}
#pragma mark - model
- (void)setRecommendModelArray:(NSMutableArray *)recommendModelArray {
    _recommendModelArray = recommendModelArray;
    if (self.searchHotDataTypeView) {
        [self.searchHotDataTypeView removeFromSuperview];
    }
    _searchHotDataTypeView = [AKSearchHotDataTypeView searchHotDataTypeViewWithFrame:CGRectMake(0, 5, Window_W, self.frame.size.height) category:_recommendModelArray];
    XYWeakSelf;
    _searchHotDataTypeView.searchHotCellLabelClickButton = ^(NSInteger tag) {
        weakSelf.searchHotCellLabelClickButton(tag);
    };
    [self addSubview:self.searchHotDataTypeView];
}
@end
