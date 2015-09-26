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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        facebookButton.badgeString = "19"
        facebookButton.badgeTextColor = UIColor.whiteColor()
//        facebookButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 15)
        twitterButton.badgeString = "180"
        twitterButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 15)
        pinterestButton.badgeString = "22220"
        pinterestButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 15)
    }

}

