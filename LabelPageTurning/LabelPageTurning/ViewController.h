//
//  ViewController.h
//  LabelPageTurning
//
//  Created by ac on 2022/6/16.
//

#import <UIKit/UIKit.h>
#import "PItemView.h"

@interface ViewController : UIViewController

@property (weak,nonatomic)IBOutlet PItemView *bgView;

@property (weak,nonatomic)IBOutlet PItemView *topView;
@property (weak,nonatomic)IBOutlet PItemView *bottomView;
@end

