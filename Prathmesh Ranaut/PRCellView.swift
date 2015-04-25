//
//  PRCellView.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/20/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

@IBDesignable class PRCellView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    
    // 1 - the properties for the gradient
    @IBInspectable var startColor: UIColor = UIColor.redColor()
    @IBInspectable var endColor: UIColor = UIColor.greenColor()
    
    override func drawRect(rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        // set up the background clipping area
        var path = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: UIRectCorner.AllCorners,
                                    cornerRadii: CGSize(width: 8.0, height: 8.0))
        
        path.addClip()
        
        // 2 - get the current context
        let context = UIGraphicsGetCurrentContext()
        let colors:CFArray = [startColor.CGColor, endColor.CGColor]
        
        // 3 - setup the color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4- Setup the color stops
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        // 5- create the gradient
        let gradient = CGGradientCreateWithColors(colorSpace,
                                                  colors,
                                                  colorLocations)
        
        // 6- draw the gradient
        var startPoint = CGPoint.zeroPoint
        var endPoint = CGPoint(x:0, y:self.bounds.height)
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    startPoint,
                                    endPoint,
                                    0)
    }

}
