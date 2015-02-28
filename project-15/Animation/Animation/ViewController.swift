//
//  ViewController.swift
//  Animation
//
//  Created by Dulio Denis on 2/27/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentAnimation = 0
    var imageView: UIImageView!
    @IBOutlet weak var tapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }

    @IBAction func tapped(sender: AnyObject) {
        tapButton.hidden = true
        
//        UIView.animateWithDuration(1, delay: 0, options: .allZeros,
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .allZeros,
            animations: { [unowned self] in
                switch self.currentAnimation {
                case 0:
                    self.imageView.transform = CGAffineTransformMakeScale(2, 2)
                    
                case 1:
                    self.imageView.transform = CGAffineTransformIdentity
                    
                case 2:
                    self.imageView.transform = CGAffineTransformMakeTranslation(-256, -256)
                    
                case 3:
                    self.imageView.transform = CGAffineTransformIdentity
                    
                case 4:
                    self.imageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
                    
                case 5:
                    self.imageView.transform = CGAffineTransformIdentity
                    
                case 6:
                    self.imageView.alpha = 0.1
                    self.imageView.backgroundColor = UIColor.greenColor()
                    
                case 7:
                    self.imageView.alpha = 1
                    self.imageView.backgroundColor = UIColor.clearColor()
                    
                default:
                    break
                }
            }) { [unowned self] (finished:Bool) in
                self.tapButton.hidden = false
        }
        
        ++currentAnimation
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }

}

