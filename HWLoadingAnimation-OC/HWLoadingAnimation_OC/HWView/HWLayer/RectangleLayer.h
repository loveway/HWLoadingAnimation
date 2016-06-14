//
//  RectangleLayer.h
//  HWLoadingAnimation_OC
//
//  Created by HenryCheng on 16/6/13.
//  Copyright © 2016年 HenryCheng. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface RectangleLayer : CAShapeLayer

/**
 *  Change line stroke color with custon color
 *
 *  @param color custom color
 */
- (void)strokeChangeWithColor:(UIColor *)color;

@end
