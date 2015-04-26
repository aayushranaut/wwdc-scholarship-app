//
//  PRProjectsViewController.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/22/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class PRProjectsViewController: ViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let appNames = ["iBounce", "Tiki Totems", "LiquidServe", "Hype Ninja", "Flying Ducks", "SEO Checkout", "Spillit", "Skooter"]
    var appIcons = ["project_icon2.png","project_8.png","project3.png","hypeninja.png", "flying_ducks.png", "seocheckout.png", "spillit.jpg", "project_7.png"]
    var appYears = ["2011", "2012", "2012", "2013", "2014", "2014", "2014", "2015"]
    var appDescription = ["My first ever game which I built in 9th, so years after I started programming. It was built entirely in Objective-C using native technologies only. This was similar to the way Papi jump worked. Being a ball you had to dodge evil characters and move upwards infitely and gain as many points as possible.",
        
        "My second game, built using Cocos2D framework and Box2D physics engine. It used OpenFient for social gaming because GameCenter wasn't available at that time. The aim of the game was to make the tiki totem land on a particular block while removing all the superfluous block. ",
        
        "This was my first attempt of breaking into the web development arena. This project taught me how to manage servers. It exposed me to security issues on the web for the first time.",
        
        "Hype Ninja is a web app which allows the users to monitor keywords on popular social network as well as popular blogs on the internet. This automated system parsed feeds from Twitter, Facebook and blogs found on search engine and allowed the users to reply on items in the feed from within the Hype Ninja's admin panel using APIs. It enabled its users to do effective & targeted marketing.",
        
        "One of my weekends project, this game was my first encounter with SpriteKit, this is similar to the popular iOS game Flappy Bird. It utilized the UIDynamicAnimator APIs released with iOS 7 along with SpriteKit to build the entire game.",
        
        "SEO Checkout was a professional project. It is a web based affiliate management and sales portal built for a company. This project exposed me to complex algorithms and optimizations scenarios. The website has over 10 million hits since it's inception.",
    
        "Spillit.me is a social network popular in UK with over 700,000 users. I worked on modernizing the PHP backend. I also created an API which powered the Spillit iOS App.",
        
        "Skooter is a hyper-local bulletin board app which allows people to communicate anonymously. I built the android app due to larger market share of android in India. The response has been tremendous and the people are requesting for the iOS app. I am currently working on it and it should be released in the next few months."]
    var count = 0
    
    var pageViewController : UIPageViewController!
    
    @IBAction func swipeLeft(sender: AnyObject) {
        println("Swipe Left")
    }
    
    @IBAction func swiped(sender: AnyObject) {
        self.pageViewController.view.removeFromSuperview()
        self.pageViewController.removeFromParentViewController()
        reset()
    }
    
    func reset() {
        /* Getting the page View controller */
        pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        
        let pageContentViewController = self.viewControllerAtIndex(0)
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        /* We are substracting 30 because we have a start again button whose height is 30*/
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 30)
        self.addChildViewController(pageViewController)
        self.view.addSubview(pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    @IBAction func start(sender: AnyObject) {
        let pageContentViewController = self.viewControllerAtIndex(0)
        self.pageViewController.setViewControllers([pageContentViewController!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageContentViewController).pageIndex!
        index++
        if(index >= self.appIcons.count){
            return nil
        }
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageContentViewController).pageIndex!
        if(index <= 0){
            return nil
        }
        index--
        return self.viewControllerAtIndex(index)
        
    }
    
    func viewControllerAtIndex(index : Int) -> UIViewController? {
        if((self.appNames.count == 0) || (index >= self.appNames.count)) {
            return nil
        }
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
        
        pageContentViewController.pageIndex = index
        
        pageContentViewController.appNameString = self.appNames[index]
        pageContentViewController.appIconString = self.appIcons[index]
        pageContentViewController.appYearString = self.appYears[index]
        pageContentViewController.appDescriptionString = self.appDescription[index]
        
        var leftRightMin: CGFloat = -15.0
        var leftRightMax: CGFloat = 15.0
        var leftRight: UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: UIInterpolatingMotionEffectType.TiltAlongHorizontalAxis)
        
        var topBottom: UIInterpolatingMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: UIInterpolatingMotionEffectType.TiltAlongVerticalAxis)
        
        leftRight.minimumRelativeValue = leftRightMin
        leftRight.maximumRelativeValue = leftRightMax
        
        topBottom.minimumRelativeValue = leftRightMin
        topBottom.maximumRelativeValue = leftRightMax
        
        var meGroup: UIMotionEffectGroup = UIMotionEffectGroup()
        meGroup.motionEffects = [leftRight, topBottom]
        
        pageContentViewController.view.addMotionEffect(meGroup)
        
        
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return appNames.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
   
   override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
      
        reset()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        UIImage(named: "iphone-wallpapers-32.jpg")!.drawInRect(self.view.bounds)
        var image :UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.view.backgroundColor = UIColor(patternImage: image.applyLightEffect()!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
