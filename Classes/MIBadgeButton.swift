//
//  MIBadgeButton.swift
//  MIBadgeButton
//
//  Created by Yosemite on 8/27/14.
//  Copyright (c) 2014 Youxel Technology. All rights reserved.
//

import UIKit

class MIBadgeButton: UIButton {
    
    private var calculationTextView: UITextView
    private var badgeLabel: MIBadgeLabel
    var badgeString: String? {
        didSet {
            setupBadgeViewWithString(badgeText: badgeString)
        }
    }
    
    var badgeEdgeInsets: UIEdgeInsets? {
        didSet {
            setupBadgeViewWithString(badgeText: badgeString)
        }
    }
    
    var badgeBackgroundColor = UIColor.redColor() {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    
    var badgeTextColor = UIColor.whiteColor() {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }

    override init(frame: CGRect) {
        calculationTextView = UITextView()
        badgeLabel = MIBadgeLabel(frame: CGRectMake(0, 0, 10, 10))
        super.init(frame: frame)
        // Initialization code
        setupBadgeViewWithString(badgeText: "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        calculationTextView = UITextView()
        badgeLabel = MIBadgeLabel(frame: CGRectMake(0, 0, 10, 10))
        super.init(coder: aDecoder)
        setupBadgeViewWithString(badgeText: "")
    }
    
    func initWithFrame(frame frame: CGRect, withBadgeString badgeString: String, withBadgeInsets badgeInsets: UIEdgeInsets) -> AnyObject {
        
        calculationTextView = UITextView()
        badgeLabel = MIBadgeLabel(frame: CGRectMake(0, 0, 10, 10))
        badgeEdgeInsets = badgeInsets
        setupBadgeViewWithString(badgeText: badgeString)
        return self
    }
    
    private func setupBadgeViewWithString(badgeText badgeText: String?) {
        badgeLabel.clipsToBounds = true
        badgeLabel.text = badgeText
        var badgeSize: CGSize  = badgeLabel.sizeThatFits(CGSize(width: 320, height: CGFloat(FLT_MAX)))
        badgeSize.width = badgeSize.width < 20 ? 20 : badgeSize.width + 5
        
        var vertical: Double?, horizontal: Double?
        if let badgeInset = self.badgeEdgeInsets {
            vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
            horizontal = Double(badgeInset.left) - Double(badgeInset.right)
            
            let x = (Double(bounds.size.width) - 10 + horizontal!)
            let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
            let width = Double(badgeSize.width)
            let height = Double(badgeSize.height)
            
            badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        } else {
            badgeLabel.frame = CGRectMake(self.bounds.size.width - 10, -(badgeSize.height / 2) - 10, badgeSize.width, badgeSize.height)
        }
        
        setupBadgeStyle()
        addSubview(badgeLabel)
        badgeLabel.badgeTextColor = badgeTextColor
        
        badgeLabel.hidden = badgeText != nil ? false : true
    }
    
    private func setupBadgeStyle() {
        badgeLabel.textAlignment = .Center
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.textColor = badgeTextColor
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.width > 25 ? 8 : badgeLabel.bounds.size.width / 2
    }

}
