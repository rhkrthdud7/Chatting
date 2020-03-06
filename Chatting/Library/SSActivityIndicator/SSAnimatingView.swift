//
//  SSAnimatingView.swift
//  Chatting
//
//  Created by Soso on 01/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import UIKit

class SSAnimatingView: UIView {
    var animatedLayer: CALayer?
    
    override func didMoveToSuperview() {
        
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            layoutAnimatedLayer()
        } else {
            animatedLayer?.removeFromSuperlayer()
            animatedLayer = nil
        }
    }
    
    let constantRadius: CGFloat = 18
    let constantStrokeWidth: CGFloat = 2
    
    func layoutAnimatedLayer() {
        let layer = indefiniteAnimatedLayer()
        self.layer.addSublayer(layer)
        
        let widthDiff = bounds.width - layer.bounds.width
        let heightDiff = bounds.height - layer.bounds.height
        let width = bounds.width - layer.bounds.width/2 - widthDiff/2
        let height = bounds.height - layer.bounds.height/2 - heightDiff/2
        layer.position = CGPoint(x: width, y: height)
    }
    
    func indefiniteAnimatedLayer() -> CALayer {
        if animatedLayer == nil {
            let value = constantRadius + constantStrokeWidth / 2 + 5
            let center = CGPoint(x: value, y: value)
            let path = UIBezierPath(arcCenter: center, radius: constantRadius, startAngle: .pi / 2 * 3, endAngle: .pi / 2 + .pi * 5, clockwise: true)
            
            let animatedLayer = CAShapeLayer()
            animatedLayer.contentsScale = UIScreen.main.scale
            animatedLayer.frame = CGRect(x: 0, y: 0, width: value*2, height: value*2)
            animatedLayer.fillColor = UIColor.clear.cgColor
            animatedLayer.strokeColor = UIColor.black.cgColor
            animatedLayer.lineWidth = constantStrokeWidth
            animatedLayer.lineCap = .round
            animatedLayer.lineJoin = .bevel
            animatedLayer.path = path.cgPath
            
            let maskLayer = CALayer()
            let imagePath = Bundle.main.path(forResource: "angle_mask", ofType: "png")!
            maskLayer.contents = UIImage(contentsOfFile: imagePath)?.cgImage
            maskLayer.frame = animatedLayer.bounds
            animatedLayer.mask = maskLayer
            
            let duration: TimeInterval = 1
            let linearCurve = CAMediaTimingFunction(name: .linear)
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.fromValue = CGFloat(0)
            animation.toValue = CGFloat.pi * 2
            animation.duration = duration
            animation.timingFunction = linearCurve
            animation.repeatCount = .infinity
            animation.fillMode = .forwards
            animation.autoreverses = false
            animatedLayer.mask?.add(animation, forKey: "rotate")
            
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = duration
            animationGroup.repeatCount = .infinity
            animationGroup.isRemovedOnCompletion = true
            animationGroup.timingFunction = linearCurve
            
            let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
            strokeStartAnimation.fromValue = 0.015
            strokeStartAnimation.toValue = 0.515
            
            let strokeStopAnimation = CABasicAnimation(keyPath: "strokeStop")
            strokeStopAnimation.fromValue = 0.485
            strokeStopAnimation.toValue = 0.985
            
            animationGroup.animations = [strokeStartAnimation, strokeStopAnimation]
            animatedLayer.add(animationGroup, forKey: "progress")
            
            self.animatedLayer = animatedLayer
        }
        
        return animatedLayer!
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let value = constantRadius + constantStrokeWidth / 2 + 5
        return CGSize(width: value, height: value)
    }
    
}
