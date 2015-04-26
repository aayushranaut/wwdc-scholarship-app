//
//  AboutViewController.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/25/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    private let kAboutViewHeight: CGFloat = 400
    private let kAboutViewWidth: CGFloat = 300
    var aboutView: AboutView!
    var animator: UIDynamicAnimator!
    var attachmentBehaviour: UIAttachmentBehavior!
    var snapBehaviour: UISnapBehavior!
    var panBehaviour: UIAttachmentBehavior!
    var aboutViews = [About]()
    var aboutIndex = 0
    
    private let kAboutViewOffset: CGFloat = 500
    
    enum AboutViewPosition: Int  {
        case Default
        case RotatedLeft
        case RotatedRight
        
        func viewCenter(var center: CGPoint) -> CGPoint {
            switch self {
            case .RotatedLeft:
                center.y += 500
                center.x -= 500
                
            case .RotatedRight:
                center.y += 500
                center.x += 500
                
            default:
                ()
            }
            return center
        }
        
        func viewTransform() -> CGAffineTransform {
            switch self {
            case .RotatedLeft:
                return CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
                
            case .RotatedRight:
                return CGAffineTransformMakeRotation(CGFloat(M_PI_2))
                
            default:
                return CGAffineTransformIdentity
            }
        }
    }
    
    func updateAboutView(aboutView: UIView, position: AboutViewPosition) {
        var center = CGPoint(x: CGRectGetWidth(view.bounds)/2, y: CGRectGetHeight(view.bounds)/2)
        aboutView.center = position.viewCenter(center)
        aboutView.transform = position.viewTransform()
    }

    func resetAboutView(aboutView: UIView, position: AboutViewPosition) {
        animator.removeAllBehaviors()
        
        updateAboutView(aboutView, position: position)
        animator.updateItemUsingCurrentState(aboutView)
        
        animator.addBehavior(attachmentBehaviour)
        animator.addBehavior(snapBehaviour)
    }
    
    func panAboutView(pan: UIPanGestureRecognizer) {
        let location = pan.locationInView(view)
        
        switch pan.state {
        case .Began:
            animator.removeBehavior(snapBehaviour)
            panBehaviour = UIAttachmentBehavior(item: aboutView, attachedToAnchor: location)
            animator.addBehavior(panBehaviour)
            
        case .Changed:
            var nextIndex = self.aboutIndex
            var position = AboutViewPosition.RotatedRight
            var nextPosition = AboutViewPosition.RotatedLeft
            let center = CGPoint(x: CGRectGetWidth(view.bounds)/2, y: CGRectGetHeight(view.bounds)/2)
            let offset = location.x - center.x
            
            if offset > 0 {
                nextIndex -= 1
                nextPosition = .RotatedLeft
                position = .RotatedRight
            }
            else {
                nextIndex += 1
                nextPosition = .RotatedRight
                position = .RotatedLeft
            }
            
            if nextIndex < 0 {
                nextIndex = 0
                nextPosition = .RotatedRight
            }
            
            let duration = 0.4
            
            panBehaviour.anchorPoint = position.viewCenter(center)
            
            dispatch_after(dispatch_time( DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                [self]
                if nextIndex >= self.aboutViews.count {
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.aboutIndex = nextIndex
                    self.setupAboutView(self.aboutView, index:nextIndex)
                    self.resetAboutView(self.aboutView, position: nextPosition)
                }
            }
            
        case .Ended:
            fallthrough
            
        case .Cancelled:
            let center = CGPoint(x: CGRectGetWidth(view.bounds)/2, y: CGRectGetHeight(view.bounds)/2)
            let offset = location.x - center.x
            if fabs(offset) < 100 {
                animator.removeBehavior(panBehaviour)
                animator.addBehavior(snapBehaviour)
            }
            else {
                let position = offset > 0 ? AboutViewPosition.RotatedRight : AboutViewPosition.RotatedLeft
                let nextPosition = offset > 0 ? AboutViewPosition.RotatedLeft : AboutViewPosition.RotatedRight
                let duration = 0.4
                
                let center = CGPoint(x: CGRectGetWidth(view.bounds) / 2, y: CGRectGetHeight(view.bounds) / 2)
                
                panBehaviour.anchorPoint = position.viewCenter(center)
                dispatch_after(dispatch_time( DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
                    [self]
                    self.resetAboutView(self.aboutView, position: nextPosition)
                }
            }
        default:
            ()
        }
    }
    
    func setupAboutView(aboutView: AboutView, index: Int) {
        if index < aboutViews.count {
            let about = aboutViews[index]
            aboutView.about = about
            
            aboutView.pageControl.numberOfPages = aboutViews.count
            aboutView.pageControl.currentPage = index
        } else {
            aboutView.about = nil
        }
    }
    
    func setupAnimator() {
        animator = UIDynamicAnimator(referenceView: view)
        
        var center = CGPoint(x: CGRectGetWidth(view.bounds) / 2, y: CGRectGetHeight(view.bounds)/2)
        
        aboutView = createAboutView()
        
        view.addSubview(aboutView)
        snapBehaviour = UISnapBehavior(item: aboutView, snapToPoint: center)
        
        center.y += kAboutViewOffset
        attachmentBehaviour = UIAttachmentBehavior(item: aboutView, offsetFromCenter: UIOffset(horizontal: 0, vertical: kAboutViewOffset), attachedToAnchor: center)
        
        setupAboutView(aboutView, index: 0)
        resetAboutView(aboutView, position: .RotatedRight)
        
        let pan = UIPanGestureRecognizer(target: self, action: "panAboutView:")
        view.addGestureRecognizer(pan)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimator()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createAboutView() -> AboutView? {
        if let view = UINib(nibName: "AboutView", bundle: nil).instantiateWithOwner(nil, options: nil).first as! AboutView? {
            view.frame = CGRect(x: 0, y: 0, width: kAboutViewWidth, height: kAboutViewHeight)
            return view
        }
        return nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    func presentAboutViews(aboutViews: [About], animated: Bool, completion: (() -> Void)?) {
        let controller : AboutViewController! = AboutViewController()
        
        controller.aboutViews = aboutViews
        controller.modalPresentationStyle = .OverFullScreen
        controller.modalTransitionStyle = .CrossDissolve
        
        presentViewController(controller, animated: animated, completion: completion)
    }
}