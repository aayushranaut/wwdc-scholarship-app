//
//  PRProjectsViewController.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/22/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class PRProjectsViewController: ViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    let appNames = ["iBounce", "Tiki Totems", "LiquidServe", "Hype Ninja", "Flying Ducks", "SEO Checkout"]
    var appIcons = ["project_icon2.png","project3.png","project3.png","hypeninja.png", "flying_ducks.png", "seocheckout.png"]
    var appYears = ["2011", "2012", "2012", "2013", "2014", "2015"]
    var appDescription = ["My first ever game which I built in 9th, so years after I started programming. It was built entirely in Objective-C using native technologies only. This was similar to the way Papi jump worked. Being a ball you had to dodge evil characters and move upwards infitely and gain as many points as possible.",
                          "My second game",
                          "Lorem ipsum text",
                          "Lorem ipsum text",
                          "Lorem ipsum text",
                          "Lorem ipsum text"]
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
//        UIGraphicsBeginImageContext(self.view.frame.size)
//        UIImage(named: "547561.png").drawInRect(self.view.bounds)
//        var image :UIImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        self.view.backgroundColor = UIColor(patternImage: image)
        
        reset()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "547561.png")!.drawInRect(self.view.bounds)
        var image :UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.view.backgroundColor = UIColor(patternImage: image)
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
