//
//  ChatRoomCell.swift
//  Chatting
//
//  Created by Soso on 05/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import UIKit

class ChatRoomCell: UITableViewCell {

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
        setImageViewFrames(imageViews: Array(imageViews[0..<data.imageURLs.count]))
        for (index, _) in data.imageURLs.enumerated() {
            let imageView = imageViews[index]
            imageView.image = #imageLiteral(resourceName: "image_profile_default")
            imageView.roundedCorners()
        }
    }
    
    func setImageViewFrames(imageViews: [UIImageView]) {
        let mid = viewProfile.bounds.midX
        let max = viewProfile.bounds.maxX
        if imageViews.count == 1 {
            let value: CGFloat = 54
            imageViews[0].frame = CGRect(x: 0, y: 0, width: value, height: value)
        } else if imageViews.count == 2 {
            let value: CGFloat = 35
            imageViews[0].frame = CGRect(x: 0, y: 0, width: value, height: value)
            imageViews[1].frame = CGRect(x: max-value, y: max-value, width: value, height: value)
        } else if imageViews.count == 3 {
            let value: CGFloat = 30
            imageViews[0].frame = CGRect(x: 0, y: max-value, width: value, height: value)
            imageViews[1].frame = CGRect(x: max-value, y: max-value, width: value, height: value)
            imageViews[2].frame = CGRect(x: mid-value/2, y: 0, width: value, height: value)
        } else if imageViews.count == 4 {
            let value: CGFloat = 28
            imageViews[0].frame = CGRect(x: 0, y: 0, width: value, height: value)
            imageViews[1].frame = CGRect(x: max-value, y: 0, width: value, height: value)
            imageViews[2].frame = CGRect(x: 0, y: max-value, width: value, height: value)
            imageViews[3].frame = CGRect(x: max-value, y: max-value, width: value, height: value)
        }
    }
}

// 54 35 30 28
