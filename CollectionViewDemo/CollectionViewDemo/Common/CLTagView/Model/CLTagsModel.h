//
//  CLTagsModel.h
//  CLTageViewDemo
//
//  Created by Criss on 2017/4/26.
//  Copyright © 2017年 Criss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLTagModel.h"
@class CLTagButton;


/**
 *某一组的tagModel 
 */
@interface CLTagsModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSUInteger section;

///标签文字数组
//@property (strong, nonatomic) NSArray<NSString *> *tagsArray;

//根据标签文字内容生成的每个tagModel
@property (strong, nonatomic) NSMutableArray* tagModelsArray;

///根据标签文字内容生成的标签按钮
@property (strong, nonatomic, readonly) NSArray<CLTagButton *> *tagBtnArray;

@end

