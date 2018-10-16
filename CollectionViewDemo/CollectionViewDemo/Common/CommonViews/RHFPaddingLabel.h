//
//  RHFPaddingLabel.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/10/23.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHFPaddingLabel : UILabel
// 用来决定上下左右内边距，也可以提供一个借口供外部修改，在这里就先固定写死
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

@end
