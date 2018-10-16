//
//  RHFUserModel.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/9/25.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//


@implementation RHFUserModel

+(instancetype)currentUser{
    static RHFUserModel *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[RHFUserModel alloc]init];
    });
    return user;
}


- (void)logOut{
    // 退出时
    
    NSMutableArray *allProperty = [self getAllProperty];
    
    ///赋值给实体类的属性
    for (int i = 0; i < allProperty.count; i ++) {
        
        ///2.1 通过getSetterSelWithAttibuteName 方法来获取实体类的set方法
        SEL setSel = [self creatSetterWithPropertyName:allProperty[i]];
        
        if ([self respondsToSelector:setSel]) {
            
            ///2.2 把值通过setter方法赋值给实体类的属性
            [self performSelectorOnMainThread:setSel
                                   withObject:nil
                                waitUntilDone:[NSThread isMainThread]];
        }
    }    
    
}


//遍历获取所有属性Property
- (NSMutableArray *) getAllProperty {
    NSMutableArray *allProperty = [NSMutableArray array];
    
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([RHFUserModel class], &propertyCount);
    for (unsigned int i = 0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = &propertyList[i];
        //通过property_getName函数获得属性的名字
        NSString * propertyName = [NSString stringWithCString:property_getName(*thisProperty) encoding:NSUTF8StringEncoding];
        [allProperty addObject:propertyName];
    }
    free(propertyList);
    
    return allProperty;
}


- (BOOL)gender{
    if ([self.sex isEqualToString:@"男"]) {
        _gender = YES;
    }else{
        _gender = NO;
    }
    return _gender;
}

- (NSString *)genderIcon{
    if ([self.sex isEqualToString:@"男"]) {
        _genderIcon = @"nan";
    }else{
        _genderIcon = @"nv";
    }
    return _genderIcon;
}

- (BOOL)status{
    if (IsEmptyValue(self.userId)) {
        return NO;
    }else{
        return YES;
    }
}

- (RHFUserAttentionStatus)attentionStatus{
    if (self.isMutual) {
        _attentionStatus = RHFUserAttentionStatusBouthAttention;
    }else{
        if (self.isAttention) {
            _attentionStatus =  RHFUserAttentionStatusAttentioned;
        }else{
            _attentionStatus =  RHFUserAttentionStatusNotAttention;
        }
    }
    return _attentionStatus;
}

#pragma mark -- 利用runtime 给userModel重新赋值


/**
 更新用户信息

 @param data 用户信息Dictionary
 */
- (void)updateUserInfoWithDictionary: (NSDictionary *) data{
    
    if (data == nil) {
        return;
    }
    
    ///1.获取字典的key
    NSArray *dicKey = [data allKeys];
    
    ///2.循环遍历字典key, 并且动态生成实体类的setter方法，把字典的Value通过setter方法
    ///赋值给实体类的属性
    for (int i = 0; i < dicKey.count; i ++) {
        
        ///2.1 通过getSetterSelWithAttibuteName 方法来获取实体类的set方法
        SEL setSel = [self creatSetterWithPropertyName:dicKey[i]];
        
        if ([self respondsToSelector:setSel]) {
            ///2.2 获取字典中key对应的value
            NSString  *value = [NSString stringWithFormat:@"%@", data[dicKey[i]]];
            
            ///2.3 把值通过setter方法赋值给实体类的属性
            [self performSelectorOnMainThread:setSel
                                   withObject:value
                                waitUntilDone:[NSThread isMainThread]];
        }
    }
    
}


/**
  通过字符串来创建该字符串的setter方法
 */
- (SEL) creatSetterWithPropertyName: (NSString *) propertyName{
    
    //1.首字母大写
    NSString *capitalWord = [propertyName substringToIndex:1];
    capitalWord = capitalWord.uppercaseString;
    propertyName = RRStr(@"%@%@",capitalWord,[propertyName substringFromIndex:1]);
    
    //2.拼接上set关键字
    propertyName = [NSString stringWithFormat:@"set%@:", propertyName];
    
    //3.返回set方法
    return NSSelectorFromString(propertyName);
}



/**
 *通过字符串来创建该字符串的getter方法，并返回
 */
- (SEL) creatGetterWithPropertyName: (NSString *) propertyName{
    //返回get方法: oc中的get方法就是属性的本身
    return NSSelectorFromString(propertyName);
}


- (BOOL)checkExpiredDateIsAvalible{
    NSInteger timeInterval = [self.expiredTimeInterval integerValue];
    NSInteger currentTimeInterval = [[NSDate currentTimeStamp] integerValue];
    return currentTimeInterval<timeInterval;
}

@end
