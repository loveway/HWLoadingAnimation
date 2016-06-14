//
//  CircleLayer.h
//  HWLoadingAnimation_OC
//
//  Created by HenryCheng on 16/6/13.
//  Copyright © 2016年 HenryCheng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CircleLayer : CAShapeLayer

/**
 *  Wobble group animation
 */
- (void)wobbleAnimation;

/**
 *  Expend animation for circle layer
 */
- (void)expand;

/**
 *  Contract animation for circle layer
 */
- (void)contract;

@end
