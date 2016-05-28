//
//  ImageBean.h
//  JHImageContainer
//
//  Created by 307A on 16/5/29.
//  Copyright © 2016年 Jiahong Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageBean : NSObject
@property (nonatomic) NSString *originImage;
@property (nonatomic) NSString *thumbImage;

-(instancetype)initWithThumbImg:(NSString *)thumbImg andOriginImg:(NSString *)originImg;
@end
