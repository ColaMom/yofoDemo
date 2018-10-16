//
//  RHFProductModel.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/11/2.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "RHFProductModel.h"

@implementation RHFProductModel

- (NSInteger)component_danger_total_num{
    _component_danger_total_num = self.component_danger_grade0_num+self.component_danger_grade1_num+self.component_danger_grade2_num+self.component_danger_grade3_num;
    return _component_danger_total_num;
}

+(NSDictionary *)mj_objectClassInArray{
    return @{@"scoreList":@"RHFProductScoreModel",
             @"purposeList":@"RHFProductElementCompomentModel"
             };
}

@end


@implementation RHFProductElementCompomentModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list" : @"RHFProductElementCompomentListModel"};
}
@end

@implementation RHFProductElementCompomentListModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"list":@"RHFProductElementItemModel"};
}

@end

