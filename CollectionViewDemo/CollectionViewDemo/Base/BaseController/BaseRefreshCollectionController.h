//
//  BaseRefreshCollectionController.h
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/3/3.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "BaseCollectionController.h"


typedef void(^refreshComplete)();

@interface BaseRefreshCollectionController : BaseCollectionController
/** 当前页码 */
@property (assign, nonatomic) int currentPage;
///分页大小
@property (assign, nonatomic) int pageSize;
///首次加载
@property (assign, nonatomic) BOOL firstLoad;
/// 区分刷新和加载
@property (assign, nonatomic) BOOL isFooterRefresh;



@property (copy, nonatomic) refreshComplete refreshCompleteHandler;
/**
 *刷新加载,页码和最后一页已经处理, 只需要自己重写无数据下相应的占位图
 */
- (void)refreshCompleteHandlerWhenRequestListEnd:(NSMutableArray *)dataList HeaderHandler:(refreshComplete)headerRefreshHandler footerHandler:(refreshComplete)footerRefreshHandler;

- (void)endRefresh;

@end
