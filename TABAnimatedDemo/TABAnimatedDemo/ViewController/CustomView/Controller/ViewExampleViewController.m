//
//  AccredtationViewController.m
//
//  Created by tigerAndBull on 2019/2/27.
//  Copyright © 2019年 tigerAndBull. All rights reserved.
//

#import "ViewExampleViewController.h"
#import "TABDefine.h"

@import TABAnimated;

#define imgWidth kHeight(100)

@interface ViewExampleViewController ()

@property (nonatomic, strong) UIImageView *topImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *firstInfoLab;
@property (nonatomic, strong) UILabel *secondInfoLab;

@property (nonatomic, strong) UIButton *commitBtn;

@end

@implementation ViewExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    _topImg.image = [UIImage imageNamed:@"test.jpg"];
    _titleLab.text = @"您不会没有骨架过渡吧？";
    
    [self.view tab_startAnimationWithConfigBlock:nil
                                     adjustBlock:^(TABComponentManager * _Nonnull manager) {
        manager.animation(1).width(200);
        manager.animation(2).width(220);
        manager.animation(3).width(180);
        manager.create(10).width(200).height(12).leftEqualTo_offset(1, 30).topEqualTo_offset(1, 20);
    } completion:^{
        // 请求数据
        // ...
        // 获得数据
        // ...
        [self afterGetData];
    }];
}

- (void)afterGetData {
    [self.view tab_endAnimationEaseOut];
    
    _topImg.image = [UIImage imageNamed:@"test.jpg"];
    _titleLab.text = @"您不会没有骨架过渡吧？";
    _firstInfoLab.text = @"使用用TABAnimated 问题交流";
    _secondInfoLab.text = @"关注 tigerAndBull技术分享 公众号 进微信群";
    [_commitBtn setTitle:@"立即使用" forState:UIControlStateNormal];
    _commitBtn.layer.borderColor = UIColor.redColor.CGColor;
    _commitBtn.layer.borderWidth = 1.0;
}

- (void)reloadViewAnimated {
    self.view.tabAnimated.canLoadAgain = YES;
    [self.view tab_startAnimationWithCompletion:^{
        [self afterGetData];
    }];
}

#pragma mark - Init Method

- (void)initUI {
    [self.view addSubview:self.topImg];
    [self.view addSubview:self.titleLab];
    [self.view addSubview:self.firstInfoLab];
    [self.view addSubview:self.secondInfoLab];
    [self.view addSubview:self.commitBtn];
}

#pragma mark - Lazy Method

- (UIImageView *)topImg {
    if (!_topImg) {
        _topImg = [[UIImageView alloc] init];
        _topImg.frame = CGRectMake((kScreenWidth - imgWidth)/2.0, kNavigationHeight + kHeight(60), imgWidth, imgWidth);
        _topImg.layer.cornerRadius = imgWidth/2.0;
        _topImg.layer.masksToBounds = YES;
        _topImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _topImg;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.frame = CGRectMake(0, CGRectGetMaxY(self.topImg.frame)+kHeight(30), kScreenWidth, kHeight(30));
        _titleLab.font = kFont(20);
        _titleLab.textColor = UIColor.blackColor;
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

- (UILabel *)firstInfoLab {
    if (!_firstInfoLab) {
        _firstInfoLab = [[UILabel alloc] init];
        _firstInfoLab.frame = CGRectMake(0, CGRectGetMaxY(self.titleLab.frame)+kHeight(60), kScreenWidth, kHeight(20));
        _firstInfoLab.font = kFont(16);
        _firstInfoLab.textColor = UIColor.grayColor;
        _firstInfoLab.textAlignment = NSTextAlignmentCenter;
    }
    return _firstInfoLab;
}

- (UILabel *)secondInfoLab {
    if (!_secondInfoLab) {
        _secondInfoLab = [[UILabel alloc] init];
        _secondInfoLab.frame = CGRectMake(0, CGRectGetMaxY(self.firstInfoLab.frame)+kHeight(8), kScreenWidth, kHeight(20));
        _secondInfoLab.font = kFont(16);
        _secondInfoLab.textColor = UIColor.grayColor;
        _secondInfoLab.textAlignment = NSTextAlignmentCenter;
    }
    return _secondInfoLab;
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc] init];
        _commitBtn.frame = CGRectMake(kWidth(28), CGRectGetMaxY(self.secondInfoLab.frame)+kHeight(80), kScreenWidth - kWidth(28)*2, 55);
        [_commitBtn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        _commitBtn.layer.cornerRadius = 5.0f;
        [_commitBtn.titleLabel setFont:kFont(16)];
    }
    return _commitBtn;
}

@end
