//
//  CLTagModel.h
//  tagView
//
//  Created by ShaoShanPeng on 2018/4/12.
//  Copyright © 2018年 ShaoShanPeng. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *某组内某个tagModel 
 */
@interface CLTagModel : NSObject
//英文关键字
@property (copy, nonatomic) NSString* key;
//中文名词
@property (copy, nonatomic) NSString* val;

///自定义属性,在护肤笔记筛选时,用来标识该标签是否已选
@property (assign, nonatomic) BOOL isSelected;

@property (strong, nonatomic)NSIndexPath* tagIndexPath;


@end
