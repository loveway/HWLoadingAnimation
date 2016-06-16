//
//  AnimatiomView.m
//  HWLoadingAnimation_OC
//
//  Created by HenryCheng on 16/6/13.
//  Copyright © 2016年 HenryCheng. All rights reserved.
//

#import "AnimatiomView.h"
#import "UIColor+Hex.h"
#import "CircleLayer.h"
#import "TriangleLayer.h"
#import "RectangleLayer.h"
#import "WaveLayer.h"

@interface AnimatiomView ()

@property (strong, nonatomic) CircleLayer *circleLayer;
@property (strong, nonatomic) TriangleLayer *triangleLayer;
@property (strong, nonatomic) RectangleLayer *redRectangleLayer;
@property (strong, nonatomic) RectangleLayer *blueRectangleLayer;
@property (strong, nonatomic) WaveLayer *waveLayer;

@end

@implementation AnimatiomView

- (instancetype) initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addCircleLayer];
    }
    return self;
}

- (CircleLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [[CircleLayer alloc] init];
    }
    return _circleLayer;
}

- (TriangleLayer *)triangleLayer {
    if (!_triangleLayer) {
        _triangleLayer = [[TriangleLayer alloc] init];
    }
    return _triangleLayer;
}

- (RectangleLayer *)redRectangleLayer {
    if (!_redRectangleLayer) {
        _redRectangleLayer = [[RectangleLayer alloc] init];
    }
    return _redRectangleLayer;
}

- (RectangleLayer *)blueRectangleLayer {
    if (!_blueRectangleLayer) {
        _blueRectangleLayer = [[RectangleLayer alloc] init];
    }
    return _blueRectangleLayer;
}

- (WaveLayer *)waveLayer {
    if (!_waveLayer) {
        _waveLayer = [[WaveLayer alloc] init];
    }
    return _waveLayer;
}

- (void)addCircleLayer {
    [self.layer addSublayer:self.circleLayer];
    [_circleLayer expand];
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(wobbleCircleLayer) userInfo:nil repeats:NO];
}

- (void)wobbleCircleLayer {
    [_circleLayer wobbleAnimation];
    [self.layer addSublayer:self.triangleLayer];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(showTriangleAnimation) userInfo:nil repeats:NO];
}

- (void)showTriangleAnimation {
    [_triangleLayer triangleAnimate];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(transformAnima) userInfo:nil repeats:NO];
}

- (void)transformAnima {
    [self transformRotationZ];
    [_circleLayer contract];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawRedRectangleAnimation) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(drawBlueRectangleAnimation) userInfo:nil repeats:NO];
}

- (void)transformRotationZ {
    self.layer.anchorPoint = CGPointMake(0.5, 0.65);
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.duration = 0.45;
    rotationAnimation.removedOnCompletion = true;
    [self.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)drawRedRectangleAnimation {
    [self.layer addSublayer:self.redRectangleLayer];
    [_redRectangleLayer strokeChangeWithColor:[UIColor colorWithHexString:@"#da70d6"]];
    
}

- (void)drawBlueRectangleAnimation {
    [self.layer addSublayer:self.blueRectangleLayer];
    [_redRectangleLayer strokeChangeWithColor:[UIColor colorWithHexString:@"#40e0b0"]];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawWaveAnimation) userInfo:nil repeats:NO];
}

- (void)drawWaveAnimation {
    [self.layer addSublayer:self.waveLayer];
    [_waveLayer waveAnimate];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(expandView) userInfo:nil repeats:NO];
}

- (void)expandView {
    self.backgroundColor = [UIColor colorWithHexString:@"#40e0b0"];
    self.frame = CGRectMake(self.frame.origin.x - self.blueRectangleLayer.lineWidth,
                       self.frame.origin.y - self.blueRectangleLayer.lineWidth,
                       self.frame.size.width + self.blueRectangleLayer.lineWidth * 2,
                            self.frame.size.height + self.blueRectangleLayer.lineWidth * 2);
    self.layer.sublayers = nil;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = self.parentFrame;

    } completion:^(BOOL finished) {
        if (_delegate && [_delegate respondsToSelector:@selector(completeAnimation)]) {
            [_delegate completeAnimation];
        }
    }];
}

@end
