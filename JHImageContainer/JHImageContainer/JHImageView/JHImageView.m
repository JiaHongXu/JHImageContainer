//
//  JHImageView.m
//  JHImageContainer
//
//  Created by 307A on 16/5/24.
//  Copyright © 2016年 Jiahong Xu. All rights reserved.
//

#import "JHImageView.h"

#import <Masonry/Masonry.h>


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface JHImageView()
@property (nonatomic) NSInteger height;
@property (nonatomic) NSInteger width;

@property (nonatomic) CGFloat cell_width;

@property (nonatomic) NSMutableArray *thumbImageArray;
@property (nonatomic) NSMutableArray *originImageArray;

@end

@implementation JHImageView

- (void)setup{
    
}

- (void)setupWithThumbImageURL:(NSString *)thumbImgURL andOriginImage:(NSString *)originImageURL{
    
}

- (void)setupWithThumbImgs:(NSMutableArray *)thumbImgs andOriginImgs:(NSMutableArray *)originImgs{
    _thumbImageArray = thumbImgs;
    _originImageArray = originImgs;
    
    [self setup];
}

- (void)initUI{
    
}

- (void)initData{
    
}
@end
