//
//  OneSectionWithHeaderSectionViewController.m
//  AnimatedDemo
//
//  Created by tigerAndBull on 2020/5/4.
//  Copyright © 2020 tigerAndBull. All rights reserved.
//

#import "OneSectionWithHeaderSectionViewController.h"

#import "TestTableViewCell.h"

#import "LabWithLinesViewCell.h"
#import "TestTableHeaderFooterView.h"

@import TABAnimated;
#import "TABDefine.h"

#import "Game.h"

@interface OneSectionWithHeaderSectionViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *dataArray;
    Game *game;
}

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation OneSectionWithHeaderSectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    [self initUI];
    
    // 启动动画
    // 这里使用了自定义延迟时间的启动函数，设置3秒是为了演示效果。
    // 非特殊场景情况下，建议使用`tab_startAnimationWithCompletion`。
    [self.tableView tab_startAnimationWithCompletion:^{
        // 请求数据
        // ...
        // 获得数据
        // ...
        [self afterGetData];
    }];
}

- (void)injected {
    [_tableView removeFromSuperview];
    _tableView = nil;
    [self viewDidLoad];
}

- (void)reloadViewAnimated {
    _tableView.tabAnimated.canLoadAgain = YES;
    [_tableView tab_startAnimationWithCompletion:^{
        [self afterGetData];
    }];
}

#pragma mark - Target Methods

/**
 获取到数据后
 */
- (void)afterGetData {
    
    [dataArray removeAllObjects];
    // 模拟数据
    for (int i = 0; i < 10; i ++) {
        Game *game = [[Game alloc]init];
        game.gameId = [NSString stringWithFormat:@"%d",i];
        game.title = [NSString stringWithFormat:@"这里是测试数据%d",i+1];
        game.cover = @"test.jpg";
        [dataArray addObject:game];
    }
    
    // 停止动画,并刷新数据
    [self.tableView tab_endAnimationEaseOut];
}

#pragma mark - UITableViewDelegate & Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *str = @"TestTableHeaderFooterView";
    TestTableHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:str];
    if (!headerView) {
        headerView = [[TestTableHeaderFooterView alloc] initWithReuseIdentifier:str];
    }
    [headerView initWithData:game];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str = @"TestTableViewCell";
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell initWithData:dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Initize Methods

/**
 load data
 加载数据
 */
- (void)initData {
    dataArray = [NSMutableArray array];
    game = [[Game alloc]init];
    game.gameId = [NSString stringWithFormat:@"%d",0];
    game.title = [NSString stringWithFormat:@"这里是测试数据%d",1];
    game.cover = @"test.jpg";
}

/**
 initize view
 视图初始化
 */
- (void)initUI {
    [self.view addSubview:self.tableView];
}

#pragma mark - Lazy Methods

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor tab_normalDynamicBackgroundColor];
        
        _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[TestTableViewCell class] cellHeight:100];
        [_tableView.tabAnimated addHeaderViewClass:[TestTableHeaderFooterView class] viewHeight:100 toSection:0];
        _tableView.tabAnimated.canLoadAgain = YES;
        _tableView.tabAnimated.adjustWithClassBlock = ^(TABComponentManager *manager, __unsafe_unretained Class targetClass) {
            if (targetClass == TestTableViewCell.class) {
               manager.animation(1).down(3).height(12);
               manager.animation(2).height(12).width(110);
               manager.animation(3).down(-5).height(12);
            }
        };
    }
    return _tableView;
}

@end
