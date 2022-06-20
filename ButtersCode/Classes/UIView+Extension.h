//
//  UIView+Extension.h
//
//  Created by ma huajian on 13-6-3.
//  Copyright (c) 2013年 ma huajian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
/**
 *  分类中的函数,获取view.size
 */
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


+(UIView *)viewWithImage:(NSString *)imageNamed;
@end
