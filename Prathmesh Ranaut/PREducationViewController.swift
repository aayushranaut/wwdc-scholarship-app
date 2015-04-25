//
//  PREducationViewController.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/24/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class PREducationViewController: ViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let name = ["Apeejay School", "Ambience Public School", "Indraprastha University"]
    let institutionLogo = ["apeejay.png", "ambience.jpg", "ipu.png"]
    let years = ["1998 - 2012", "2012-2014", "2014-2018"]
    var count = 0
    
    var pageViewController : UIPageViewController!
    
    @IBAction func swipeLeft(sender: AnyObject) {
        println("Swipe left")
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
        
        var index = (viewController as! PREducationPageContentViewController).pageIndex!
        index++
        if(index >= self.name.count){
            return nil
        }
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PREducationPageContentViewController).pageIndex!
        if(index <= 0){
            return nil
        }
        index--
        return self.viewControllerAtIndex(index)
        
    }
    
    func viewControllerAtIndex(index : Int) -> UIViewController? {
        if((self.name.count == 0) || (index >= self.name.count)) {
            return nil
        }
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PREducationPageContentViewController") as! PREducationPageContentViewController
        
        pageContentViewController.pageIndex = index
        pageContentViewController.collegeNameString = name[index]
        pageContentViewController.collegeImageString = institutionLogo[index]
        pageContentViewController.collegeYearString = years[index]
        
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return name.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        reset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "pwc-building.jpg")!.drawInRect(self.view.bounds)
        var image :UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.view.backgroundColor = UIColor(patternImage: image)
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
