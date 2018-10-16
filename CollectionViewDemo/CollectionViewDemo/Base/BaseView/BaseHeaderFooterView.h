//
//  BaseHeaderFooterView.h
//  S-FOC
//
//  Created by XXL on 2016/11/20.
//  Copyright © 2016年 AngZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseHeaderFooterView : UITableViewHeaderFooterView

/** 快速获取HeaderFooterView */
+ (instancetype)headerFooterView:(UITableView*)tableView;
+ (instancetype)xibHeaderFooterView:(UITableView*)tableView;
+ (UITableViewHeaderFooterView *)blankView:(UITableView*)tableView;

@end
