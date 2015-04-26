//
//  ViewController.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/20/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var previewView: UIView!
    
    let transitionManager: TransitionManager = TransitionManager()
    
    var appLabel: [String] = ["Projects", "Education", "About", "Interests"]
    var startColors: [UIColor] = [UIColor(red: 255.0/255.0, green: 184.0/255.0, blue: 32.0/255.0, alpha: 1.0),
        UIColor(red: 80.0/255.0, green: 202.0/255.0, blue: 1.0, alpha: 1.0),
        UIColor(red: 1.0, green: 157.0/255.0, blue: 212.0/255.0, alpha: 1.0),
        UIColor(red: 80.0/255.0, green: 202.0/255.0, blue: 1.0, alpha: 1.0)]
    
    var endColors: [UIColor] = [UIColor(red: 255.0/255.0, green: 106.0/255.0, blue: 31.0/255.0, alpha: 1.0),
        UIColor(red: 56.0/255.0, green: 161.0/255.0, blue: 1.0, alpha: 1.0),
        UIColor(red: 1.0, green: 92.0/255.0, blue: 187.0/255.0, alpha: 1.0),
        UIColor(red: 56.0/255.0, green: 161.0/255.0, blue: 1.0, alpha: 1.0)]
    
    var player : AVPlayer? = nil
    var playerLayer : AVPlayerLayer? = nil
    var asset : AVAsset? = nil
    var playerItem: AVPlayerItem? = nil
    
    var fileManager: NSFileManager = NSFileManager.defaultManager()
    var docsDir: String?
    var dataFile: String?
    var firstOpening: Int?
    
    var newView: UIView?
    
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

            if (self.navigationController?.visibleViewController .isKindOfClass(ViewController) != nil) {
                loadVideo()
            }
        }
    }
    
    func loadVideo() {
        println(NSBundle.mainBundle().URLForResource("timelapse_apple", withExtension: "m4v"))
        
        asset = AVAsset.assetWithURL(NSBundle.mainBundle().URLForResource("timelapse_apple", withExtension: "m4v")) as? AVAsset
        playerItem = AVPlayerItem(asset: asset)
        
        player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: self.player)
        playerLayer!.frame = view.frame
        
        newView = UIView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
        newView!.backgroundColor = UIColor.whiteColor()
        newView!.layer.addSublayer(self.playerLayer)
        self.view.addSubview(newView!)
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self,
            selector: "itemDidFinishPlaying:",
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: playerItem)
        
        player!.play()
    }
    
    override func viewDidDisappear(animated: Bool) {
    }
    
    func itemDidFinishPlaying(notifiation: NSNotification) {
        //Log
        println("finished playing vid..")
        
        if newView != nil {
            print("Removing the view")
            
//            UIView.animateWithDuration(2, delay: 0.5, options: UIViewAnimationCurve.EaseIn, animations: {
//                self.newView!.alpha = 0
//                var scaleTransform = CGAffineTransformMakeScale(0.1, 0.1)
//                
//                self.newView!.transform = scaleTransform
//
//                }, completion: { _ in
//                    self.newView!.removeFromSuperview()
//            })
            
            UIView.animateWithDuration(1.0, animations: {
                    self.newView!.alpha = 0
                    var scaleTransform = CGAffineTransformMakeScale(0.1, 0.1)

                    self.newView!.transform = scaleTransform
                }, completion: { _ in
                    self.newView!.removeFromSuperview()
            })
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
                let vc: PREducationViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PREducationViewController") as! PREducationViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
                break;
            
            case 2:
                UIGraphicsBeginImageContext(self.view.bounds.size)
                self.view.drawViewHierarchyInRect(self.view.bounds, afterScreenUpdates: false)
                var blurImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                presentAboutViews([
                    About(image: UIImage(named: "aayush.png"), summary: "Hi, I am Prathmesh Ranaut! I am 18 year old Computer Science Major living in India. I am currently a freshman at college. I started programming when I was 12 and iOS played a very important role in getting me started.", title: "About Me", blur: blurImg),
                    About(image:UIImage(named: "swiftlogo.png"), summary:"Objective-C, Swift, C/C++, Java, Python, Ruby, HTML5, CSS3, PHP, SQL, Javascript", title: "Languages", blur: blurImg),
                    ],
                    animated: true, completion: nil)
                
            break;
            case 3:
//                let vc: PRInterestsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PRInterestsViewController") as! PRInterestsViewController
//                
//                self.navigationController?.pushViewController(vc, animated: true)
//                
            
                UIGraphicsBeginImageContext(self.view.bounds.size)
                self.view.drawViewHierarchyInRect(self.view.bounds, afterScreenUpdates: false)
                var blurImg: UIImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                presentAboutViews([
                    About(image: UIImage(named: "basketball-icon.png"),
                        summary: "I love playing basketball. I even follow NBA. Miami Heat is my favorite NBA team.",
                        title: "Basketball", blur: blurImg),
                    About(image:UIImage(named: "ic_music.png"),
                        summary:"Like Apple, I am also a big fan of music. I always put on the iTunes Pop charts on the iTunes Radio while coding.",
                        title: "Music", blur: blurImg),
                    About(image:UIImage(named: "apple_mbp.png"),
                        summary:"Despite my busy schedule, I sometimes get time to play games on my Macbook Pro Retina. Some of the titles I like are GTA 5, Assasins Creed, DIRT 3.",
                        title: "Gaming", blur: blurImg),
                    ],
                    animated: true, completion: nil)
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

