//
//  CoverView.h
//  JHImageContainer
//
//  Created by 307A on 16/5/30.
//  Copyright © 2016年 Jiahong Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoverView : UIView<UIScrollViewDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate>
@property (nonatomic) float maxZoomScale;
@property (nonatomic) float minZoomScale;
@property (nonatomic) float animateDuration;

-(instancetype) initWithThumbImgURLs:(NSMutableArray *)thumbImgURLs andOriginImgURLs:(NSMutableArray *)originImgURLs;
@end
