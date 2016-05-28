//
//  ImageBean.m
//  JHImageContainer
//
//  Created by 307A on 16/5/29.
//  Copyright © 2016年 Jiahong Xu. All rights reserved.
//

#import "ImageBean.h"

@implementation ImageBean
-(instancetype)initWithThumbImg:(NSString *)thumbImg andOriginImg:(NSString *)originImg{
    self = [super init];
    if (self!=nil) {
        _thumbImage = thumbImg;
        _originImage = originImg;
    }
    return self;
}
@end
