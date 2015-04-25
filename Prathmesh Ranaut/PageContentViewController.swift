//
//  PageContentViewController.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/23/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    var pageIndex : Int?
    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appYear: UILabel!
    @IBOutlet weak var appDescription: UILabel!
    
    var appIconString : String?
    var appNameString : String?
    var appYearString : String?
    var appDescriptionString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.appDescription.preferredMaxLayoutWidth = self.view.frame.width - 60.0
        
        self.appIcon.image = UIImage(named: appIconString!)
        self.appName.text = appNameString!
        self.appDescription.text = appDescriptionString!
        self.appYear.text = appYearString!
        
        self.appIcon.layer.cornerRadius = 14.0
        self.appIcon.clipsToBounds = true
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
