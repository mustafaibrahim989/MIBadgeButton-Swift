//
//  ViewController.swift
//  MIBadgeButton
//
//  Created by Yosemite on 8/27/14.
//  Copyright (c) 2014 Youxel Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var facebookButton: MIBadgeButton!
    @IBOutlet var twitterButton: MIBadgeButton!
    @IBOutlet var pinterestButton: MIBadgeButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var colorsArray = [UIColor.flatOrangeColor(), UIColor.flatRedColor()]
        
        var rect: CGRect = self.view.bounds
        
        rect.size.height - 500
        
        self.view.backgroundColor = UIColor(gradientStyle: .TopToBottom, withFrame: rect, andColors: colorsArray)
        
        self.facebookButton.badgeString = "120"
        self.facebookButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 15)
        self.twitterButton.badgeString = "80"
        self.twitterButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 15)
        self.pinterestButton.badgeString = "20"
        self.pinterestButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 15)
    }

}

