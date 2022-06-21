//
//  ButtersTool.c
//  LabelPageTurning
//
//  Created by ac on 2022/6/17.
//

#include "ButtersTool.h"
#import <objc/runtime.h>


void sleepForMain(NSTimeInterval ti, dispatch_block_t block){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:ti];
        dispatch_async(dispatch_get_main_queue(), block);
    });
}

void sleepForBg(NSTimeInterval ti, dispatch_block_t block){
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:ti];
        dispatch_async(dispatch_queue_create("com.gcd.bg", DISPATCH_QUEUE_SERIAL), block);
    });
}

void runtimeReplaceFunctionWithSelector(Class aClass,SEL origin,SEL swizzle,BOOL isClassMethod)
{
    Method originMethod;
    Method swizzleMethod;
    if (isClassMethod == YES) {
        originMethod = class_getClassMethod(aClass, origin);
        swizzleMethod = class_getClassMethod(aClass, swizzle);
    }else{
        originMethod = class_getInstanceMethod(aClass, origin);
        swizzleMethod = class_getInstanceMethod(aClass, swizzle);
    }
    method_exchangeImplementations(originMethod, swizzleMethod);
}

//获取label内容宽度
CGFloat getLabelFontWidth(UILabel *tLabel){
    return [tLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : tLabel.font} context:nil].size.width;
}


/**从UIWindow获取当前vc,调试阶段很实用*/
UIViewController* getTopViewController(void)
{
    UIWindow *window = [[UIApplication sharedApplication]keyWindow];
    UIViewController *rootVC = window.rootViewController;
    if([rootVC isKindOfClass:UINavigationController.class])
    {
        UINavigationController *nav = (UINavigationController *)rootVC;
        return nav.topViewController;
    }
    return rootVC;
}
