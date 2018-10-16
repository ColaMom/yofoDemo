//
//  RHFPopOptionView.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/9/9.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "RHFPopOptionView.h"

static CGFloat const cellHeight = 44;
@interface RHFPopOptionView () <UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIButton* maskView;
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSMutableArray* dataSource;
@property (strong, nonatomic) UIImageView* handleView; //气泡句柄

@property (assign, nonatomic) RHFPopOptionStyle style;

@end

@implementation RHFPopOptionView

- (instancetype)initWithFrame:(CGRect)frame Style:(RHFPopOptionStyle)style itemNum:(NSInteger)itemNum
{
    self = [super initWithFrame:KKeyWindow.bounds];
    if (self) {
        self.style = style;
        
        ///遮罩
        _maskView = [UIButton buttonWithType:UIButtonTypeCustom];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _maskView.frame = self.bounds;
        [_maskView addTarget:self action:@selector(hidePopView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_maskView];

        ///三角句柄
        _handleView = [[UIImageView alloc]initWithFrame:CGRM(frame.origin.x-10, frame.origin.y, 21, 10)];
        _handleView.image = [UIImage imageNamed:@"handle"];
        [self addSubview:_handleView];

        ///列表
        if (style == RHFPopOptionStyleLarge) {
            _tableView = [[UITableView alloc]initWithFrame:CGRM(0, frame.origin.y+10, frame.size.width, itemNum*cellHeight)];
        }
        else if (style == RHFPopOptionStyleNoIcon){
            CGFloat width = frame.size.width;
            _tableView = [[UITableView alloc]initWithFrame:CGRM(self.width-5-width, frame.origin.y+10, width, itemNum*cellHeight)];
            _tableView.layer.cornerRadius = 5;
            _tableView.layer.masksToBounds = YES;
        }
        else{
            CGFloat width = frame.size.width;
            _tableView = [[UITableView alloc]initWithFrame:CGRM(self.width-5-width, frame.origin.y+10, width, itemNum*cellHeight)];
            _tableView.layer.cornerRadius = 5;
            _tableView.layer.masksToBounds = YES;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self addSubview:_tableView];
    }
    return self;
}


- (void)addOption:(NSString *)title image:(UIImage *)image style:(RHFPopOptionCellStyle)style{
    NSMutableDictionary *optionDic = [NSMutableDictionary dictionary];
    [optionDic setValue:title forKey:@"title"];
    [optionDic setValue:@(style) forKey:@"style"];
    
    if (self.style != RHFPopOptionStyleNoIcon) {
        [optionDic setValue:image forKey:@"image"];
    }

    [self.dataSource addObject:optionDic];
    self.tableView.height =  cellHeight * self.dataSource.count;
    [self.tableView reloadData];
}

- (void)show{
    _maskView.alpha = 0;
    _tableView.alpha = 0;
    _handleView.alpha = 0;

//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation.fromValue = [NSNumber numberWithFloat:0.8];
//    animation.toValue = [NSNumber numberWithFloat:1];
//    [_tableView.layer addAnimation:animation forKey:@"transform.scale"];
    
    [KKeyWindow addSubview:self];
    [UIView animateWithDuration:KAnimationDuration animations:^{
        _maskView.alpha = 1;
        _tableView.alpha = 1;
        _handleView.alpha = 1;
    }];
}

- (void)hidePopView{
    [UIView animateWithDuration:KAnimationDuration animations:^{
        _maskView.alpha = 0;
        _tableView.alpha = 0;
        _handleView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma  mark — <UITableViewDelegate>
//每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

//每行的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseID=@"reuse id";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell ) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *optionDic = self.dataSource[indexPath.row];
    if (self.style != RHFPopOptionStyleNoIcon) {
        cell.imageView.image = optionDic[@"image"];
    }
    cell.textLabel.text = optionDic[@"title"];
    
    if ([optionDic[@"style"] intValue] == RHFPopOptionCellStyleDefault) {
        cell.textLabel.textColor = KDarkColor;
    }
    else{
        cell.textLabel.textColor = [@"EB4C44" rgbColor];
    }
    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(RHFPopOptionViewDidSelectedOptionAtIndexPath:)]) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:_atRow];
        [self.delegate RHFPopOptionViewDidSelectedOptionAtIndexPath:index];
    }

    [self removeFromSuperview];
}


- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
