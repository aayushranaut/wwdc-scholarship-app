//
//  AboutView.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/25/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class AboutView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var title: UILabel!
    
    var about: About? {
        didSet {
            imageView.image = about?.image
            summary.text = about?.summary ?? "No summary"
            title.text = about?.title ?? "Title"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        
        if about?.blur != nil {
            UIGraphicsBeginImageContext(self.frame.size)
            about!.blur!.drawInRect(self.bounds)
            var image :UIImage = UIGraphicsGetImageFromCurrentImageContext();
            
            self.backgroundColor = UIColor(patternImage: image.applyDarkEffect()!)
        }
    }
    
    override func alignmentRectForFrame(frame: CGRect) -> CGRect {
        return bounds
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        var effectView:UIVisualEffectView = UIVisualEffectView(effect: blur)
        
        effectView.frame = CGRectMake(0, 0, self.bounds.width, self.bounds.height)
        
        //self.insertSubview(effectView, atIndex:0)
    }
    

}
