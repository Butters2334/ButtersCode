//
//  PItemView.h
//  LabelPageTurning
//
//  Created by ac on 2022/6/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PItemView : UIView
- (void)updateFrame;
@property (nonatomic,strong)NSString *labelString;

@property (nonatomic,strong)UIColor *labelColor;
@property (nonatomic,strong)UIColor *bgColor;
           
           
@end

NS_ASSUME_NONNULL_END
