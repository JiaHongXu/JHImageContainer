//
//  ViewController.m
//  JHImageContainer
//
//  Created by 307A on 16/5/24.
//  Copyright (c) 2016 Jiahong Xu. All rights reserved.
//


#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "JHImageContainer/JHImageView/JHImageView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface ViewController ()
@property (nonatomic) NSMutableArray *imageURLs;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageURLs = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i<5; i++) {
        [_imageURLs addObject:@"http://upload2007.cnool.net/files2011/20140601/20140601202928593.jpg"];
    }
    
    WS(ws);
//    JHImageView *imageView = [[JHImageView alloc] initWithThumbImgs:_imageURLs andOriginImgs:_imageURLs];
    JHImageView *imageView = [[JHImageView alloc] initWithFrame:CGRectMake(0, 64, 300, 300)];
    
    [self.view addSubview:imageView];
   
    imageView.backgroundColor = [UIColor blueColor];
    
//    
    [imageView setupWithThumbImgs:_imageURLs andOriginImgs:_imageURLs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end