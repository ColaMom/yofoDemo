//
//  BaseCollectionController.m
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/3/3.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "BaseCollectionController.h"

@interface BaseCollectionController ()
@property (nonatomic, weak) UICollectionView* collectionView;

@end

@implementation BaseCollectionController


- (void)viewDidLoad {
    [super viewDidLoad];
    //navigationBar.translucent = YES时, 设置View的上边距;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // 添加UICollectionView
    [self setupCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UICollectionViewDelegate,UICollectionViewDataSource
- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = KBGColor;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
//    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.view);
//        make.top.equalTo(self.view).offset(KNavigationBarHeight);
//    }];
    collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
}


#pragma mark — CollectionViewDelegate
//返回每组中块的个数
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

//每行的块的样式
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    return cell;
    
}


@end
