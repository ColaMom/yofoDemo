//
//  BaseRefreshCollectionController.m
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/3/3.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "BaseRefreshCollectionController.h"

@interface BaseRefreshCollectionController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation BaseRefreshCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentPage = 0;
    self.pageSize = 20;
    
    [self setupRefreshView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *刷新加载控件
 */
- (void)setupRefreshView{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.currentPage = 0;
        self.isFooterRefresh = NO;
        if (self.refreshCompleteHandler) {
            self.refreshCompleteHandler();
        }
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.collectionView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.isFooterRefresh = YES;
        
        if (self.refreshCompleteHandler) {
            self.refreshCompleteHandler();
        }
    }];
    footer.automaticallyHidden = YES;
    footer.stateLabel.hidden = YES;
    self.collectionView.mj_footer = footer;
}


- (void)endRefresh{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}


- (void)refreshCompleteHandlerWhenRequestListEnd:(NSMutableArray *)dataList HeaderHandler:(refreshComplete)headerRefreshHandler footerHandler:(refreshComplete)footerRefreshHandler{
    if (!_isFooterRefresh) {
        headerRefreshHandler();
    }else{
        footerRefreshHandler();
    }
    
    
    [self.collectionView reloadData];
    
    
    if (dataList.count<=0) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        //        if (self.pageSize == 1) {
        //
        //        }
    }else{
        self.currentPage++;
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
    }
}
@end
