//
//  BaseNestTableViewController.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/6/19.
//  Copyright © 2018 ShaoShanPeng. All rights reserved.
//

#import "BaseNestTableViewController.h"


@interface BaseNestTableViewController ()

@end

@implementation BaseNestTableViewController


- (instancetype)init{
    self = [super init];
    if (self) {
        self.tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

#pragma mark -viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    //配置tableView
    [self setUpTableView];
}

//配置tableView
- (void)setUpTableView{
    self.tableView = [[BaseNestTableView alloc]initWithFrame:self.view.bounds style:self.tableViewStyle];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark -UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}


#pragma mark UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        if (!self.vcCanScroll) {
            scrollView.contentOffset = CGPointZero;
        }
        if (scrollView.contentOffset.y <= 0) {
            self.vcCanScroll = NO;
            scrollView.contentOffset = CGPointZero;
            [[NSNotificationCenter defaultCenter] postNotificationName:KNestTableViewScrollStateChangeNotification object:nil userInfo:nil];//到顶通知父视图改变状态
        }
        self.tableView.showsVerticalScrollIndicator = _vcCanScroll?YES:NO;
    }
}

@end
