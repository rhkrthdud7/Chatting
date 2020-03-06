//
//  UIView+Extensions.swift
//  Chatting
//
//  Created by Soso on 05/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import UIKit

extension UIView {
    func roundedCorners(withRatio ratio: CGFloat = 0.15, border: CGFloat = 2) {
        let path = UIBezierPath()
        let width = bounds.width
        let height = bounds.height
        let topCenter = CGPoint(x: bounds.midX, y: 0)
        let leftCenter = CGPoint(x: 0, y: bounds.midY)
        let bottomCenter = CGPoint(x: bounds.midX, y: height)
        let rightCenter = CGPoint(x: width, y: bounds.midY)
        path.move(to: topCenter)
        path.addCurve(to: leftCenter,
                      controlPoint1: CGPoint(x: width*ratio, y: 0),
                      controlPoint2: CGPoint(x: 0, y: height*ratio))
        path.addCurve(to: bottomCenter,
                      controlPoint1: CGPoint(x: 0, y: height*(1-ratio)),
                      controlPoint2: CGPoint(x: width*ratio, y: height))
        path.addCurve(to: rightCenter,
                      controlPoint1: CGPoint(x: width*(1-ratio), y: height),
                      controlPoint2: CGPoint(x: width, y: height*(1-ratio)))
        path.addCurve(to: topCenter,
                      controlPoint1: CGPoint(x: width, y: height*ratio),
                      controlPoint2: CGPoint(x: width*(1-ratio), y: 0))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        layer.sublayers?.removeAll()
        let shape = CAShapeLayer()
        shape.frame = bounds
        shape.path = path.cgPath
        shape.lineWidth = border*2
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.clear.cgColor
        layer.insertSublayer(shape, at: 0)
    }
}
