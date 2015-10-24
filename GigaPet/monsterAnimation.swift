//
//  monsterAnimation.swift
//  GigaPet
//
//  Created by muratcakmak on 24/10/15.
//  Copyright © 2015 Murat Cakmak. All rights reserved.
//

import Foundation
import UIKit

class monsterAnimation: UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startIdleAnimation()
    }
    
    func startIdleAnimation () {
        self.image = UIImage(named: "idle1.png")
        
        var animationImages = [UIImage]()
        
        var image: UIImage?
        for var i = 1; i < 5; i+=1{
            let image = UIImage(named: "idle\(i).png")
            animationImages.append(image!)
        }
        
        self.animationImages = animationImages
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    
    }
    func startDeathAnimation(){
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil
        
        
        var animationImages = [UIImage]()
        
        var image: UIImage?
        for var i = 1; i < 6; i+=1{
            let image = UIImage(named: "dead\(i).png")
            animationImages.append(image!)
        }
        
        self.animationImages = animationImages
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    
    }
}