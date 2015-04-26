//
//  PRProjectView.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/22/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

@IBDesignable class PRProjectView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    
    override func drawRect(rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        var effectView:UIVisualEffectView = UIVisualEffectView(effect: blur)
        
        effectView.frame = CGRectMake(0, 0, self.bounds.width, self.bounds.height)
        
        self.insertSubview(effectView, atIndex:0)
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }
    
    override func alignmentRectForFrame(frame: CGRect) -> CGRect {
        return bounds
    }
}