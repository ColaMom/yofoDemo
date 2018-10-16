//
//  RHFArticleListModel.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/10/9.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "RHFArticleModel.h"

@implementation RHFArticleModel

- (RHFArticleMode)displayModeEnum{
    if ([self.displayMode isEqualToString:@"multi"]) {
        _displayModeEnum = RHFArticleModeMulti;
    }else if ([self.displayMode isEqualToString:@"large"]){
        _displayModeEnum = RHFArticleModeLarge;
    }else{
        _displayModeEnum = RHFArticleModeSmall;
    }
    return _displayModeEnum;
}


+ (NSDictionary *)mj_objectClassInArray{
    return @{@"content":@"RHFArticleContentUnitModel"};
}


- (void)setTitle:(NSString *)title{
    _title = [title stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    self.titleHeight = [_title boundingRectWithWidth:_collectionWidth fontSize:15];
}

- (CGFloat)descripHeight{
    _descripHeight = [self.descript boundingRectWithWidth:_collectionWidth fontSize:15];
    return _descripHeight;
}

- (CGFloat)coverImageHeight{
    if (self.image_width.floatValue == 0) {
        _coverImageWidth = 100;
    }
    else{
        _coverImageWidth = self.image_width.floatValue;
    }
    
    if (self.image_height.floatValue == 0) {
        _coverImageHeight = 100;
    }
    else{
        _coverImageHeight = self.image_height.floatValue;
    }
    
    _coverImageHeight = (self.collectionWidth)*(_coverImageHeight)/(_coverImageWidth);
    
    if (_coverImageHeight > 300) {
        _coverImageHeight = 300;
    }
    return _coverImageHeight;
}

@end


