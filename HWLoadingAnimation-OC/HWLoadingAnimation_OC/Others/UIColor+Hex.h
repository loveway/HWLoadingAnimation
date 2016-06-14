//
//  UIColor+Hex.h
//  HWLoadingAnimation_OC
//
//  Created by HenryCheng on 16/6/13.
//  Copyright © 2016年 HenryCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

/**
 *  Create a new UIColor instance using a hex string input
 *
 *  @param hexString color hexString
 *
 *  @return color
 */
+ (UIColor *)colorWithHexString:(id)hexString;

@end
