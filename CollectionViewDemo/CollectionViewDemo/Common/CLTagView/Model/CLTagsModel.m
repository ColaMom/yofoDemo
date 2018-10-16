//
//  CLTagsModel.m
//  CLTageViewDemo
//
//  Created by Criss on 2017/4/26.
//  Copyright © 2017年 Criss. All rights reserved.
//

#import "CLTagsModel.h"
#import "CLTagButton.h"
#import "CLStyleConfig.h"

@implementation CLTagsModel

//- (void)setTagsArray:(NSArray<NSString *> *)tagsArray {
//    _tagsArray = tagsArray;
//    NSMutableArray<CLTagButton *> *tagBtnArrayM = [NSMutableArray array];
//    for (int i = 0; i < _tagsArray.count; i ++) {
//        //创建tag按钮
//        CLTagButton *preTagBtn;
//        CLTagButton *currentTagBtn;
//        preTagBtn = i ? tagBtnArrayM[i - 1] : nil;
//        currentTagBtn = [CLTagButton initWithTagDesc:_tagsArray[i]];
//        //该tag按钮的内容
//        CLTagModel *currentTagModel = [[CLTagModel alloc]init];
//        currentTagModel.tagText = tagsArray[i];
//        currentTagModel.tagIndexPath = [NSIndexPath indexPathForRow:i inSection:self.section];
//        currentTagBtn.tagModel = currentTagModel;
//        [tagBtnArrayM addObject: (CLTagButton *)[self reloadTagViewPreTag:preTagBtn currentTagBtn:currentTagBtn]];
//    }
//    _tagBtnArray = tagBtnArrayM.copy;
//
//    NSMutableArray<CLTagModel *>*tagModelsArrayM = [NSMutableArray array];
//    for (int i = 0; i<_tagsArray.count; i++) {
//        CLTagModel *tagModel = [[CLTagModel alloc]init];
//        tagModel.tagText = tagsArray[i];
//        [tagModelsArrayM addObject:tagModel];
//    }
//    _tagModelsArray = tagModelsArrayM.mutableCopy;
//}

- (void)setTagModelsArray:(NSMutableArray *)tagModelsArray{
    _tagModelsArray = tagModelsArray;
    NSMutableArray<CLTagButton *> *tagBtnArrayM = [NSMutableArray array];
    for (int i = 0; i < tagModelsArray.count; i ++) {
        CLTagModel *tagModel = tagModelsArray[i];
        //创建tag按钮
        CLTagButton *preTagBtn;
        CLTagButton *currentTagBtn;
        preTagBtn = i ? tagBtnArrayM[i - 1] : nil;
        currentTagBtn = [CLTagButton initWithTagDesc:tagModel.key];
        //该tag按钮的内容
        CLTagModel *currentTagModel = [[CLTagModel alloc]init];
        currentTagModel.key = tagModel.key;
        currentTagModel.tagIndexPath = [NSIndexPath indexPathForRow:i inSection:self.section];
        currentTagBtn.tagModel = currentTagModel;
        [tagBtnArrayM addObject: (CLTagButton *)[self reloadTagViewPreTag:preTagBtn currentTagBtn:currentTagBtn]];
    }
    _tagBtnArray = tagBtnArrayM.copy;

}


- (UIView *)reloadTagViewPreTag:(UIView *)preTagBtn currentTagBtn:(UIView *)currentTagBtn {
    
    CGFloat preTaling = preTagBtn? CGRectGetMaxX(preTagBtn.frame) : 0;
    CGFloat preBottom = preTagBtn? CGRectGetMaxY(preTagBtn.frame) : 0;
    CGFloat preY = preTagBtn? preTagBtn.frame.origin.y : kCLDistance;
    
    if (preTaling + kCLTagViewHorizontaGap * 2 + currentTagBtn.bounds.size.width > [UIScreen mainScreen].bounds.size.width) {
        currentTagBtn.frame = CGRectMake(kCLTagViewHorizontaGap, preBottom + kCLTextFieldsVerticalGap, currentTagBtn.frame.size.width, currentTagBtn.frame.size.height);
    }else {
        currentTagBtn.frame = CGRectMake(preTaling + kCLTextFieldsHorizontalGap, preY, currentTagBtn.frame.size.width, currentTagBtn.frame.size.height);
    }
    return currentTagBtn;
}

@end
