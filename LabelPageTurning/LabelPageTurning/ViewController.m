//
//  ViewController.m
//  LabelPageTurning
//
//  Created by ac on 2022/6/16.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "ButtersTool.h"




@interface ViewController ()
@property (nonatomic,strong)NSString *tLabelString;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bgView.layer.cornerRadius = 12;
    self.bgView.layer.masksToBounds = YES;
    NSLog(@"%@",NSStringFromCGSize(self.tLabel.frame.size));
    [self.view layoutIfNeeded];
    NSLog(@"%@",NSStringFromCGSize(self.tLabel.frame.size));
    self.tLabelString  = @"00";
    NSInteger fontSize = 200;
    do{
        self.tLabel.text = self.tLabelString;
        self.tLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        fontSize -- ;
    }while(getLabelFontWidth(self.tLabel) > kLabelWidth(self.tLabel));
    NSLog(@"%@",self.tLabel.font);

    __weak typeof(self) weakSelf = self;
    [weakSelf pageTurning];
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSInteger s = weakSelf.tLabelString.integerValue + 1;
        s = s >= 60 ? 0 : s;
        weakSelf.tLabelString = [NSString stringWithFormat:@"%@%@",(s<10?@"0":@""),@(s)];
        [weakSelf pageTurning];
    }];
}

-(void)pageTurning
{
    //左右对齐
    CGRect textSize = [self.tLabelString boundingRectWithSize:CGSizeMake(self.tLabel.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.tLabel.font} context:nil];
    CGFloat margin = (self.tLabel.frame.size.width - textSize.size.width) / (self.tLabelString.length - 1);
    NSNumber *number = [NSNumber numberWithFloat:margin];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:self.tLabelString];
    [attributeString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.tLabelString.length - 1)];
//    [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:170.0f] range:NSMakeRange(0, self.tLabelString.length )];
    self.tLabel.attributedText = attributeString;

    
    __weak typeof(self) weakSelf = self;
    sleepForMain(.6f, ^{
        //翻转效果
        CATransition *animation = [CATransition animation];
        animation.duration = .5f;
        animation.type = @"oglFlip";
        animation.subtype = kCATransitionFromBottom;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [weakSelf.bgView.layer addAnimation:animation forKey:@"animation"];
    });

}
@end

