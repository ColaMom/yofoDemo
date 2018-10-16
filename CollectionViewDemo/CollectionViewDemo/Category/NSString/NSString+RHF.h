//
//  NSString+RHF.h
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/9/20.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Verify.h"

@interface NSString (RHF)
/**
 *计算文字高度
 */
- (CGFloat)boundingRectWithWidth:(CGFloat)width fontSize:(NSInteger)font;
/**
 *计算文字宽度
 */
- (CGFloat)boundingRectWithHeight:(CGFloat)height fontSize:(NSInteger)font;

/**
 *转换Unicode到utf8
 */
- (NSString *)transformUnicodeToUTF8:(NSString *)unicodeStr;


/**
 将数组或字典转换为json字符串
 */
+ (NSString *)objectToJsonString:(id)object;

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr;


/**
 获取富文本,将某些字符高亮

 @param highlightText 要高亮的字符
 */
- (NSAttributedString *)getAttributeTextWithHighlightString:(NSString *)highlightText highlightColor:(UIColor*)color;


/**
 替换字符串中的br,b,empty 标签

 */
- (NSMutableAttributedString *)getAttributeTextRepleaceHtmlSymbol;

@end
