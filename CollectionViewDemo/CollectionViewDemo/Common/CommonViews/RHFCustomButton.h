//
//  RHFCustomButton.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2018/4/24.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonHandler)(UIButton *sender);
typedef enum {
    RHFCustomButtonImageTop = 0,   // 图片上 标题下
    RHFCustomButtonImageLeft,      // 图片左 标题右
    RHFCustomButtonImageBottom,    // 图片下 标题上
    RHFCustomButtonImageRight,     // 图片右 标题左
    RHFCustomButtonNoImage         //
} RHFCustomButtonStyle;

@interface RHFCustomButton : UIButton

@property (nonatomic, assign) RHFCustomButtonStyle buttonStyle;

@end
