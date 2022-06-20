//
//  NSObject+runtime.h
//  muyingzhijia
//
//  Created by ma huajian on 15/12/10.
//  Copyright © 2015年 holyca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (runtime)
/**
 *  修改任何类的函数,使用新函数替代,可用于delegate或系统函数
 *  @tip:需要注意替换之后在整个项目中都不能调用原先的函数,需要时都只能调用新函数,函数交换需要严格考虑好
 *  @tip:慎用
 *
 *  @param originalSelector 原先的函数
 *  @param swizzledSelector 需要替换的函数
 */
+ (void)exchangeWithMethod1:(SEL)originalSelector andMethod2:(SEL)swizzledSelector;
+ (void)exchangeWithSEL1:(NSString *)originalSelector andSEL2:(NSString *)swizzledSelector;

/**把一些Unicode转换成我们熟悉的字体*/
+ (NSString *)stringByReplaceUnicode:(NSString *)string;

/**函数调用*/
- (id)ac_performSelector:(SEL)aSel;

/**属性列表*/
- (NSArray<NSString *> *)propertyList;
/**函数列表*/
- (NSArray<NSString *> *)methodList;
/**变量列表*/
- (NSArray<NSString *> *)ivarList;
/**协议列表*/
- (NSArray<NSString *> *)protocolList;

//-(void)addProperty

@end
