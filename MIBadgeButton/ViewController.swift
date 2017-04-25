//
//  ViewController.swift
//  MIBadgeButton
//
//  Created by Yosemite on 8/27/14.
//  Copyright (c) 2014 Youxel Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var facebookButton: MIBadgeButton!
    @IBOutlet weak var twitterButton: MIBadgeButton!
    @IBOutlet weak var pinterestButton: MIBadgeButton!
    
    var customView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // - custom view (create UIView instance from .xib file)
        self.customView = CustomView.instanceFromNib()
        self.customView.configure()
        self.layoutCustomViewProgrammatically()
        
        // - direct usage via storyboard (drag and drop button into ViewController in Storyboard)
        facebookButton.badgeString = "19"
        facebookButton.badgeTextColor = UIColor.whiteColor()
        facebookButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 15)
        twitterButton.badgeString = "180"
        twitterButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 15)
        pinterestButton.badgeString = "22220"
        pinterestButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 15)
    }
    
    func layoutCustomViewProgrammatically() {
        self.view.addSubview(self.customView)
        
        // *important* set this to false to be able to manually programmatically layout it with constraints
        self.customView.translatesAutoresizingMaskIntoConstraints = false
        
        // customView gets full width equal to its parent's width
        let width = NSLayoutConstraint(item: self.customView, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0)
        // customView gets 10% height of its parent's height
        let height = NSLayoutConstraint(item: self.customView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 0.10, constant: 0)
        // center horizontally to its parent
        let centerH = NSLayoutConstraint(item: self.customView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0)
        // pin its bottom to the top of its direct facebook button with some offset
        let top = NSLayoutConstraint(item: self.customView, attribute: .Bottom, relatedBy: .Equal, toItem: self.facebookButton, attribute: .Top, multiplier: 1.0, constant: -30)
        
        self.view.addConstraints([width, height, centerH, top])
        self.view.layoutIfNeeded()
    }
}

