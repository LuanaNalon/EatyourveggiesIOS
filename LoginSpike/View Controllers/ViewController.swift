//
//  ViewController.swift
//  LoginSpike
//
//  Created by Luana Nalon on 27/11/2020.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var singUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    override func viewWillAppear(_ animated: Bool) {
        //    set up video on the background
        setUpVideo()
    }
    func setUpElements(){
        if(singUpButton != nil) {
            Utilities.styleFilledButton(singUpButton)
        }
        if(loginButton != nil) {
            Utilities.styleFilledButton(loginButton)
        }
    }
    func setUpVideo(){
        //        get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "veggies", ofType: "mp4")
        guard bundlePath != nil else {
            return
        }
        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // Create the video player item
        let item = AVPlayerItem(url: url)
        
        // Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.3)
    }
    
}

