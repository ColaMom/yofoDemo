//
//  BaseTabBar.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/2/8.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "BaseTabBar.h"

@interface BaseTabBar ()

@property (strong, nonatomic)UIButton* centerBtn;

@end

@implementation BaseTabBar

- (UIButton *)centerBtn{
    if (!_centerBtn) {
        _centerBtn = [[UIButton alloc]initWithFrame:CGRM(0, 0, 64, 64)];
        [_centerBtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        _centerBtn.adjustsImageWhenHighlighted = NO;
        [_centerBtn addTarget:self action:@selector(clickCenterBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _centerBtn;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.centerBtn];
        
   
        //去掉黑线
        self.barStyle = UIBarStyleBlack;
        //颜色
        self.translucent = NO;
        self.barTintColor = [UIColor whiteColor];
        //阴影
        self.layer.shadowColor = KShadowColor.CGColor;
        self.layer.shadowOffset = CGSizeMake(0, -2);
        self.layer.shadowOpacity = 0.3;
        
        // 通过appearance统一设置所有UITabBarItem的文字属性
        // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
        attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        
        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
        selectedAttrs[NSForegroundColorAttributeName] = KThemeColor;

        
        UITabBarItem *item = [UITabBarItem appearance];
        item.titlePositionAdjustment = UIOffsetMake(0, -1);
        [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 把 tabBarButton 取出来
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    CGFloat barWidth = self.bounds.size.width;
//    CGFloat barHeight = self.bounds.size.height;
    CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);
//    CGFloat centerBtnHeight = CGRectGetHeight(self.centerBtn.frame);
    self.centerBtn.center = CGPointMake(barWidth/2, 49/2.0-10);
    CGFloat buttonItemWidth = (barWidth - centerBtnWidth)/tabBarButtonArray.count;
    // 逐个布局 tabBarItem，修改 UITabBarButton 的 frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {

        CGRect frame = view.frame;
        if (idx >= tabBarButtonArray.count / 2) {
            // 重新设置 x 坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx * buttonItemWidth + self.centerBtn.width;
        } else {
            frame.origin.x = idx * buttonItemWidth;
        }
        // 重新设置宽度
        frame.size.width = buttonItemWidth;
        view.frame = frame;
    }];

    [self bringSubviewToFront:self.centerBtn];

}


- (void)clickCenterBtnAction:(UIButton *)sender{
    if (self.myDelegate && [self.myDelegate respondsToSelector:@selector(BaseTabBarDidSelectedCenterItem:)]) {
        [self.myDelegate BaseTabBarDidSelectedCenterItem:sender];
    }
}

// 重写以下方法，解决超出部分不响应发布按钮的事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        if (!self.hidden) {
            // 转换坐标系
            CGPoint newPoint = [self.centerBtn convertPoint:point fromView:self];
            // 判断触摸点是否在button上
            if (CGRectContainsPoint(self.centerBtn.bounds, newPoint)) {
                view = self.centerBtn;
            }
        }
    }
    return view;
}

@end
