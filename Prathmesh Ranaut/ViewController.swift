//
//  ViewController.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/20/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var previewView: UIView!
    
    let transitionManager: TransitionManager = TransitionManager()
    
    var appLabel: [String] = ["Projects", "Interests", "About", "Education"]
    var startColors: [UIColor] = [UIColor(red: 255.0/255.0, green: 184.0/255.0, blue: 32.0/255.0, alpha: 1.0),
        UIColor(red: 80.0/255.0, green: 202.0/255.0, blue: 1.0, alpha: 1.0),
        UIColor(red: 1.0, green: 157.0/255.0, blue: 212.0/255.0, alpha: 1.0),
        UIColor(red: 80.0/255.0, green: 202.0/255.0, blue: 1.0, alpha: 1.0)]
    
    var endColors: [UIColor] = [UIColor(red: 255.0/255.0, green: 106.0/255.0, blue: 31.0/255.0, alpha: 1.0),
        UIColor(red: 56.0/255.0, green: 161.0/255.0, blue: 1.0, alpha: 1.0),
        UIColor(red: 1.0, green: 92.0/255.0, blue: 187.0/255.0, alpha: 1.0),
        UIColor(red: 56.0/255.0, green: 161.0/255.0, blue: 1.0, alpha: 1.0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if self.profileImageView != nil {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
            self.profileImageView.clipsToBounds = true
            
            UIView.animateWithDuration(1.2, delay: 0.0,
                options: UIViewAnimationOptions.CurveEaseOut,
                animations: {
                    let scaleTranslation = CGAffineTransformMakeScale(2.0, 2.0)
                    
                    let tranlateTransalation = CGAffineTransformMakeTranslation(0, -80)
                    
                    self.profileImageView.alpha = 1.0;
                    self.profileImageView!.transform = CGAffineTransformConcat(scaleTranslation, tranlateTransalation)
                    self.nameLabel!.transform = tranlateTransalation
                    self.nameLabel.alpha = 1.0
                },
                completion: nil)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appLabel.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: PRCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("PRCell", forIndexPath: indexPath) as! PRCollectionViewCell
        
        cell.cellView.startColor = startColors[indexPath.row]
        cell.cellView.endColor = endColors[indexPath.row]
        
        UIView.animateWithDuration(0.5, animations: {
            cell.labelApp.alpha = 1.0
            cell.cellView.alpha = 1.0
            cell.imageApp.alpha = 1.0
            cell.cellView.transform = CGAffineTransformMakeScale(2.0, 2.0)
        })
        
        cell.labelApp.text = appLabel[indexPath.row]
        cell.imageApp.image = UIImage(named: "project_icon")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell \(indexPath.row) selected")
        
        switch indexPath.row {
            case 0:
                let vc: PRProjectsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PRProjectsViewController") as! PRProjectsViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break;
            case 1:
                let vc: PRInterestsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PRInterestsViewController") as! PRInterestsViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
                break;
            
            case 3:
                let vc: PREducationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PREducationViewController") as! PREducationViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
                break;
            default:
                break;
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PRProjectsViewController" {
            println("Preparing for segue")
            let toViewController = segue.destinationViewController as! UIViewController
            toViewController.transitioningDelegate = self.transitionManager
        }
        println("Preparing for segue")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

