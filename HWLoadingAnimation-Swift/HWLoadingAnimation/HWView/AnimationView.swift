//
//  AnimationView.swift
//  HWLoadingAnimation
//
//  Created by HenryCheng on 16/6/13.
//  Copyright © 2016年 HenryCheng. All rights reserved.
//

import UIKit

protocol AnimationViewDelegate: class {
    
    func completeAnimation()
}

class AnimationView: UIView {
    
    let circleLayer = CircleLayer()
    let triangleLayer = TriangleLayer()
    let redRectangleLayer = RectangleLayer()
    let blueRectangleLayer = RectangleLayer()
    let waveLayer = WaveLayer()
    var parentFrame: CGRect = CGRectZero
    weak var delegate: AnimationViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
        addCircleLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     add circle layer
     */
    func addCircleLayer() {
        self.layer.addSublayer(circleLayer)
        circleLayer.expand()
        NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(wobbleCircleLayer), userInfo: nil, repeats: false)
    }
    
    /**
     circle layer wobble animation
     */
    func wobbleCircleLayer() {
        circleLayer.wobbleAnimate()
        layer.addSublayer(triangleLayer)
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(showTriangleAnimation), userInfo: nil, repeats: false)
    }
    
    /**
     show triangle animation
     */
    func showTriangleAnimation() {
        triangleLayer.triangleAnimate()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(transformAnima), userInfo: nil, repeats: false)
    }
    
    /**
     self transform and add rectangle
     */
    func transformAnima() {
        transformRotationZ()
        circleLayer.contract()
        NSTimer.scheduledTimerWithTimeInterval(0.45, target: self, selector: #selector(drawRedRectangleAnimation), userInfo: nil, repeats: false)
        NSTimer.scheduledTimerWithTimeInterval(0.65, target: self, selector: #selector(drawBlueRectangleAnimation), userInfo: nil, repeats: false)
    }
    
    /**
     self transform z
     */
    func transformRotationZ() {
        self.layer.anchorPoint = CGPointMake(0.5, 0.6)
        let rotationAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = CGFloat(M_PI * 2)
        rotationAnimation.duration = 0.45
        rotationAnimation.removedOnCompletion = true
        layer.addAnimation(rotationAnimation, forKey: nil)
    }
    
    /**
     draw red stroke
     */
    func drawRedRectangleAnimation() {
        layer.addSublayer(redRectangleLayer)
        redRectangleLayer.strokeChangeWithColor(UIColor.colorWithHexString("#da70d6"))
    }
    
    /**
     draw blue stroke
     */
    func drawBlueRectangleAnimation() {
        layer.addSublayer(blueRectangleLayer)
        blueRectangleLayer.strokeChangeWithColor(UIColor.colorWithHexString("#40e0b0"))
        NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(drawWaveAnimation), userInfo: nil, repeats: false)
    }
    
    func drawWaveAnimation() {
        layer.addSublayer(waveLayer)
        waveLayer.animate()
        NSTimer.scheduledTimerWithTimeInterval(0.9, target: self, selector: #selector(expandView), userInfo: nil, repeats: false)
    }
    
    func expandView() {
        backgroundColor = UIColor.colorWithHexString("#40e0b0")
        frame = CGRectMake(frame.origin.x - blueRectangleLayer.lineWidth,
                           frame.origin.y - blueRectangleLayer.lineWidth,
                           frame.size.width + blueRectangleLayer.lineWidth * 2,
                           frame.size.height + blueRectangleLayer.lineWidth * 2)
        layer.sublayers = nil
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.frame = self.parentFrame
            }, completion: { finished in
                self.delegate?.completeAnimation()
        })

    }

}
