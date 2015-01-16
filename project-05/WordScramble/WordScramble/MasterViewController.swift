//
//  MasterViewController.swift
//  WordScramble
//
//  Created by Dulio Denis on 1/14/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [String]()
    var allWords = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let startWordsPath = NSBundle.mainBundle().pathForResource("start", ofType: "txt") {
            if let startWords = NSString(contentsOfFile: startWordsPath, usedEncoding: nil, error: nil) {
                allWords = startWords.componentsSeparatedByString("\n") as [String]
            }
        } else {
            allWords = ["silkworm"]
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "promptForAnswer")
        startGame()
    }
    
    func startGame() {
        allWords.shuffle()
        title = allWords[0]
        objects.removeAll(keepCapacity: true)
        tableView.reloadData()
    }
    
    func promptForAnswer() {
        let alertController = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler(nil)
        
        let submitAction = UIAlertAction(title: "Submit", style: .Default) { [unowned self, alertController] (action: UIAlertAction!) in
            let answer = alertController.textFields![0] as UITextField
            self.submitAnswer(answer.text)
        }
        
        alertController.addAction(submitAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func submitAnswer(answer: String) {
        let lowerAnswer = answer.lowercaseString
        if wordIsPossible(lowerAnswer) {
            if wordIsOriginal(lowerAnswer) {
                if wordIsReal(lowerAnswer) {
                    objects.insert(answer, atIndex: 0)
                    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                    tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                } else {
                    let alertController = UIAlertController(title: "Word not recognized", message: "You can't just make up words.", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    presentViewController(alertController, animated: true, completion: nil)
                }
            } else {
                let alertController = UIAlertController(title: "Duplicate detection", message: "You can't just use the same ones over again.", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                presentViewController(alertController, animated: true, completion: nil)
            }
        } else {
            let alertController = UIAlertController(title: "Word not possible", message: "You can't spell that word from '\(title!.lowercaseString)'.", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func wordIsPossible(word: String) -> Bool {
        var tempWord = title!.lowercaseString
        
        for letter in word {
            if let position = tempWord.rangeOfString(String(letter)) {
                if position.isEmpty {
                    return false
                } else {
                    tempWord.removeAtIndex(position.startIndex)
                }
            } else {
                return false
            }
        }
            return true
    }

    func wordIsOriginal(word: String) -> Bool {
        return !contains(objects, word)
    }
    
    func wordIsReal(word: NSString) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.length)
        
        let misspelledRange = checker.rangeOfMisspelledWordInString(word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let object = objects[indexPath.row]
        cell.textLabel.text = object
        return cell
    }

}

