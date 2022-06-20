//
//  UIButton+Block.h
//
//  Created by ma huajian on 13-3-1.
//  Copyright (c) 2013年 ma huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Block)
/*
 *  handleControlEvent:withBlock:
 *  使用block处理button事件
 *  入参:event 触发类型                 例: UIControlEventTouchUpInside
 *      block 满足触发条件后的事件        例:^{}
 *  注:最后入参有效,同时只能保存一个block触发事件
 */
- (void)handleControlEvent:(UIControlEvents)event withBlock:(void (^)(void))block;
- (void)handleControlBlock:(void (^)(void))block;
- (void (^)(void))getEventBlock;
- (void)removeEventBlock;
- (void)removeEventBlockWithEvent:(UIControlEvents)event;

@end

@interface UIView (Block)
- (void)touchEventWithBlock:(void (^)(CGPoint p))touchBlock;
@end
