//
//  PullLoadingTableViewController.m
//  TABAnimatedDemo
//
//  Created by tigerAndBull on 2020/5/4.
//  Copyright © 2020 tigerAndBull. All rights reserved.
//

#import "PullLoadingTableViewController.h"

#import "TestTableViewCell.h"

#import "LabWithLinesViewCell.h"

@import TABAnimated;
#import "TABDefine.h"

#import "Game.h"
#import "DailyTableViewCell.h"

@interface PullLoadingTableViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *dataArray;
    NSInteger pageIndex;
    NSInteger pageCount;
}

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation PullLoadingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    pageIndex = 0;
    pageCount = 10;
    
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
    pageIndex = 0;
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
    [self _addData];
    // 停止动画,并刷新数据
    [self.tableView tab_endAnimationEaseOut];
}

- (void)loadMoreData {
    [self.tableView tab_stopPullLoading];
    [self _addData];
    [self.tableView reloadData];
}

- (void)_addData {
    for (int i = 0; i < pageCount; i ++) {
        Game *game = [[Game alloc]init];
        game.gameId = [NSString stringWithFormat:@"%ld",(long)(i+pageIndex*pageCount)];
        game.title = [NSString stringWithFormat:@"这里是测试数据%ld",(long)(i+1+pageIndex*pageCount)];
        game.cover = @"test.jpg";
        [dataArray addObject:game];
    }
    pageIndex++;
}

#pragma mark - UITableViewDelegate & Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor tab_normalDynamicBackgroundColor];
        
        // 设置tabAnimated相关属性
        // 可以不进行手动初始化，将使用默认属性
        _tableView.tabAnimated = [TABTableAnimated animatedWithCellClass:[TestTableViewCell class] cellHeight:100];
        _tableView.tabAnimated.canLoadAgain = YES;
//        _tableView.tabAnimated.superAnimationType = TABViewSuperAnimationTypeShimmer;
        _tableView.tabAnimated.adjustBlock = ^(TABComponentManager * _Nonnull manager) {
            manager.animation(1).down(3).height(12);
            manager.animation(2).height(12).reducedWidth(40).toShortAnimation();
            manager.animation(3).down(-5).height(12).radius(0.).reducedWidth(-20).toLongAnimation();
        };
        [_tableView tab_addPullLoadingActionHandler:^{
            // 模拟数据请求
            [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:1.2];
        }];
    }
    return _tableView;
}

@end
