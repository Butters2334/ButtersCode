//
//  UIColor+hex.m
//  LabelPageTurning
//
//  Created by ac on 2022/6/19.
//

#import "UIColor+hex.h"

@implementation UIColor (hex)

@end


UIColor *hexAlphaColor(NSString *hexString,CGFloat alpha)
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }

    if ([cString hasPrefix:@"0x"] || [cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }

    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }

    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }

    NSRange range;
    range.length = 2;

    range.location = 0;
    NSString *rString = [cString substringWithRange:range];

    range.location = 2;
    NSString *gString = [cString substringWithRange:range];

    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}
UIColor *hexColor(NSString *hexString)
{
    return hexAlphaColor(hexString, 1);
}

UIColor *rgbAlphaColor(CGFloat red,CGFloat green,CGFloat blue,CGFloat alpha)
{
    return [UIColor colorWithRed:(float)red/255 green:(float)green/255 blue:(float)blue/255 alpha:alpha];
}
UIColor *rgbColor(CGFloat red,CGFloat green,CGFloat blue)
{
    return rgbAlphaColor(red,green,blue,1);
}

UIColor *randomColor(void)
{
    CGFloat R = arc4random_uniform(256);
    CGFloat G = arc4random_uniform(256);
    CGFloat B = arc4random_uniform(256);
    return rgbColor(R, G, B);
}
