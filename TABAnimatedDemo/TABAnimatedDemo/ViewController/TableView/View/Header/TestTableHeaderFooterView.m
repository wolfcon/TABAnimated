//
//  TestTableHeaderFooterView.m
//  TABAnimatedDemo
//
//  Created by tigerAndBull on 2019/8/2.
//  Copyright © 2019 tigerAndBull. All rights reserved.
//

#import "TestTableHeaderFooterView.h"


#import "Game.h"

#import "Masonry.h"
#import "TABDefine.h"

@import TABAnimated;

@interface TestTableHeaderFooterView()

@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentLab;

@end

@implementation TestTableHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 布局
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(15);
        make.width.mas_offset(self.frame.size.height-20);
        make.height.mas_offset(self.frame.size.height-20);
    }];
    
    self.headImg.layer.cornerRadius = (self.frame.size.height-20)/2;
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).mas_offset(10);
        make.top.mas_offset(25);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.height.mas_offset(20);
    }];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImg.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.height.mas_offset(20);
    }];
}

#pragma mark - Public Methods

- (void)initWithData:(Game *)game {
    self.titleLab.text = game.title;
    self.contentLab.text = game.content;
    self.headImg.image = [UIImage imageNamed:game.cover];
}

#pragma mark - Initize Methods

- (void)initUI {
    
    UIView *backView = UIView.new;
    backView.frame = self.bounds;
    backView.backgroundColor = UIColor.whiteColor;
    [self addSubview:backView];
    
    {
        UIImageView *img = [[UIImageView alloc] init];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.layer.masksToBounds = YES;
        self.headImg = img;
        [self addSubview:img];
    }
    
    {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = kFont(16);
        lab.textAlignment = NSTextAlignmentLeft;
        lab.textColor = [UIColor blackColor];
        self.titleLab = lab;
        [self addSubview:lab];
    }
    
    {
        UILabel *lab = [[UILabel alloc] init];
        lab.font = kFont(14);
        lab.textAlignment = NSTextAlignmentLeft;
        lab.textColor = [UIColor grayColor];
        self.contentLab = lab;
        [self addSubview:lab];
    }
}


@end
