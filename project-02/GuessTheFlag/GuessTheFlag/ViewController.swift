//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Dulio Denis on 1/9/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flag1: UIButton!
    @IBOutlet weak var flag2: UIButton!
    @IBOutlet weak var flag3: UIButton!
    
    // Array of Countries
    var countries = [String]()
    // user's score
    var score = 0
    // the correct answer
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a border to the flags for flags with White
        flag1.layer.borderWidth = 1
        flag2.layer.borderWidth = 1
        flag3.layer.borderWidth = 1
        
        countries += ["afghanistan", "belgium", "colombia", "estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func askQuestion(action:UIAlertAction! = nil) {
        countries.shuffle()
        flag1.setImage(UIImage(named: countries[0]), forState: .Normal)
        flag2.setImage(UIImage(named: countries[1]), forState: .Normal)
        flag3.setImage(UIImage(named: countries[2]), forState: .Normal)
        
        correctAnswer = Int(arc4random_uniform(3))
        title = countries[correctAnswer].uppercaseString
    }
    
    @IBAction func flagTapped(sender: UIButton) {
        var messageTitle: String
        if sender.tag == correctAnswer {
            messageTitle = "Correct"
            ++score
        } else {
            messageTitle = "Wrong"
            --score
        }
        
        let messageText = "Your score is \(score)"
        
        let alertController = UIAlertController(title: messageTitle, message: messageText, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    

}

