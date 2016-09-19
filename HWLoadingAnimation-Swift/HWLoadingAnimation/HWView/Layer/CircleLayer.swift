//
//  CircleLayer.swift
//  HWLoadingAnimation
//
//  Created by HenryCheng on 16/6/13.
//  Copyright © 2016年 HenryCheng. All rights reserved.
//

import UIKit

class CircleLayer: CAShapeLayer {
    
    let KAnimationDuration: CFTimeInterval = 0.3
    let KAnimationBeginTime: CFTimeInterval = 0.0
    
    override init() {
        super.init()
        self.fillColor = UIColor.colorWithHexString(hex: "#da70d6").cgColor
        self.path = circleSmallPath.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// begin path
    var circleSmallPath: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 50.0, y: 50.0, width: 0.0, height: 0.0))
    }
    /// end path
    var circleBigPath: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 2.5, y: 17.5, width: 95.0, height: 95.0))
    }
    /// the path squish circle on vertical
    var circleVerticalSquishPath: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 2.5, y: 20.0, width: 95.0, height: 90.0))
    }
    /// the path squish circle on horizontal
    var circleHorizontalSquishPath: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 5.0, y: 20.0, width: 90.0, height: 90.0))
    }
    
    /**
     wobbl group animation
     */
    func wobbleAnimate() {
        // 1、animation begin from bigPath to verticalPath
        let animation1: CABasicAnimation = CABasicAnimation(keyPath: "path")
        animation1.fromValue = circleBigPath.cgPath
        animation1.toValue = circleVerticalSquishPath.cgPath
        animation1.beginTime = KAnimationBeginTime
        animation1.duration = KAnimationDuration
        
        // 2、animation vertical to horizontal
        let  animation2: CABasicAnimation = CABasicAnimation(keyPath: "path")
        animation2.fromValue = circleVerticalSquishPath.cgPath
        animation2.toValue = circleHorizontalSquishPath.cgPath
        animation2.beginTime = animation1.beginTime + animation1.duration
        animation2.duration = KAnimationDuration
        
        // 3、animation horizontal to vertical
        let  animation3: CABasicAnimation = CABasicAnimation(keyPath: "path")
        animation3.fromValue = circleHorizontalSquishPath.cgPath
        animation3.toValue = circleVerticalSquishPath.cgPath
        animation3.beginTime = animation2.beginTime + animation2.duration
        animation3.duration = KAnimationDuration
        
        // 4、animation vertical to bigPath
        let  animation4: CABasicAnimation = CABasicAnimation(keyPath: "path")
        animation4.fromValue = circleVerticalSquishPath.cgPath
        animation4.toValue = circleBigPath.cgPath
        animation4.beginTime = animation3.beginTime + animation3.duration
        animation4.duration = KAnimationDuration
        
        // 5、group animation
        let animationGroup: CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [animation1, animation2, animation3, animation4]
        animationGroup.duration = 4 * KAnimationDuration
        animationGroup.repeatCount = 2
        add(animationGroup, forKey: nil)
        
    }
    
    /**
     expand animation function
     */
    func expand() {
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = circleSmallPath.cgPath
        expandAnimation.toValue = circleBigPath.cgPath
        expandAnimation.duration = KAnimationDuration
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.isRemovedOnCompletion = false
        self.add(expandAnimation, forKey: nil)
    }
    
    /**
     contract animation function
     */
    func contract() {
        let contractAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        contractAnimation.fromValue = circleBigPath.cgPath
        contractAnimation.toValue = circleSmallPath.cgPath
        contractAnimation.duration = KAnimationDuration
        contractAnimation.fillMode = kCAFillModeForwards
        contractAnimation.isRemovedOnCompletion = false
        add(contractAnimation, forKey: nil)
    }
    
}
