//
//  JHImageView.h
//  JHImageContainer
//
//  Created by 307A on 16/5/24.
//  Copyright © 2016年 Jiahong Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHImageView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic) float max_width;
@property (nonatomic) float max_height;
@property (nonatomic) int max_cell_count_col;

///*
// * 加载本地图片（图片名称）
// *
// * 要求参数：图片名
// *
// * 返回参数：无
// */
//-(void)setupWithImageName:(NSString *)imageName;
//
///*
// * 加载本地图片（图片名称）
// *
// * 要求参数：缩略图图片名，原图图片名
// *
// *返回参数：无
// */
//-(void)setupWithThumbImageName:(NSString *)thumbImgName andOriginImageName:(NSString *)originImageName;
//
///*
// * 加载网络图片（图片url）
// *
// * 要求参数：图片url
// *
// * 返回参数：无
// */
//-(void)setupWithImageURL:(NSString *)imageURL;
//
///*
// * 加载网络图片（图片url）
// *
// * 要求参数：缩略图图片url，原图图片url
// *
// * 返回参数：无
// */
//-(void)setupWithThumbImageURL:(NSString *)thumbImgURL andOriginImage:(NSString *)originImageURL;
//
//
///*
// * 加载网络图片（图片url）
// *
// * 要求参数：缩略图图片url，原图图片url
// *
// * 返回参数：无
// */
-(void)setupWithThumbImgs:(NSMutableArray *)thumbImgs andOriginImgs:(NSMutableArray *)originImgs;
-(instancetype)initWithThumbImgs:(NSMutableArray *)thumbImgs andOriginImgs:(NSMutableArray *)originImgs;
@end
