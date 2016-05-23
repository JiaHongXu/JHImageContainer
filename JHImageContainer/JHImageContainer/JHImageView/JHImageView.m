//
//  JHImageView.m
//  JHImageContainer
//
//  Created by 307A on 16/5/24.
//  Copyright © 2016年 Jiahong Xu. All rights reserved.
//

#import "JHImageView.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDAutoLayout/UIView+SDAutoLayout.h>

@interface JHImageView()

@property (nonatomic) UIImageView *thumbImageView;
@property (nonatomic) UIImageView *originImageView;
@property (nonatomic) UIScrollView *containerScrollView;

@property (nonatomic) CGRect previousFrame;
@property (nonatomic) CGFloat currentScale;

@property (nonatomic) CGFloat touchX;
@property (nonatomic) CGFloat touchY;

@property (nonatomic) MBProgressHUD *waitingHud;
@property (nonatomic) UIView *waitingView;
@end

@implementation JHImageView


@end
