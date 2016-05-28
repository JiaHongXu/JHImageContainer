//
//  JHImageView.m
//  JHImageContainer
//
//  Created by 307A on 16/5/24.
//  Copyright © 2016年 Jiahong Xu. All rights reserved.
//

#import "JHImageView.h"
#import "ImageCollectionViewCell.h"
#import <Masonry/Masonry.h>
#import "ImageBean.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface JHImageView()
@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) float height;
@property (nonatomic) float width;

@property (nonatomic) NSMutableArray *thumbImageArray;
@property (nonatomic) NSMutableArray *originImageArray;

@property (nonatomic) int cell_count;
@end

@implementation JHImageView

-(instancetype)init{
    self = [super init];
    _max_cell_count_col = 3;
    _max_width = 270;
    _max_height = 270;
    self.frame = CGRectMake(0, 0, _max_width, _max_height);
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    _max_cell_count_col = 3;
    _max_height = frame.size.height;
    _max_width = frame.size.width;
    return self;
}

-(instancetype)initWithThumbImgs:(NSMutableArray *)thumbImgs andOriginImgs:(NSMutableArray *)originImgs{
    self = [self init];
    
    [self setupWithThumbImgs:thumbImgs andOriginImgs:originImgs];
    return self;
}

- (void)setup{
    [self initData];
    [self initUI];
}

- (void)setupWithThumbImageURL:(NSString *)thumbImgURL andOriginImage:(NSString *)originImageURL{
    
}

- (void)setupWithThumbImgs:(NSMutableArray *)thumbImgs andOriginImgs:(NSMutableArray *)originImgs{
   
    if (thumbImgs.count!=originImgs.count) {
        return;
    }
    
    _thumbImageArray = thumbImgs;
    _originImageArray = originImgs;
    
    [self setup];
}



- (void)initUI{
    WS(ws);
    
    //创建一个layout布局类
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置布局方向为垂直流布局
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    float height = ceil((float)_cell_count/(float)_max_cell_count_col) * [self getItemSize].height;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, _max_width, height);
//    创建collectionView 通过一个布局策略layout来创建
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _max_width, height) collectionViewLayout:flowLayout];
    _collectionView.collectionViewLayout = flowLayout;

    //代理设置
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    
    //注册item类型 这里使用系统的类型
    [_collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    _collectionView.backgroundColor = [UIColor greenColor];
    [self addSubview:_collectionView];
    
    _collectionView.scrollEnabled = NO;
}

- (void)initData{
    _cell_count = (int)_thumbImageArray.count;
}

- (CGSize)getItemSize{
    CGSize size;
    switch (_cell_count) {
        case 1:
            size = CGSizeMake(_max_width, _max_height);
            break;
        case 2:
            size = CGSizeMake(_max_width/2 - 2, _max_height/2 - 2);
            break;
        default:
            size = CGSizeMake(_max_width/3 - 2, _max_height/3 - 2);
            break;
    }
    return size;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellis" forIndexPath:indexPath];

    cell.bean = [[ImageBean alloc] initWithThumbImg:[_thumbImageArray objectAtIndex:indexPath.row] andOriginImg:[_originImageArray objectAtIndex:indexPath.row]];
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _cell_count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self getItemSize];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

@end
