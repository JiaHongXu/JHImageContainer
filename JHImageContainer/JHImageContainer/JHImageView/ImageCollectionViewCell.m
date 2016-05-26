//
//  ImageCollectionViewCell.m
//  JHImageContainer
//
//  Created by 307A on 16/5/26.
//  Copyright © 2016年 Jiahong Xu. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ImageCollectionViewCell()
@property (nonatomic) NSString *thumbImg;
@property (nonatomic) NSString *originImg;

@property (nonatomic) UIImageView *thumbImageView;
@property (nonatomic) UIImageView *originImageView;
@property (nonatomic) UIScrollView *containerScrollView;

@property (nonatomic) CGRect previousFrame;
@property (nonatomic) CGFloat currentScale;

@property (nonatomic) CGFloat touchX;
@property (nonatomic) CGFloat touchY;

@property (nonatomic) MBProgressHUD *waitingHud;
@property (nonatomic) UIView *waitingView;

@property (nonatomic) BOOL isShowingOriginImg;
@end

@implementation ImageCollectionViewCell
-(void)setupWithThumbImg:(NSString *)thumbImg andOriginImg:(NSString *)originImg{
    _thumbImg = thumbImg;
    _originImg = thumbImg;

    [self setup];
}

-(void) setup{
    _isShowingOriginImg = NO;
    
    _originImageView = [[UIImageView alloc] init];
    _thumbImageView = [[UIImageView alloc] initWithFrame:self.frame];
    
    [_thumbImageView sd_setImageWithURL:[[NSURL alloc] initWithString:_thumbImg] placeholderImage:[UIImage imageNamed:@"default_empty_photo"]];
    
    _thumbImageView.layer.masksToBounds = YES;
    _thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleTapRecognizer;
    singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //点击的次数
    singleTapRecognizer.numberOfTapsRequired = 1; // 单击
    
    // 双击的 Recognizer
    UITapGestureRecognizer* doubleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(DoubleTap:)];
    doubleRecognizer.numberOfTapsRequired = 2; // 双击
    
//    添加手势
    [_thumbImageView addGestureRecognizer:singleTapRecognizer];
    [_originImageView addGestureRecognizer:singleTapRecognizer];
    [_originImageView addGestureRecognizer:doubleRecognizer];
    
    // 关键在这一行，双击手势确定监测失败才会触发单击手势的相应操作
    [singleTapRecognizer requireGestureRecognizerToFail:doubleRecognizer];
}

-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    _isShowingOriginImg = !_isShowingOriginImg;
    //处理单击操作
    if (_isShowingOriginImg) {
//        关闭大图
        [self zoomOut];
    }else{
//        打开大图
        [self zoomIn];
    }
}

-(void)DoubleTap:(UITapGestureRecognizer*)recognizer
{
    //处理双击操作
}

-(void)zoomIn{
    
}

-(void)zoomOut{
    
}
@end
