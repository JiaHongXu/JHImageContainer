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

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface JHImageView()
@property (nonatomic) UICollectionView *collectionView;

@property (nonatomic) NSInteger height;
@property (nonatomic) NSInteger width;

@property (nonatomic) NSMutableArray *thumbImageArray;
@property (nonatomic) NSMutableArray *originImageArray;

@property (nonatomic) int cell_count;
@end

@implementation JHImageView

-(id)init{
    self = [super init];
    _max_width = 270;
    _max_height = 270;
    
    return self;
}

- (void)setup{
    [self initUI];
    [self initData];
}

- (void)setupWithThumbImageURL:(NSString *)thumbImgURL andOriginImage:(NSString *)originImageURL{
    
}

- (void)setupWithThumbImgs:(NSMutableArray *)thumbImgs andOriginImgs:(NSMutableArray *)originImgs{
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
    
    //设置每个item的大小
    flowLayout.itemSize = [self getItemSize];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 5, 5);
    
//    创建collectionView 通过一个布局策略layout来创建
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, 300, 300) collectionViewLayout:flowLayout];
    _collectionView.collectionViewLayout = flowLayout;

    //代理设置
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    
    //注册item类型 这里使用系统的类型
    [_collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    _collectionView.backgroundColor = [UIColor clearColor];
    [self addSubview:_collectionView];
    
    //    设置布局约束
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    
    CGRect rect = _collectionView.frame;
}

- (void)initData{
    
}

- (CGSize)getItemSize{
    CGSize size;
    switch (_cell_count) {
        case 1:
            size = CGSizeMake(_max_height, _max_width);
//            size = CGSizeMake(_MAX_WIDTH_HEIGHT, _MAX_WIDTH_HEIGHT);
            break;
        default:
            size = CGSizeMake(_max_height/3 - 5, _max_width/3 -5);
//            size = CGSizeMake(_MAX_WIDTH_HEIGHT/3 - 5, _MAX_WIDTH_HEIGHT/3 -5);
            break;
    }
    return size;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];

    [cell setupWithThumbImg:[_thumbImageArray objectAtIndex:indexPath.row] andOriginImg:[_originImageArray objectAtIndex:indexPath.row]];
    
    return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _thumbImageArray.count;
}
@end
