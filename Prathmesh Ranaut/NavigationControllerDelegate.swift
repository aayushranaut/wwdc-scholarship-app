//
//  NavigationControllerDelegate.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/22/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationControllerOperation.Push
        {
            return CircleTransitionAnimator()
        }
        return nil;
    }
    
}
