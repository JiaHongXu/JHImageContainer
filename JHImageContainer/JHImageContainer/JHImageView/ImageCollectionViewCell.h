//
//  ImageCollectionViewCell.h
//  JHImageContainer
//
//  Created by 307A on 16/5/26.
//  Copyright © 2016年 Jiahong Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate>
@property (nonatomic) float maxZoomScale;
@property (nonatomic) float minZoomScale;
@property (nonatomic) float animateDuration;

-(void) setupWithThumbImg:(NSString *) thumbImg andOriginImg:(NSString *) originImg;
@end
