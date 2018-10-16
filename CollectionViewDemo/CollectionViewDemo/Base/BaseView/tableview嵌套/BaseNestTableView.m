//
//  BaseNestTableView.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/6/20.
//  Copyright © 2018 ShaoShanPeng. All rights reserved.
//

#import "BaseNestTableView.h"

@implementation BaseNestTableView

/**
 同时识别多个手势
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
