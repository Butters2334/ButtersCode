//
//  ViewController.m
//  LabelPageTurning
//
//  Created by ac on 2022/6/16.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "ButtersTool.h"
#import "UIColor+hex.h"

@interface ViewController ()
@property (nonatomic,strong)NSString *tLabelString;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view layoutIfNeeded];
    [self.bgView updateFrame];
    self.bgView.labelString = @"00";
    [self.topView updateFrame];
    self.topView.labelString = @"01";

    [self.bottomView updateFrame];
    self.bottomView.labelString = @"00";

    
    __weak typeof(self) weakSelf = self;
    [weakSelf pageTurning];
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSString *firstString = weakSelf.topView.labelString;
        NSInteger s = firstString.integerValue + 1;
        s = s >= 60 ? 0 : s;
        NSString *nextString = [NSString stringWithFormat:@"%@%@",(s<10?@"0":@""),@(s)];
        weakSelf.bgView.labelString = firstString;
        weakSelf.topView.labelString = nextString;
        weakSelf.bottomView.labelString = firstString;
        [weakSelf pageTurning];
    }];
}

//翻转效果
-(void)pageTurning
{
    self.bgView.bgColor = hexColor(@"#555555");
    __weak typeof(self) weakSelf = self;
    
    CGFloat firstDelay = .4f;
    CGFloat animateTime = .3f;
    CGFloat topAnimateTime = animateTime * 0.5;
    CGFloat bottomAnimateTime = animateTime - topAnimateTime;

    CAAnimation *theAnimation = [self retationAnimation:0 toValue:-M_PI/2 duration:topAnimateTime delay:firstDelay];
    [weakSelf.bgView.layer addAnimation:theAnimation forKey:@"animateTransform"];

    //修改数值
    sleepForMain(firstDelay+topAnimateTime, ^{
        weakSelf.bgView.labelString = weakSelf.topView.labelString;
        weakSelf.bgView.bgColor = hexColor(@"#444444");
    });
    sleepForMain(firstDelay+animateTime, ^{
        weakSelf.bgView.bgColor = hexColor(@"#555555");
    });

    CAAnimation *theAnimation2 = [self retationAnimation:M_PI/2 toValue:0 duration:bottomAnimateTime delay:firstDelay+topAnimateTime];
    [weakSelf.bgView.layer addAnimation:theAnimation2 forKey:@"animateTransform2"];
}
-(CAAnimation *)retationAnimation:(CGFloat)fromValue toValue:(CGFloat)toValue duration:(CGFloat)duration delay:(CGFloat)delay
{
    CABasicAnimation *theAnimation2;
    theAnimation2=[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    theAnimation2.duration = duration;
    theAnimation2.beginTime = CACurrentMediaTime()+delay;
    theAnimation2.removedOnCompletion = NO;
    theAnimation2.fillMode = @"forwards";
    theAnimation2.repeatCount = 0;
    theAnimation2.fromValue = [NSNumber numberWithFloat:fromValue];
    theAnimation2.toValue = [NSNumber numberWithFloat:toValue];
    return theAnimation2;
}
@end

