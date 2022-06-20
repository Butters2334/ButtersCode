//
//  UIButton+Block.h
//
//  Created by ma huajian on 13-3-1.
//  Copyright (c) 2013年 ma huajian. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>
@implementation UIButton (Block)
- (void)handleControlBlock:(void (^)(void))block
{
    [self handleControlEvent:UIControlEventTouchUpInside withBlock:block];
}

- (void)handleControlEvent:(UIControlEvents)event withBlock:(void (^)(void))block
{
    if (!event)
        event = UIControlEventTouchUpInside;
    objc_setAssociatedObject(self, &"myBlock", block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self
               action:@selector(blockEvent:)
     forControlEvents:event];
//    NSArray *array=[self actionsForTarget:self forControlEvent:UIControlEventTouchUpInside];
//    for(int i=0;i<array.count;i++)
//    {
//        if([self allTargets].allObjects[i]!=self)
//        {
////            NSArray *arr=[self actionsForTarget:([self allTargets].allObjects[i])
////                                forControlEvent:UIControlEventTouchUpInside];
//            [self removeTarget:self
//                        action:(SEL)array[i]
//              forControlEvents:UIControlEventTouchUpInside];
//        }
//    }
}

- (void)blockEvent:(UIButton *)sender
{
    void (^block) (void) = [self getEventBlock];
    if (block) {
        block();
    }
}

- (void (^)(void))getEventBlock
{
    return objc_getAssociatedObject(self, &"myBlock");
}

- (void)removeEventBlock
{
    [self removeEventBlockWithEvent:(UIControlEventTouchUpInside)];
}

- (void)removeEventBlockWithEvent:(UIControlEvents)event
{
    [self removeTarget:self action:@selector(blockEvent:) forControlEvents:event];
}

@end
@implementation UIView (Block)
- (void)touchEventWithBlock:(void (^)(CGPoint p))touchBlock
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *touchEvent = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchEvent:)];
    [self addGestureRecognizer:touchEvent];
    objc_setAssociatedObject(self, &"touchBlock", touchBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)touchEvent:(UIGestureRecognizer *)pan
{
    CGPoint currentLocation = [pan locationInView:self];
    //    NSLog(@"");
    void (^touchBlock)(CGPoint p) = objc_getAssociatedObject(self, &"touchBlock");;
    if (touchBlock) {
        touchBlock(currentLocation);
    }
}

@end
