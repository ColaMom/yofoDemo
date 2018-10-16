//
//  BaseNestTableViewController.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/6/19.
//  Copyright © 2018 ShaoShanPeng. All rights reserved.
//

#import "BaseController.h"
#import "BaseNestTableView.h"

static NSString *const KNestTableViewScrollStateChangeNotification = @"NestTableViewScrollStateChangeNotification";

@interface BaseNestTableViewController : BaseController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL vcCanScroll;

/** 一定要在[super viewDidLoad];之前调用 */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (nonatomic,strong) UITableView *tableView;

@end
