//
//  RHFPopOptionView.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/9/9.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    RHFPopOptionCellStyleDefault,
    RHFPopOptionCellStyleDestructive
} RHFPopOptionCellStyle;

typedef enum : NSUInteger {
    RHFPopOptionStyleLarge,     //屏幕等宽
    RHFPopOptionStyleSmall,     //圆角矩形的小框
    RHFPopOptionStyleNoIcon     //仅显示文字不显示图标
} RHFPopOptionStyle;

@protocol RHFPopOptionViewDelegate <NSObject>

- (void)RHFPopOptionViewDidSelectedOptionAtIndexPath:(NSIndexPath *)indexPath;

@end



@interface RHFPopOptionView : UIView

@property (weak, nonatomic) id<RHFPopOptionViewDelegate> delegate;
/// 对哪一行cell做操作
@property (assign, nonatomic) NSInteger atRow;

- (instancetype)initWithFrame:(CGRect)frame Style:(RHFPopOptionStyle)style itemNum:(NSInteger)itemNum;

- (void)addOption:(NSString *)title image:(UIImage *)image style:(RHFPopOptionCellStyle)style;

- (void)show;

@end
