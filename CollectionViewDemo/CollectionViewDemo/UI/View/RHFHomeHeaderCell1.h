//
//  RHFHomeHeaderCell1.h
//  RHFAppDemo
//
//  Created by 李晓雪 on 2018/4/19.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import "BaseCell.h"
#import "RHFHomeModulesModel.h"
@protocol RHFHomeHeaderCell1Delegate <NSObject>
- (void)goToModule:(RHFHomeModulesModel*)modulesModel;
@end

@interface RHFHomeHeaderCell1 : BaseCell
@property (weak, nonatomic) id<RHFHomeHeaderCell1Delegate> delegate;
@property (strong, nonatomic)NSMutableArray<RHFHomeModulesModel*>* modulesList;

@end
