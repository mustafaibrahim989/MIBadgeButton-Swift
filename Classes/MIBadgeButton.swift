//
//  MIBadgeButton.swift
//  MIBadgeButton
//
//  Created by Yosemite on 8/27/14.
//  Copyright (c) 2014 Youxel Technology. All rights reserved.
//

import UIKit

public class MIBadgeButton: UIButton {
    
    private var badgeLabel: UILabel
    private var labelWidthConstraint: NSLayoutConstraint?
    private var labelHeightConstraint: NSLayoutConstraint?
    private var labelCenterXConstraint: NSLayoutConstraint?
    private var labelCenterYConstaint: NSLayoutConstraint?
    
    public var badgeString: String? {
        didSet {
            setupBadgeViewWithString(badgeText: badgeString)
        }
    }
    
    public var badgeEdgeInsets: UIEdgeInsets? {
        didSet {
            setupBadgeViewWithString(badgeText: badgeString)
        }
    }
    
    public var badgeBackgroundColor = UIColor.redColor() {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    
    public var badgeTextColor = UIColor.whiteColor() {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }
    
    override public init(frame: CGRect) {
        badgeLabel = UILabel()
        super.init(frame: frame)
        // Initialization code
        setupBadgeViewWithString(badgeText: "")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        badgeLabel = UILabel()
        super.init(coder: aDecoder)
        setupBadgeViewWithString(badgeText: "")
    }
    
    public func initWithFrame(frame frame: CGRect, withBadgeString badgeString: String, withBadgeInsets badgeInsets: UIEdgeInsets) -> AnyObject {
        
        badgeLabel = UILabel()
        badgeEdgeInsets = badgeInsets
        setupBadgeViewWithString(badgeText: badgeString)
        return self
    }
    
    private func setupBadgeViewWithString(badgeText badgeText: String?) {
        badgeLabel.clipsToBounds = true
        badgeLabel.text = badgeText
        badgeLabel.font = UIFont.systemFontOfSize(12)
        badgeLabel.textAlignment = .Center
        badgeLabel.sizeToFit()
        let badgeSize = badgeLabel.frame.size
        
        let height = max(20, Double(badgeSize.height) + 5.0)
        let width = max(height, Double(badgeSize.width) + 10.0)
        
        var vertical: Double?, horizontal: Double?
        if let badgeInset = self.badgeEdgeInsets {
            vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
            horizontal = Double(badgeInset.left) - Double(badgeInset.right)
            
            let x = (Double(bounds.size.width) - 10 + horizontal!)
            let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
            badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        } else {
            let x = CGRectGetWidth(self.frame) - CGFloat((width / 2.0))
            let y = CGFloat(-(height / 2.0))
            badgeLabel.frame = CGRectMake(x, y, CGFloat(width), CGFloat(height))
        }
        
        setupBadgeStyle()
        addSubview(badgeLabel)
        
        if (self.isProgrammaticConstraint(self.superview)) {
            // code creates constraints
            badgeLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // if there are existing constraints then remove them first
            if (self.labelWidthConstraint != nil) {
                self.removeConstraint(self.labelWidthConstraint!)
            }
            if (self.labelHeightConstraint != nil) {
                self.removeConstraint(self.labelHeightConstraint!)
            }
            if (self.labelCenterXConstraint != nil) {
                self.removeConstraint(self.labelCenterXConstraint!)
            }
            if (self.labelCenterYConstaint != nil) {
                self.removeConstraint(self.labelCenterYConstaint!)
            }
            
            self.labelWidthConstraint = NSLayoutConstraint(item: self.badgeLabel, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGFloat(width))
            self.labelHeightConstraint = NSLayoutConstraint(item: self.badgeLabel, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 0.5, constant: CGFloat(height))
            
            if let badgeInset = self.badgeEdgeInsets {
                vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
                horizontal = Double(badgeInset.left) - Double(badgeInset.right)
                
                self.labelCenterXConstraint = NSLayoutConstraint(item: self.badgeLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: (CGFloat(bounds.size.width/2) - 10 + CGFloat(horizontal!)))
                self.labelCenterYConstaint = NSLayoutConstraint(item: self.badgeLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: -CGFloat(bounds.size.height/2) - (CGFloat(badgeSize.height) / 2) + 10 + CGFloat(vertical!))
            }
            else {
                self.labelCenterXConstraint = NSLayoutConstraint(item: self.badgeLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: (CGFloat(bounds.size.width/2) - 10))
                self.labelCenterYConstaint = NSLayoutConstraint(item: self.badgeLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: -CGFloat(bounds.size.height/2) - (CGFloat(badgeSize.height) / 2) + 10)
            }
            
            self.addConstraints([self.labelWidthConstraint!, self.labelHeightConstraint!, self.labelCenterXConstraint!, self.labelCenterYConstaint!])
            self.layoutIfNeeded()
            // -- end of code creates constraints
        }
        
        if let text = badgeText {
            badgeLabel.hidden = text != "" ? false : true
        } else {
            badgeLabel.hidden = true
        }
        
    }
    
    // check if the view hierarchy (starting from its superview) is went on with programmatic approach or not
    // which means user conduct layouting of ui elements via code with constraints
    // normally send argument to this fuction with its superview
    private func isProgrammaticConstraint(startingParent: UIView?) -> Bool {
        var view = startingParent
        
        if (view == nil) {
            return false
        }
        if (view!.translatesAutoresizingMaskIntoConstraints == false) {
            return true
        }
        else {
            return self.isProgrammaticConstraint(view!.superview)
        }
    }
    
    private func setupBadgeStyle() {
        badgeLabel.textAlignment = .Center
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.textColor = badgeTextColor
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / 2
    }
}
