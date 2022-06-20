//
//  NSObject+runtime.m
//  muyingzhijia
//
//  Created by ma huajian on 15/12/10.
//  Copyright © 2015年 holyca. All rights reserved.
//

#import "NSObject+runtime.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (runtime)
/**
 *  修改任何类的函数,使用新函数替代,可用于delegate或系统函数
 *  @tip:需要注意替换之后在整个项目中都不能调用原先的函数,需要时都只能调用新函数,函数交换需要严格考虑好
 *  @tip:如果originalSelector并不存在于class中时,流程等于是给class创建了新函数(但是名称为originalSelector)
 *  @tip:慎用
 *
 *  @param originalSelector 原先的函数
 *  @param swizzledSelector 需要替换的函数
 */
+ (void)exchangeWithMethod1:(SEL)originalSelector andMethod2:(SEL)swizzledSelector
{
    Class class = [self class];
    if (!class || !originalSelector || !swizzledSelector) {
        NSLog(@"method 入参有误");
        return;
    }
    //1,类函数需要用method_exchangeImplementations来替换
    //2,resolveInstanceMethod和resolveClassMethod都不太好用,这里改为获取Method判断
    Method originalMethod_instance = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod_instance = class_getInstanceMethod(class, swizzledSelector);
    Method originalMethod_class = class_getClassMethod(class, originalSelector);
    Method swizzledMethod_class = class_getClassMethod(class, swizzledSelector);
    BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod_instance), method_getTypeEncoding(swizzledMethod_instance));
    if(swizzledMethod_instance==nil)
    {
        success = false;
    }
    //success用于标记出委托函数之类没有实现的函数
    //originalMethod_instance && swizzledMethod_instance标记出实例函数替换,找不到originalMethod_instance时可能是原委托函数没有实现导致;
    //originalMethod_class && swizzledMethod_class类函数交换(类函数不做判断是否有实现)
    if ((originalMethod_instance && swizzledMethod_instance) || success) {
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod_instance), method_getTypeEncoding(originalMethod_instance));
        } else {
            method_exchangeImplementations(originalMethod_instance, swizzledMethod_instance);
        }
    } else if (originalMethod_class && swizzledMethod_class) {
        method_exchangeImplementations(originalMethod_class, swizzledMethod_class);
    } else {
        //NSLog(@"%@-在%@中不存在(不能替换不存在的函数)", NSStringFromSelector(originalSelector), class);
    }
}

+ (void)exchangeWithSEL1:(NSString *)originalSelector andSEL2:(NSString *)swizzledSelector
{
    [self exchangeWithMethod1:NSSelectorFromString(originalSelector)
                   andMethod2:NSSelectorFromString(swizzledSelector)];
}

+ (NSString *)stringByReplaceUnicode:(NSString *)string
{
    NSMutableString *convertedString = [string mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    //CFStringCreateMutableCopy(<#CFAllocatorRef alloc#>, <#CFIndex maxLength#>, <#CFStringRef theString#>)
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

- (id)ac_performSelector:(SEL)aSel
{
    if (!self || !aSel) {
        NSLog(@"入参错误 - %@", NSStringFromSelector(_cmd));
        return nil;
    }
    id (*action)(id,SEL) = (id (*)(id,SEL))objc_msgSend;
    return action(self,aSel);
//    return objc_msgSend(self, aSel);
}

/*
   // 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
   // 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
   +(BOOL)resolveInstanceMethod:(SEL)sel
   {

    if (sel == @selector(eat)) {
        // 动态添加eat方法

        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, @selector(eat), eat, "v@:");

    }

    return [super resolveInstanceMethod:sel];
   }
 */
#pragma mark - 获取属性列表
- (NSArray<NSString *> *)propertyList
{
    return [self.class propertyList];
}

+ (NSArray<NSString *> *)propertyList
{
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList(self, &count);
    NSMutableArray *nameList = [NSMutableArray new];
    NSMutableArray *attributesList = [NSMutableArray new];
    for (unsigned int index = 0; index < count; index++) {
        objc_property_t property = propertyList[index];
        const char *propertyName = property_getName(property);
        const char *propertyAttributes = property_getAttributes(property);
        //unsigned int attributeCount;
        //objc_property_attribute_t *attribute_t = property_copyAttributeList(property, &attributeCount);
        [nameList addObject:[NSString stringWithUTF8String:propertyName]];
        [attributesList addObject:[NSString stringWithUTF8String:propertyAttributes]];
    }
    return nameList;
}

#pragma mark - 获取方法列表
- (NSArray<NSString *> *)methodList
{
    return [self.class methodList];
}

+ (NSArray<NSString *> *)methodList
{
    unsigned int count;
    Method *methodList = class_copyMethodList(self, &count);
    NSMutableArray *nameList = [NSMutableArray new];
    for (unsigned int index = 0; index < count; index++) {
        Method method = methodList[index];
        SEL method_SEL = method_getName(method);
        [nameList addObject:NSStringFromSelector(method_SEL)];
    }
    return nameList;
}

#pragma mark - 获取变量列表
- (NSArray<NSString *> *)ivarList
{
    return [self.class ivarList];
}

+ (NSArray<NSString *> *)ivarList
{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(self, &count);
    NSMutableArray *nameList = [NSMutableArray new];
    for (unsigned int index = 0; index < count; index++) {
        Ivar ivar = ivarList[index];
        const char *propertyName = ivar_getName(ivar);
        [nameList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return nameList;
}

#pragma mark - 获取协议列表
- (NSArray<NSString *> *)protocolList
{
    return [self.class protocolList];
}

+ (NSArray<NSString *> *)protocolList
{
    unsigned int count;
    __unsafe_unretained Protocol * *protocolList = class_copyProtocolList(self, &count);
    NSMutableArray *nameList = [NSMutableArray new];
    for (unsigned int index = 0; index < count; index++) {
        Protocol *protocol = protocolList[index];
        const char *propertyName = protocol_getName(protocol);
        [nameList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return nameList;
}

@end
