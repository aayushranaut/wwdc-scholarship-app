//
//  PREducationPageContentViewController.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/24/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class PREducationPageContentViewController: UIViewController {
    
    var pageIndex : Int?
    
    @IBOutlet weak var collegeImage: UIImageView!
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var collegeYears: UILabel!
    
    var collegeImageString : String?
    var collegeNameString : String?
    var collegeYearString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.collegeImage.image = UIImage(named: collegeImageString!)
        self.collegeName.text = collegeNameString!
        self.collegeYears.text = collegeYearString!
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
