//
//  UIColor+hex.h
//  LabelPageTurning
//
//  Created by ac on 2022/6/19.
//

#import <UIKit/UIKit.h>

@interface UIColor (hex)
@end

UIColor *randomColor(void);
UIColor *hexColor(NSString *hexString);
UIColor *eightBitColor(CGFloat red,CGFloat green,CGFloat blue);
UIColor *rgbAlphaColor(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha);

UIColor *hexAlphaColor(NSString *hexString,CGFloat alpha);
UIColor *hexColor(NSString *hexString);
UIColor *rgbAlphaColor(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha);
UIColor *rgbColor(CGFloat red,CGFloat green,CGFloat blue);
UIColor *randomColor(void);
