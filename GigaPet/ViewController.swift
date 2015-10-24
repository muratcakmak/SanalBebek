//
//  ViewController.swift
//  GigaPet
//
//  Created by muratcakmak on 24/10/15.
//  Copyright © 2015 Murat Cakmak. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var faultImg1: UIImageView!
    @IBOutlet weak var faultImg2: UIImageView!
    @IBOutlet weak var faultImg3: UIImageView!
    
    @IBOutlet weak var livesPanelImage: UIImageView!
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_FAULT = 3
    
    var faults = 0
    
    var timer: NSTimer!
    var isHappy: Bool! = false
    var currentItem: UInt32!
    
    @IBOutlet weak var monsterImage: monsterAnimation!
    @IBOutlet weak var foodImage: dragImage!
    @IBOutlet weak var heartImage: dragImage!

    @IBOutlet weak var restartButton: UIButton!
    var musicPlayer : AVAudioPlayer!
    var sfxBite : AVAudioPlayer!
    var sfxDeath : AVAudioPlayer!
    var sfxHeart : AVAudioPlayer!
    var sfxSkull : AVAudioPlayer!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        foodImage.dropTarget = monsterImage
        heartImage.dropTarget = monsterImage
        
        faultImg1.alpha = DIM_ALPHA
        faultImg2.alpha = DIM_ALPHA
        faultImg3.alpha = DIM_ALPHA
        
        startTimer()
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
        }catch let err as NSError{
            print("\(err)")
        }
        
        musicPlayer.play()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnCharacter:", name: "onTargetDropped", object: nil)

    }
    func itemDroppedOnCharacter(notif: AnyObject){
        sfxBite.play()
        isHappy = true
        startTimer()
        foodImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        heartImage.alpha = DIM_ALPHA
        heartImage.userInteractionEnabled = false
        
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeSkulls", userInfo: nil, repeats: true)
        }
    func changeSkulls(){
        if !isHappy {
        
            faults++
            sfxSkull.play()
            
            if faults == 1 {
                faultImg1.alpha = OPAQUE
            }else if faults == 2 {
                faultImg2.alpha = OPAQUE
            }else if faults == 3{
                faultImg3.alpha = OPAQUE
            }
            
            if faults >= MAX_FAULT {
                gameOver()
            }
        
        }

        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
            
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
            sfxHeart.play()
        }
        else {
            foodImage.alpha = DIM_ALPHA
            foodImage.userInteractionEnabled = false
            
            heartImage.alpha = OPAQUE
            heartImage.userInteractionEnabled = true
            sfxHeart.play()
        }
        isHappy = false
        currentItem = rand
    }
    
    func gameOver(){
        sfxDeath.play()
        timer.invalidate()
        monsterImage.startDeathAnimation()
        restartGameWaiting()
    }
    func restartGameWaiting(){
        if timer != nil {
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(1.7, target: self, selector: "showRestartGameButton", userInfo: nil, repeats: true)
    }
    
    
    
    func showRestartGameButton(){
        restartButton.hidden = false
        monsterImage.hidden = true
        faultImg1.hidden = true
        faultImg2.hidden = true
        faultImg3.hidden = true
        heartImage.hidden = true
        foodImage.hidden = true
    
    }
    @IBAction func restartGame(sender: AnyObject) {
        restartButton.hidden = true
        monsterImage.hidden = false
        faultImg1.hidden = false
        faultImg2.hidden = false
        faultImg3.hidden = false
        heartImage.hidden = false
        foodImage.hidden = false
        faults = 0
        monsterImage.startIdleAnimation()
        viewDidLoad()

    }
}

