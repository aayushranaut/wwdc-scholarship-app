//
//  CircleTransitionAnimator.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/22/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        var container = transitionContext.containerView()
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! ViewController
        var profileImageView = fromViewController.profileImageView
        
        container.addSubview(toViewController.view)
        
        if profileImageView != nil {
            var circleMaskPathInitial = UIBezierPath(ovalInRect: profileImageView.frame)
            var extremePoint = CGPoint(x: profileImageView.center.x, y: profileImageView.center.y + CGRectGetHeight(toViewController.view.bounds))
            var radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
            var circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(profileImageView.frame, -radius, -radius))
            
            var maskLayer = CAShapeLayer()
            maskLayer.path = circleMaskPathFinal.CGPath
            toViewController.view.layer.mask = maskLayer
            
            var maskLayerAnimation = CABasicAnimation(keyPath: "path")
            maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
            maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
            maskLayerAnimation.duration = self.transitionDuration(transitionContext)
            maskLayerAnimation.delegate = self
            maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
        }
        else {
            self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
        }
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
        self.transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }
}
