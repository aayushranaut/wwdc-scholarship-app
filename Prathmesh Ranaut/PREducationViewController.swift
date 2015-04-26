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
    
    @IBOutlet weak var im1: UIImageView!
    @IBOutlet weak var im2: UIImageView!
    @IBOutlet weak var im3: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //reset()
        label1.text = years[0]
        label2.text = years[1]
        label3.text = years[2]
        
        UIView.animateWithDuration(1, animations: {
            self.im1.alpha = 1.0
            self.im2.alpha = 1.0
            self.im3.alpha = 1.0
        })
        
        UIView.animateWithDuration(2.0, animations: {
            var transalation = CGAffineTransformMakeTranslation(0, -60)
            self.im1.transform = transalation
//            self.im2.transform = transalation
//            self.im3.transform = transalation
            self.label1.transform = transalation
//            self.label2.transform = transalation
//            self.label3.transform = transalation
        })
        
        UIView.animateWithDuration(3.0, animations: {
            var transalation = CGAffineTransformMakeTranslation(0, -60)
            self.im2.transform = transalation
            self.label2.transform = transalation
        })
        
        UIView.animateWithDuration(4.0, animations: {
            var transalation = CGAffineTransformMakeTranslation(0, -60)
            self.im3.transform = transalation
            self.label3.transform = transalation
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "education-back.jpg")!.drawInRect(self.view.bounds)
        var image :UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.view.backgroundColor = UIColor(patternImage: image.applyBlurWithRadius(10, tintColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.1), saturationDeltaFactor: 0.6, maskImage: nil)!)
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
