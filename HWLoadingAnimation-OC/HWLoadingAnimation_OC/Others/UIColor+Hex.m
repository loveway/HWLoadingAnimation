//
//  UIColor+Hex.m
//  HWLoadingAnimation_OC
//
//  Created by HenryCheng on 16/6/13.
//  Copyright © 2016年 HenryCheng. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

// 0xff，即二进制的1序列比如11111111，是滤码。
//(0xABCDEF &0xFF0000 ) >> 16
//(0xABCDEF &0xFF00) >> 8
// 0xABCDEF &0xFF
//分别获得原数据的AB、CD、EF不同位置的数据
//分别对应RGB三色中的红色 R 为AB，绿色 G 为CD，蓝色 B 为EF

+ (UIColor *)colorWithHexString:(id)hexString {
    if (![hexString isKindOfClass:[NSString class]] || [hexString length] == 0) {
        return [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    }
    
    const char *s = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
    if (*s == '#') {
        ++s;
    }
    unsigned long long value = strtoll(s, nil, 16);
    int r, g, b, a;
    switch (strlen(s)) {
        case 2:
            // xx
            r = g = b = (int)value;
            a = 255;
            break;
        case 3:
            // RGB
            r = ((value & 0xf00) >> 8);
            g = ((value & 0x0f0) >> 4);
            b = ((value & 0x00f) >> 0);
            r = r * 16 + r;
            g = g * 16 + g;
            b = b * 16 + b;
            a = 255;
            break;
        case 6:
            // RRGGBB
            r = (value & 0xff0000) >> 16;
            g = (value & 0x00ff00) >>  8;
            b = (value & 0x0000ff) >>  0;
            a = 255;
            break;
        default:
            // RRGGBBAA
            r = (value & 0xff000000) >> 24;
            g = (value & 0x00ff0000) >> 16;
            b = (value & 0x0000ff00) >>  8;
            a = (value & 0x000000ff) >>  0;
            break;
    }
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

@end
