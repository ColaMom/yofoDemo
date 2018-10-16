//
//  BaseCell.h
//  BBDTek
//
//  Created by  ZhuHong on 16/7/12.
//  Copyright © 2016年 BBDTek. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseCell : UITableViewCell

//@property (nonatomic, weak, readonly) UIView* lineView;
//@property (nonatomic, assign) BOOL hiddenLineView;
//@property (nonatomic, assign) UIEdgeInsets lineInsets;


/** 快速获取 cell */
+ (instancetype)cell:(UITableView*)tableView;

/** 快速获取 XIB cell */
+ (instancetype)xibCell:(UITableView*)tableView;

/** 返回一个空白的 cell */
+ (id)blankCell:(UITableView*)tableView;


@end
