//
//  MainViewController.swift
//  Prathmesh Ranaut
//
//  Created by Aayush Ranaut on 4/26/15.
//  Copyright (c) 2015 Prathmesh Ranaut. All rights reserved.
//

import UIKit
import AVFoundation

class MainViewController: UIViewController {
    
    var player : AVPlayer? = nil
    var playerLayer : AVPlayerLayer? = nil
    var asset : AVAsset? = nil
    var playerItem: AVPlayerItem? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                println(NSBundle.mainBundle().URLForResource("timelapse_apple", withExtension: "m4v"))
        
                asset = AVAsset.assetWithURL(NSBundle.mainBundle().URLForResource("timelapse_apple", withExtension: "m4v")) as? AVAsset
                playerItem = AVPlayerItem(asset: asset)
        
                player = AVPlayer(playerItem: playerItem)
                playerLayer = AVPlayerLayer(player: self.player)
                playerLayer!.frame = view.frame
                self.view.layer.addSublayer(self.playerLayer)
        
                let notificationCenter = NSNotificationCenter.defaultCenter()
                notificationCenter.addObserver(self,
                    selector: "itemDidFinishPlaying:",
                    name: AVPlayerItemDidPlayToEndTimeNotification,
                    object: playerItem)
                
                player!.play()
    }
    
    func itemDidFinishPlaying(notifiation: NSNotification) {
        //Log
        println("Item playing finished")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
