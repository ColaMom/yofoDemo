//
//  BaseModel.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/7/29.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface BaseModel : NSObject <NSCoding>

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
