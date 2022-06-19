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
    [self.view layoutIfNeeded];
    [self.bgView updateFrame];
    self.bgView.labelString = @"00";
//    self.bgView.bgColor = [UIColor lightTextColor];

    [self.topView updateFrame];
    self.topView.labelString = @"01";
//    self.topView.labelColor = [UIColor systemPinkColor];

    [self.bottomView updateFrame];
    self.bottomView.labelString = @"00";
//    self.bottomView.labelColor = [UIColor systemPinkColor];

    
    __weak typeof(self) weakSelf = self;
//    weakSelf.bgView.alpha = 0;
//    weakSelf.topView.alpha = 0;
//    weakSelf.bottomView.alpha = 0;
    
    [weakSelf pageTurning];
    [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
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
    __weak typeof(self) weakSelf = self;
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    theAnimation.duration = 1.f;
    theAnimation.beginTime = CACurrentMediaTime()+0.6;
    theAnimation.removedOnCompletion = NO;
    theAnimation.fillMode = @"forwards";
    theAnimation.repeatCount = 0;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat:-M_PI/2];
    [weakSelf.bgView.layer addAnimation:theAnimation forKey:@"animateTransform"];

    //修改数值
    sleepForMain(1.6, ^{
        weakSelf.bgView.labelString = weakSelf.topView.labelString;
    });

    //一半之后的动画
    CABasicAnimation *theAnimation2;
    theAnimation2=[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    theAnimation2.duration = 1.f;
    theAnimation2.beginTime = CACurrentMediaTime()+1.6;
    theAnimation2.removedOnCompletion = NO;
    theAnimation2.fillMode = @"forwards";
    theAnimation2.repeatCount = 0;
    theAnimation2.fromValue = [NSNumber numberWithFloat:M_PI/2];
    theAnimation2.toValue = [NSNumber numberWithFloat:0];
    [weakSelf.bgView.layer addAnimation:theAnimation2 forKey:@"animateTransform2"];
}
@end

