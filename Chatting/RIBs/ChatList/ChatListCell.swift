//
//  ChatListCell.swift
//  Chatting
//
//  Created by Soso on 05/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import UIKit

class ChatListCell: UITableViewCell {

    @IBOutlet weak var viewProfile: UIView!
    
    let imageView1 = UIImageView()
    let imageView2 = UIImageView()
    let imageView3 = UIImageView()
    let imageView4 = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewProfile.addSubview(imageView1)
        viewProfile.addSubview(imageView2)
        viewProfile.addSubview(imageView3)
        viewProfile.addSubview(imageView4)
    }
    
    func configure(data: ChatRoomViewModel) {
        let imageViews = [imageView1, imageView2, imageView3, imageView4]
        setFrameAndRadius(imageViews: Array(imageViews[0..<data.imageURLs.count]))
        for (index, _) in data.imageURLs.enumerated() {
            let imageView = imageViews[index]
            imageView.image = #imageLiteral(resourceName: "image_profile_default")
        }
    }
    
    // from one to four profile imageViews
    func setFrameAndRadius(imageViews: [UIImageView]) {
        let mid = viewProfile.bounds.midX
        let max = viewProfile.bounds.maxX
        // set imageViews's frames based on count
        if imageViews.count == 1 {
            let value: CGFloat = 54
            imageViews[0].frame = CGRect(x: 0, y: 0, width: value, height: value)
        } else if imageViews.count == 2 {
            let value: CGFloat = 35
            imageViews[0].frame = CGRect(x: max-value, y: max-value, width: value, height: value)
            imageViews[1].frame = CGRect(x: 0, y: 0, width: value, height: value)
        } else if imageViews.count == 3 {
            let value: CGFloat = 30
            imageViews[0].frame = CGRect(x: mid-value/2, y: 0, width: value, height: value)
            imageViews[1].frame = CGRect(x: max-value, y: max-value, width: value, height: value)
            imageViews[2].frame = CGRect(x: 0, y: max-value, width: value, height: value)
        } else if imageViews.count == 4 {
            let value: CGFloat = 28
            imageViews[0].frame = CGRect(x: 0, y: 0, width: value, height: value)
            imageViews[1].frame = CGRect(x: max-value, y: 0, width: value, height: value)
            imageViews[2].frame = CGRect(x: 0, y: max-value, width: value, height: value)
            imageViews[3].frame = CGRect(x: max-value, y: max-value, width: value, height: value)
        }
        
        // set masking layer for each imageView
        for (current, imageView) in imageViews.enumerated() {
            let ratio: CGFloat = 0.15
            let inset: CGFloat = 2
            
            let bounds = imageView.bounds
            let width = bounds.width
            let height = bounds.height
            
            let pathOriginal = UIBezierPath()
            let pathRect = UIBezierPath(rect: bounds)
            let pathClip = UIBezierPath()
            
            // bezierPath for the main path with custom radius
            let topCenter = CGPoint(x: bounds.midX, y: 0)
            let leftCenter = CGPoint(x: 0, y: bounds.midY)
            let bottomCenter = CGPoint(x: bounds.midX, y: height)
            let rightCenter = CGPoint(x: width, y: bounds.midY)
            pathOriginal.move(to: topCenter)
            pathOriginal.addCurve(to: leftCenter,
                          controlPoint1: CGPoint(x: width*ratio, y: 0),
                          controlPoint2: CGPoint(x: 0, y: height*ratio))
            pathOriginal.addCurve(to: bottomCenter,
                          controlPoint1: CGPoint(x: 0, y: height*(1-ratio)),
                          controlPoint2: CGPoint(x: width*ratio, y: height))
            pathOriginal.addCurve(to: rightCenter,
                          controlPoint1: CGPoint(x: width*(1-ratio), y: height),
                          controlPoint2: CGPoint(x: width, y: height*(1-ratio)))
            pathOriginal.addCurve(to: topCenter,
                          controlPoint1: CGPoint(x: width, y: height*ratio),
                          controlPoint2: CGPoint(x: width*(1-ratio), y: 0))
            
            // add 2pt inset
            let factor = (bounds.width - inset * 2) / bounds.width
            let transform = CGAffineTransform(scaleX: factor, y: factor).translatedBy(x: inset, y: inset)
            let pathMask = UIBezierPath(cgPath: pathOriginal.cgPath)
            pathMask.apply(transform)
            
            // add clipping for lower imageViews
            for index in 0..<current {
                let path = UIBezierPath(cgPath: pathOriginal.cgPath)
                let x = imageViews[index].frame.minX - imageView.frame.minX
                let y = imageViews[index].frame.minY - imageView.frame.minY
                let translate = CGAffineTransform(translationX: x, y: y)
                path.apply(translate)
                pathClip.append(path)
            }

            // append clipping area to the bounding rect of the current imageView
            pathRect.append(pathClip)
            // get new image for masking layer
            let image = UIGraphicsImageRenderer(bounds: bounds).image { (c) in
                // add clip
                pathRect.addClip()
                // fill non-clipped area
                pathMask.fill()
            }
            
            // set layer mask
            let layer = CALayer()
            layer.frame = bounds
            layer.contents = image.cgImage
            imageView.layer.mask = layer
        }
    }
}
