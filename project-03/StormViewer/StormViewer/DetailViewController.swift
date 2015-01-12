//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Dulio Denis on 1/9/15.
//  Copyright (c) 2015 ddApps. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!

    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let imageView = detailImageView {
                imageView.image = UIImage(named: detail)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareTap")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - Share Method
    
    func shareTap() {
// UIActivityViewController based solution
//      let activity = UIActivityViewController(activityItems: [detailImageView.image!], applicationActivities: [])
//      presentViewController(activity, animated: true, completion: nil)
        
// SLComposeViewController Social Framework based solution
        let social = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        social.setInitialText("Photo from the National Oceanic and Atmospheric Administration's internationally-known Environmental Research Laboratories")
        social.addImage(detailImageView.image!)
        social.addURL(NSURL(string: "http://www.photolib.noaa.gov/nssl/"))
        presentViewController(social, animated: true, completion: nil)
    }
}