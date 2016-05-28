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
@property (nonatomic) NSString *thumbImg;
@property (nonatomic) NSString *originImg;

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
-(id)init{
    if (self==nil) {
        self = [super init];
    }
    
    return self;
}

-(void)setupWithThumbImg:(NSString *)thumbImg andOriginImg:(NSString *)originImg{
    _thumbImg = thumbImg;
    _originImg = thumbImg;

    [self setup];
}

-(void) setup{
//    初始化变量
    _originImageView = [[UIImageView alloc] init];
    _thumbImageView = [[UIImageView alloc] initWithFrame:self.frame];
    _maxZoomScale = 3.0;
    _minZoomScale = 0.8;
    _animateDuration = 0.3;
    
    [self addSubview:_thumbImageView];

    _thumbImageView.layer.masksToBounds = YES;
    _thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    _originImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self registerGesture];
    
    [_thumbImageView sd_setImageWithURL:[[NSURL alloc] initWithString:_thumbImg] placeholderImage:[UIImage imageNamed:@"default_empty_photo"]];
    
}

-(void)thumbImgSingleTap:(UITapGestureRecognizer*)recognizer
{
    [self zoomIn];
}

-(void)originImgSingleTap:(UITapGestureRecognizer*)recognizer
{
    [self zoomOut];
}

-(void)originImg_DoubleTap:(UITapGestureRecognizer*)recognizer
{
    //处理双击操作
}

-(void)originImg_LongPress:(UILongPressGestureRecognizer*)press{
    //解决响应两次的问题
    if (press.state == UIGestureRecognizerStateEnded) {
        return;
    } else if (press.state == UIGestureRecognizerStateBegan) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到手机",nil];
        [sheet showInView:self];
    }
}

-(void)zoomIn{
    NSLog(@"Zoom In");
    
    UIImage *image_temp = _thumbImageView.image;
    
//    获取位于父视图的相对位置
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _originalFrame = [self convertRect:self.bounds toView:window];
    
    _containerScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _blackBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    _containerScrollView.alpha = 1;
    _containerScrollView.backgroundColor = [UIColor clearColor];
    _containerScrollView.delegate = self;
    _containerScrollView.maximumZoomScale = 3.0;
    _containerScrollView.minimumZoomScale = 0.8;
    _containerScrollView.contentSize = image_temp.size;
    
    _blackBackgroundView.alpha = 0;
    _blackBackgroundView.backgroundColor = [UIColor blackColor];
    
    _originImageView.tag=1;
    
    _originImageView.frame = _originalFrame;
    [_originImageView sd_setImageWithURL:[[NSURL alloc] initWithString:_originImg] placeholderImage:_thumbImageView.image  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self stopWaitingIndicator];
        if (error) {
            [self showAlertMsg:@"加载失败"];
        }else{
            _containerScrollView.contentSize = _originImageView.frame.size;
        }
    }];
    
    [_containerScrollView addSubview:_originImageView];
    [window addSubview:_blackBackgroundView];
    [window addSubview:_containerScrollView];
    
    [UIView animateWithDuration:_animateDuration animations:^{
        _originImageView.frame=CGRectMake(0,
                                          ([UIScreen mainScreen].bounds.size.height-_containerScrollView.contentSize.height*[UIScreen mainScreen].bounds.size.width/_containerScrollView.contentSize.width)/2,
                                          [UIScreen mainScreen].bounds.size.width,
                                          image_temp.size.height*[UIScreen mainScreen].bounds.size.width/image_temp.size.width);
        _blackBackgroundView.alpha = 1;
    }completion:^(BOOL finished) {
    }];
}

-(void)zoomOut{
    NSLog(@"Zoom Out");
    
    _containerScrollView.contentSize = _originalFrame.size;
    
    [UIView animateWithDuration:_animateDuration animations:^{
        _originImageView.frame=_originalFrame;
        _blackBackgroundView.alpha = 0;
    }completion:^(BOOL finished) {
        [_originImageView removeFromSuperview];
        [_containerScrollView removeFromSuperview];
        [_blackBackgroundView removeFromSuperview];
    }];
}

-(void)showAlertMsg:(NSString *)msg{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *alertHud = [MBProgressHUD showHUDAddedTo:_containerScrollView animated:YES];
        alertHud.mode = MBProgressHUDModeText;
        alertHud.labelText = msg;
        [alertHud hide:YES afterDelay:1];
    });
    
}

- (void)startWaitingIndicator
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更UI
        if(!_waitingView)
        {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            _waitingView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, window.bounds.size.width, window.bounds.size.height-64)];
            _waitingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
            [_containerScrollView addSubview:_waitingView];
            _waitingView.hidden = YES;
        }
        _waitingView.hidden = NO;
        
        _waitingHud = [MBProgressHUD showHUDAddedTo:_waitingView animated:YES];
    });
    
}

- (void)stopWaitingIndicator
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更UI
        [_waitingHud hide:YES];
        [_waitingView setHidden:YES];
    });
    
}

-(void)registerGesture{
    // 单击的 Recognizer
    UITapGestureRecognizer* thumbImg_SingleTapRecognizer;
    thumbImg_SingleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thumbImgSingleTap:)];
    //点击的次数
    thumbImg_SingleTapRecognizer.numberOfTapsRequired = 1; // 单击
    
    // 单击的 Recognizer
    UITapGestureRecognizer* originImg_SingleTapRecognizer;
    originImg_SingleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(originImgSingleTap:)];
    //点击的次数
    originImg_SingleTapRecognizer.numberOfTapsRequired = 1; // 单击
    
    
    // 双击的 Recognizer
    UITapGestureRecognizer* originImg_DoubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(originImg_DoubleTap:)];
    originImg_DoubleTapRecognizer.numberOfTapsRequired = 2; // 双击
    
    
    // 长按的 Recognizer
    UILongPressGestureRecognizer *originImg_LongPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(originImg_LongPress:)];
    originImg_LongPressRecognizer.delegate = self;
    originImg_LongPressRecognizer.minimumPressDuration = 1.0;
    
    //    添加手势
    [_thumbImageView addGestureRecognizer:thumbImg_SingleTapRecognizer];
    
    [_originImageView addGestureRecognizer:originImg_SingleTapRecognizer];
    [_originImageView addGestureRecognizer:originImg_DoubleTapRecognizer];
    [_originImageView addGestureRecognizer:originImg_LongPressRecognizer];
    
    _thumbImageView.userInteractionEnabled = YES;
    _originImageView.userInteractionEnabled = YES;
    
    // 关键在这一行，双击手势确定监测失败才会触发单击手势的相应操作
    [originImg_SingleTapRecognizer requireGestureRecognizerToFail:originImg_DoubleTapRecognizer];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self saveImageToAlbum];
            break;
            
        default:
            break;
    }
}

- (void)saveImageToAlbum {
    UIImageWriteToSavedPhotosAlbum(_originImageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [self showAlertMsg:@"成功保存到相册"];
    }else
    {
        [self showAlertMsg:@"保存失败"];
    }
}
@end
