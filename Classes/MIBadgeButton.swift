//
//  MIBadgeButton.swift
//  MIBadgeButton
//
//  Created by Yosemite on 8/27/14.
//  Copyright (c) 2014 Youxel Technology. All rights reserved.
//

import UIKit

class MIBadgeButton: UIButton {
    
    var calculationTextView: UITextView
    var badgeLabel: UILabel
    var badgeString: NSString? {
    didSet {
        self.setupBadgeViewWithString(badgeText: badgeString)
    }
    }
    var badgeEdgeInsets: UIEdgeInsets? {
    didSet {
       self.setupBadgeViewWithString(badgeText: badgeString)
    }
    }

    override init(frame: CGRect) {
        calculationTextView = UITextView()
        badgeLabel = MIBadgeLabel(frame: CGRectMake(0, 0, 10, 10))
        super.init(frame: frame)
        // Initialization code
        self.setupBadgeViewWithString(badgeText: "")
    }
    
    required init(coder aDecoder: NSCoder!) {
        calculationTextView = UITextView()
        badgeLabel = MIBadgeLabel(frame: CGRectMake(0, 0, 10, 10))
        super.init(coder: aDecoder)
        self.setupBadgeViewWithString(badgeText: "")
    }
    
    func initWithFrame(#frame: CGRect, withBadgeString badgeString: NSString, withBadgeInsets badgeInsets: UIEdgeInsets) -> AnyObject {
        
        self.calculationTextView = UITextView()
        self.badgeLabel = MIBadgeLabel(frame: CGRectMake(0, 0, 10, 10))
        self.badgeEdgeInsets = badgeInsets
        self.setupBadgeViewWithString(badgeText: badgeString)
        return self
    }
    
    func setupBadgeViewWithString(#badgeText: String?) {
        badgeLabel.clipsToBounds = true
        badgeLabel.text = badgeText
        var badgeSize: CGSize  = badgeLabel.sizeThatFits(CGSizeMake(320, FLT_MAX))
        badgeSize.width = badgeSize.width < 20 ? 25 : badgeSize.width + 5
        
        var vertical: Float?, horizontal: Float?
        if let badgeInset = self.badgeEdgeInsets {
            vertical = badgeInset.top - badgeInset.bottom
            horizontal = badgeInset.left - badgeInset.right
            badgeLabel.frame = CGRectMake(self.bounds.size.width - 5 + horizontal!, -(badgeSize.height / 2) - 5 + vertical!, badgeSize.width, badgeSize.height)
        } else {
            badgeLabel.frame = CGRectMake(self.bounds.size.width - 5, -(badgeSize.height / 2) - 5, badgeSize.width, badgeSize.height)
        }
        
        self.setupBadgeStyle()
        self.addSubview(badgeLabel)
        
        badgeLabel.hidden = badgeText ? false : true
    }
    
    func setupBadgeStyle()
    {
        badgeLabel.textAlignment = .Center
        badgeLabel.backgroundColor = UIColor.redColor()
        badgeLabel.textColor = UIColor.whiteColor()
        badgeLabel.layer.cornerRadius = 10.0
    }

}
