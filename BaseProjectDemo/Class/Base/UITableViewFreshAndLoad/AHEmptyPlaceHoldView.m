//
//  AHEmptyPlaceHoldView.m
//  NiuNiuLive
//
//  Created by ComAnvei on 17/3/28.
//  Copyright © 2017年 AH. All rights reserved.
//

#import "AHEmptyPlaceHoldView.h"

@interface AHEmptyPlaceHoldView()

/**
 高亮状态
 */
@property(nonatomic,assign)BOOL isHightLight;

/**
 图片
 */
@property(nonatomic,strong)UIImageView *imageView;

/**
 提示label
 */
@property(nonatomic,strong)UILabel *titleLabel;

/**
 提示string
 */
@property(nonatomic,strong)NSString *customTitle;

/**
 图片加了时间点击重新加载
 */
@property(nonatomic,weak)id <ReloadNewData> delegate;
@end

@implementation AHEmptyPlaceHoldView
-(instancetype)initWithIsHighLighted:(BOOL)hightlighted andTitle:(NSString*)title AndDelegate:(id <ReloadNewData>)delegate{
    if ([super init]) {
        self.isHightLight = hightlighted;
        self.customTitle = title;
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, DEVICE_SCREEN_WIDTH, DEVICE_SCREEN_HEIGHT);
        _delegate = delegate;
    }
    return self;
}

-(void)setUpWithIsHighLighted:(BOOL)hightlighted andTitle:(NSString*)title{
    self.isHightLight = hightlighted;
    self.customTitle = title;
    if (_isHightLight) {
        _titleLabel.textColor = UIColorFromRGB(198, 198, 198, 1);
        _imageView.image = [UIImage imageNamed:@"icon_home_nothing"];
    }else{
        _imageView.image = [UIImage imageNamed:@"icon_home2_nothing"];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
}

-(void)showOnTheView:(UIView*)view{
    //之前用的boundsd但是下拉的时候bounds要改变，所以这里没有手写。
    self.frame = CGRectMake(0, 0, view.width, view.height);
    [view addSubview:self];
    [self setUpView];
    [self.titleLabel sizeToFit];
}

-(void)setUpView{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150*self.height/(CGFloat)DEVICE_SCREEN_HEIGHT, 150*self.height/(CGFloat)DEVICE_SCREEN_HEIGHT)];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [_imageView addTarget:self action:@selector(reloadNewData)];
    _titleLabel =  [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 48)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = _customTitle;
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(30);
    }];
    if (_isHightLight) {
        _titleLabel.textColor = [UIColor whiteColor];
        _imageView.image = [UIImage imageNamed:@"icon_home_nothing"];
    }else{
        _imageView.image = [UIImage imageNamed:@"icon_home2_nothing"];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
}

-(void)setCustomTitle:(NSString *)customTitle{
    _customTitle = customTitle;
    self.titleLabel.text = customTitle;
}

-(void)reloadNewData{
    if (self.delegate) {
        [self.delegate reloadNewData];
    }
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
