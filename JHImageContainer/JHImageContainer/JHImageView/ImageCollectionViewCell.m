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
#import <Masonry/Masonry.h>

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ImageCollectionViewCell()

@property (nonatomic) UIImageView *thumbImageView;
@property (nonatomic) UIImageView *originImageView;
@property (nonatomic) UIScrollView *containerScrollView;
@property (nonatomic) UIView *blackBackgroundView;

@property (nonatomic) CGRect previousFrame;
@property (nonatomic) CGFloat currentScale;

@property (nonatomic) CGFloat touchX;
@property (nonatomic) CGFloat touchY;

@property (nonatomic) MBProgressHUD *waitingHud;
@property (nonatomic) UIView *waitingView;

@property (nonatomic) CGRect originalFrame;
@property (nonatomic) CGRect currentFrame;
@end

@implementation ImageCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.frame];
    }
    
    return self;
}

//-(void)zoomIn{
//    NSLog(@"Zoom In");
//    
//    UIImage *image_temp = _thumbImageView.image;
//    
////    获取位于父视图的相对位置
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    _originalFrame = [self convertRect:self.bounds toView:window];
//    
//    _containerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    _blackBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    
//    _containerScrollView.alpha = 1;
//    _containerScrollView.backgroundColor = [UIColor clearColor];
//    _containerScrollView.delegate = self;
//    _containerScrollView.maximumZoomScale = 3.0;
//    _containerScrollView.minimumZoomScale = 0.8;
//    _containerScrollView.contentSize = image_temp.size;
//    
//    _blackBackgroundView.alpha = 0;
//    _blackBackgroundView.backgroundColor = [UIColor blackColor];
//    
//    _originImageView.tag=1;
//    
//    _originImageView.frame = _originalFrame;
//    [_originImageView sd_setImageWithURL:[[NSURL alloc] initWithString:_bean.originImage] placeholderImage:_thumbImageView.image  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [self stopWaitingIndicator];
//        if (error) {
//            [self showAlertMsg:@"加载失败"];
//        }else{
//            _containerScrollView.contentSize = _originImageView.frame.size;
//        }
//    }];
//    
//    [_containerScrollView addSubview:_originImageView];
//    [window addSubview:_blackBackgroundView];
//    [window addSubview:_containerScrollView];
//    
//    [UIView animateWithDuration:_animateDuration animations:^{
//        _originImageView.frame=CGRectMake(0,
//                                          ([UIScreen mainScreen].bounds.size.height-_containerScrollView.contentSize.height*[UIScreen mainScreen].bounds.size.width/_containerScrollView.contentSize.width)/2,
//                                          [UIScreen mainScreen].bounds.size.width,
//                                          image_temp.size.height*[UIScreen mainScreen].bounds.size.width/image_temp.size.width);
//        _blackBackgroundView.alpha = 1;
//    }completion:^(BOOL finished) {
//    }];
//}

@end
