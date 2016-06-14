//
//  AnimatiomView.h
//  HWLoadingAnimation_OC
//
//  Created by HenryCheng on 16/6/13.
//  Copyright © 2016年 HenryCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnimatiomViewDelegate <NSObject>

- (void)completeAnimation;

@end

@interface AnimatiomView : UIView

@property (assign, nonatomic) CGRect parentFrame;
@property (weak, nonatomic) id<AnimatiomViewDelegate>delegate;

@end
