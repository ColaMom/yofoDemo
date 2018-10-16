//
//  NSString+RHF.m
//  RHFAppDemo
//
//  Created by ShaoShanPeng on 2017/9/20.
//  Copyright © 2017年 ShaoShanPeng. All rights reserved.
//

#import "NSString+RHF.h"

@implementation NSString (RHF)
- (CGFloat)boundingRectWithWidth:(CGFloat)width fontSize:(NSInteger)font{
    return  [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:font]} context:nil].size.height;
}


- (CGFloat)boundingRectWithHeight:(CGFloat)height fontSize:(NSInteger)font{
    return  [self boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:font]} context:nil].size.width;
}

- (NSString *)transformUnicodeToUTF8:(NSString *)unicodeStr
{

    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    NSLog(@"%@",returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}


+ (NSString *)objectToJsonString:(id)object{

    NSError *error = nil;
    NSData *policyData = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
    if(!policyData && error){
        NSLog(@"Error creating JSON: %@", [error localizedDescription]);
        return @"";
    }

    //NSJSONSerialization converts a URL string from http://... to http:\/\/... remove the extra escapes
    NSString *policyStr = [[NSString alloc] initWithData:policyData encoding:NSUTF8StringEncoding];
//    policyStr = [policyStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];

//    NSMutableString *responseString = [NSMutableString stringWithString:policyStr];
//        NSString *character = nil;
//        for (int i = 0; i < responseString.length; i ++) {
//            character = [responseString substringWithRange:NSMakeRange(i, 1)];
//            if ([character isEqualToString:@"\\"])
//                [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
//            DLog(@"");
//            }

    return policyStr;
}

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
- (NSMutableDictionary *)getURLParameters:(NSString *)urlStr {
    
    // 查找参数
    NSRange range = [urlStr rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }
    
    // 以字典形式将参数返回
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    // 截取参数
    NSString *parametersString = [urlStr substringFromIndex:range.location + 1];
    
    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {
        
        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        
        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            
            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }
            
            id existValue = [params valueForKey:key];
            
            if (existValue != nil) {
                
                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    
                    [params setValue:items forKey:key];
                } else {
                    
                    // 非数组
                    [params setValue:@[existValue, value] forKey:key];
                }
                
            } else {
                
                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数
        
        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        
        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }
        
        // 分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        
        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }
        
        // 设置值
        [params setValue:value forKey:key];
    }
    
    return params;
}


- (NSAttributedString *)getAttributeTextWithHighlightString:(NSString *)highlightText highlightColor:(UIColor *)color{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:self];
    
    for (int i=0; i<highlightText.length; i++) {
        NSString *word = [highlightText substringWithRange:NSMakeRange(i, 1)];
        for (int j=0; j<self.length; j++) {
            NSString *selfWord = [self substringWithRange:NSMakeRange(j, 1)];
            if ([selfWord isEqualToString:word]) {
                [attStr setAttributes:@{NSForegroundColorAttributeName : color} range:NSMakeRange(j, 1)];
            }
        }
    }
    return attStr;
}


- (NSMutableAttributedString *)getAttributeTextRepleaceHtmlSymbol{
    NSString *skinDescriptionString = self;
    skinDescriptionString =  [skinDescriptionString stringByReplacingOccurrencesOfString:@"[br]" withString:@"\n"];
    skinDescriptionString =  [skinDescriptionString stringByReplacingOccurrencesOfString:@"[empty]" withString:@""];
    
    NSMutableArray *rangeList = [NSMutableArray array];
    
    NSArray *arr = [skinDescriptionString componentsSeparatedByString:@"[/b]"];
    for (int i=0; i<arr.count-1; i++) {
        NSRange rangeStart =  [skinDescriptionString rangeOfString:@"[b]"];
        NSRange rangeEnd =  [skinDescriptionString rangeOfString:@"[/b]"];
        NSRange rangeBold= NSMakeRange(rangeStart.location,rangeEnd.location-rangeStart.location-rangeStart.length );
        
        [rangeList addObject:@{@"loc":@(rangeBold.location),@"len":@(rangeBold.length)}];
        
        skinDescriptionString = [skinDescriptionString stringByReplacingCharactersInRange:rangeStart withString:@""];
        rangeEnd =  [skinDescriptionString rangeOfString:@"[/b]"];
        skinDescriptionString = [skinDescriptionString stringByReplacingCharactersInRange:rangeEnd withString:@""];
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:skinDescriptionString];
    for (int i=0; i<rangeList.count; i++) {
        NSDictionary *rangeDic = [rangeList objectAtIndex:i];
        NSNumber *loc = [rangeDic objectForKey:@"loc"];
        NSNumber *len = [rangeDic objectForKey:@"len"];
        [str setAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14.0]} range: NSMakeRange(loc.integerValue, len.integerValue)];
    }
    
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle  setLineSpacing:3];
    
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, str.length)];
    
    return str;
}

@end
