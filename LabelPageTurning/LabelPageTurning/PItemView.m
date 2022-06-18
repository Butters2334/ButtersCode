//
//  PItemView.m
//  LabelPageTurning
//
//  Created by ac on 2022/6/18.
//

#import "PItemView.h"
#import "UIView+size.h"
#import "ButtersTool.h"
#import <CoreText/CoreText.h>

@interface PItemView()
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UILabel *tLabel;
@end

@implementation PItemView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}
- (void)updateFrame
{
    self.backgroundColor = [UIColor clearColor];
    UIView *nibView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil][0];
    self.bgView = nibView;
    self.tLabel = [nibView subviews][0];
    nibView.size = self.bounds.size;
    nibView.layer.cornerRadius = 12;
    nibView.layer.masksToBounds = YES;
    [self addSubview:nibView];
    [nibView layoutIfNeeded];
    NSInteger fontSize = 200;
    do{
        self.tLabel.text = @"00";
        self.tLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        fontSize -- ;
    }while(getLabelFontWidth(self.tLabel) > kLabelWidth(self.tLabel));
}

-(void)setLabelString:(NSString *)labelString
{
    _labelString = [labelString copy];
    self.tLabel.text = _labelString;
    //左右对齐
    CGRect textSize = [_labelString boundingRectWithSize:CGSizeMake(self.tLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.tLabel.font} context:nil];
    CGFloat margin = (self.tLabel.frame.size.width - textSize.size.width) / (_labelString.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:_labelString];
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, _labelString.length - 1)];
    self.tLabel.attributedText = attributeString;
}
-(void)setBgColor:(UIColor *)bgColor
{
    self.bgView.backgroundColor = bgColor;
}
-(void)setLabelColor:(UIColor *)labelColor
{
    self.tLabel.textColor = labelColor;
}
@end
