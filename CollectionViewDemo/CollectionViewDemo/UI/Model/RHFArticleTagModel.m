//
//  RHFArticleTagModel.m
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/3/16.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "RHFArticleTagModel.h"

@implementation RHFArticleTagModel

- (void)setVal:(NSString *)val{
    _val = val;
    CGFloat width = [val boundingRectWithHeight:30 fontSize:12];
    self.textWidth = width;
}

@end
