//
//  BaseHeaderFooterView.m
//  S-FOC
//
//  Created by XXL on 2016/11/20.
//  Copyright © 2016年 AngZhang. All rights reserved.
//

#import "BaseHeaderFooterView.h"

@implementation BaseHeaderFooterView

/** 快速获取cell */
+ (instancetype)headerFooterView:(UITableView*)tableView {
    NSString* ID = NSStringFromClass(self);
    BaseHeaderFooterView* view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (!view) {
        [tableView registerClass:self forHeaderFooterViewReuseIdentifier:ID];
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    }
    
    return view;
}

+ (instancetype)xibHeaderFooterView:(UITableView*)tableView {
    NSString* ID = NSStringFromClass(self);
    BaseHeaderFooterView* view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (!view) {
        [tableView registerNib:[UINib nibWithNibName:ID bundle:nil] forHeaderFooterViewReuseIdentifier:ID];
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    }
    
    return view;
}

+ (UITableViewHeaderFooterView *)blankView:(UITableView*)tableView {
    NSString* ID = @"UITableViewHeaderFooterView";
    UITableViewHeaderFooterView* view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (!view) {
        [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:ID];
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    }
    
    return view;
}

@end
