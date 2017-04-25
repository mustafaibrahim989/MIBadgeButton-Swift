//
//  CustomView.swift
//  MIBadgeButton
//
//  Created by Wasin Thonkaew on 4/25/17.
//  Copyright © 2017 Youxel Technology. All rights reserved.
//

import Foundation
import UIKit

class CustomView : UIView {
    @IBOutlet weak var facebookButton: MIBadgeButton!
    @IBOutlet weak var twitterButton: MIBadgeButton!
    
    class func instanceFromNib() -> CustomView! {
        return NSBundle.mainBundle().loadNibNamed("CustomView", owner: nil, options: nil)![0] as! CustomView
    }
    
    func configure() {
        self.facebookButton.badgeString = "100"
        self.facebookButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 70)
        
        self.twitterButton.badgeString = "20000"
        self.twitterButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 55)
    }
}
