//
//  MIBadgeButton.swift
//  MIBadgeButton
//
//  Created by Yosemite on 8/27/14.
//  Copyright (c) 2014 Youxel Technology. All rights reserved.
//

import UIKit

/**
 Define badge anchor
 **/
public enum MIAnchor{
    case TopLeft(topOffset : CGFloat, leftOffset : CGFloat)
    case TopRight(topOffset : CGFloat, rightOffset : CGFloat)
    case BottomLeft(bottomOffset : CGFloat, leftOffset : CGFloat)
    case BottomRight(bottomOffset : CGFloat, rightOffset : CGFloat)
    case center
}

@IBDesignable
open class MIBadgeButton: UIButton {
    
    fileprivate var badgeLabel: UILabel
    
    @IBInspectable
    open var badgeString: String? {
        didSet {
            setupBadgeViewWithString(badgeText: badgeString)
        }
    }
    
//    @objc
//    open var badgeEdgeInsets: UIEdgeInsets = .zero
    /**
     Factor that can change corner radius of badge
     
     This value will be calculate like:
     (Badge Label Height) / (this value)
    **/
    @IBInspectable
    open var cornerRadiusFactor : CGFloat = 2{
        
        didSet{
            setupBadgeViewWithString(badgeText: badgeString)
        }
    }
    
    /**
     Vertical margin in badge
     This is the space between text and badge's vertical edge
    **/
    fileprivate var innerVerticalMargin : CGFloat = 5.0{
        
        didSet{
            setupBadgeViewWithString(badgeText: badgeString)
        }
    }
    
    /**
     Horizontal margin in badge
     This is the space between text and badge's horizontal edge
     **/
    fileprivate var innerHorizontalMargin : CGFloat = 10.0{
        
        didSet{
            setupBadgeViewWithString(badgeText: badgeString)
        }
    }
    
    /**
     Vertical margin in badge
     This is the space between text and badge's vertical edge
     **/
    @IBInspectable
    open var verticalMargin : CGFloat{
        
        set{
            
            self.innerVerticalMargin = max(0, newValue)
        }
        
        get{
            
            return innerVerticalMargin
        }
    }
    
    /**
     Horizontal margin in badge
     This is the space between text and badge's horizontal edge
     **/
    @IBInspectable
    open var horizontalMargin : CGFloat{
        
        set{
            self.innerHorizontalMargin = max(0, newValue)
        }
        
        get{
            
            return innerHorizontalMargin
        }
    }
    
    open var badgeEdgeInsets: UIEdgeInsets? {
        didSet {
            setupBadgeViewWithString(badgeText: badgeString)
        }
    }
    
    @IBInspectable
    open var badgeBackgroundColor : UIColor = UIColor.red {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }
    
    @IBInspectable
    open var badgeTextColor : UIColor = UIColor.white {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }
    
    /**
     Can be adjust from Interface Builder
     EdgeInsetLeft
    **/
    @IBInspectable
    open var edgeInsetLeft : CGFloat{
        set{

            if let edgeInset = badgeEdgeInsets{
                
                self.badgeEdgeInsets = UIEdgeInsets(top: edgeInset.top, left: newValue, bottom: edgeInset.bottom, right: edgeInset.right)
            }
            else{
                
                self.badgeEdgeInsets = UIEdgeInsets(top: 0.0, left: newValue, bottom: 0.0, right: 0.0)
            }
        }
        get{
            
            if let edgeInset = badgeEdgeInsets{
                return edgeInset.left
            }
            
            return 0.0
        }
    }
    
    /**
     Can be adjust from Interface Builder
     EdgeInsetRight
     **/
    @IBInspectable
    open var edgeInsetRight : CGFloat{
        set{
            
            if let edgeInset = badgeEdgeInsets{
                
                self.badgeEdgeInsets = UIEdgeInsets(top: edgeInset.top, left: edgeInset.left, bottom: edgeInset.bottom, right: newValue)
            }
            else{
                
                self.badgeEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: newValue)
            }
        }
        get{
            
            if let edgeInset = badgeEdgeInsets{
                return edgeInset.right
            }
            
            return 0.0
        }
    }
    
    /**
     Can be adjust from Interface Builder
     EdgeInsetTop
     **/
    @IBInspectable
    open var edgeInsetTop : CGFloat{
        set{
            
            if let edgeInset = badgeEdgeInsets{
                
                self.badgeEdgeInsets = UIEdgeInsets(top: newValue, left: edgeInset.left, bottom: edgeInset.bottom, right: edgeInset.right)
            }
            else{
                
                self.badgeEdgeInsets = UIEdgeInsets(top: newValue, left: 0.0, bottom: 0.0, right: 0.0)
            }
        }
        get{
            
            if let edgeInset = badgeEdgeInsets{
                return edgeInset.top
            }
            
            return 0.0
        }
    }
    
    /**
     Can be adjust from Interface Builder
     EdgeInsetBottom
     **/
    @IBInspectable
    open var edgeInsetBottom : CGFloat{
        set{
            
            if let edgeInset = badgeEdgeInsets{
                
                self.badgeEdgeInsets = UIEdgeInsets(top: edgeInset.top, left: edgeInset.left, bottom: newValue, right: edgeInset.right)
            }
            else{
                
                self.badgeEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: newValue, right: 0.0)
            }
        }
        get{
            
            if let edgeInset = badgeEdgeInsets{
                return edgeInset.bottom
            }
            
            return 0.0
        }
    }
    
    /**
     Badge's anchor. TopLeft, TopRight, BottomLeft, BottomRight and Center
     Offset is required depend on anchor. Assign 0.0 if don't need offset
     
     Note: badgeEdgeInsets are taking into count when calculate position
     **/
    open var badgeAnchor : MIAnchor = .TopRight(topOffset: 0.0, rightOffset: 0.0){
        didSet{
            setupBadgeViewWithString(badgeText: badgeString)
        }
    }
    
    /**
     AnchorIndex is an Integer value from 0 to 4 each value represent different anchor of badge
     
     0 = TopLeft
     
     1 = TopRight
     
     2 = BottomLeft
     
     3 = BottomRight
     
     4 = Center
     **/
    fileprivate var anchorIndex : Int = 0{
        didSet{
            
            switch anchorIndex {
            case 0:
                self.badgeAnchor = .TopLeft(topOffset: topOffset, leftOffset: leftOffset)
                break
            case 1:
                self.badgeAnchor = .TopRight(topOffset: topOffset, rightOffset: rightOffset)
                break
            case 2:
                self.badgeAnchor = .BottomLeft(bottomOffset: buttomOffset, leftOffset: leftOffset)
                break
            case 3:
                self.badgeAnchor = .BottomRight(bottomOffset: buttomOffset, rightOffset: rightOffset)
                break
            case 4:
                self.badgeAnchor = .center
                break
            default:
                print("Unknow anchor position. Fallback to default")
                self.anchorIndex  = 1
            }
        }
    }
    
    /**
     Can be adjust from Interface Builder
     It represent different anchor on button
     Values are 0 ~ 4
     
     0 = TopLeft
     
     1 = TopRight
     
     2 = BottomLeft
     
     3 = BottomRight
     
     4 = Center
    **/
    @IBInspectable
    open var anchor : Int{
        set{
            
            self.anchorIndex = min(max(0, newValue), 4)
        }
        
        get{
            return self.anchorIndex
        }
    }
    
    /**
     Can be adjust from Interface Builder
     Left offset of anchor
     
     Value is effect when anchor are:
     
     TopLeft
     
     BottomLeft
     **/
    @IBInspectable
    open var leftOffset : CGFloat = 0{
        didSet{
            
            //get anchor of index and assign to anchorIndex
            //to trigger view to update
            let ach = anchor
            self.anchorIndex = ach
        }
    }
    
    /**
     Can be adjust from Interface Builder
     Right offset of anchor
     
     Value is effect when anchor are:
     
     TopRight
     
     BottomRight
     **/
    @IBInspectable
    open var rightOffset : CGFloat = 0{
        didSet{
            let ach = anchor
            self.anchorIndex = ach
        }
    }
    
    /**
     Can be adjust from Interface Builder
     Top offset of anchor
     
     Value is effect when anchor are:
     
     TopLeft
     
     TopRight
     **/
    @IBInspectable
    open var topOffset : CGFloat = 0{
        didSet{
            let ach = anchor
            self.anchorIndex = ach
        }
    }
    
    /**
     Can be adjust from Interface Builder
     Bottom offset of anchor
     
     Value is effect when anchor are:
     
     BottomLeft
     
     BottomRight
     **/
    @IBInspectable
    open var buttomOffset : CGFloat = 0{
        didSet{
            let ach = anchor
            self.anchorIndex = ach
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
    
    open func initWithFrame(frame: CGRect, withBadgeString badgeString: String, withBadgeInsets badgeInsets: UIEdgeInsets, badgeAnchor : MIAnchor = .TopRight(topOffset: 0.0, rightOffset: 0.0)) -> AnyObject {
        
        badgeLabel = UILabel()
        badgeEdgeInsets = badgeInsets
        self.badgeAnchor = badgeAnchor
        setupBadgeViewWithString(badgeText: badgeString)
        return self
    }
    
    /*
    fileprivate func setupBadgeViewWithString(badgeText: String?) {
        badgeLabel.clipsToBounds = true
        badgeLabel.text = badgeText
        badgeLabel.font = UIFont.systemFont(ofSize: 12)
        badgeLabel.textAlignment = .center
        badgeLabel.sizeToFit()
        let badgeSize = badgeLabel.frame.size
        
        let height = max(20, Double(badgeSize.height) + 5.0)
        let width = max(height, Double(badgeSize.width) + 10.0)
        
        var vertical: Double?, horizontal: Double?
        let badgeInset = self.badgeEdgeInsets
        vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
        horizontal = Double(badgeInset.left) - Double(badgeInset.right)
        
        let x = (Double(bounds.size.width) - 10 + horizontal!)
        let y = -(Double(badgeSize.height) / 2) - 10 + vertical!
        badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        
        setupBadgeStyle()
        addSubview(badgeLabel)
        
        if let text = badgeText {
            badgeLabel.isHidden = text != "" ? false : true
        } else {
            badgeLabel.isHidden = true
        }
        
    }
    */
    fileprivate func setupBadgeViewWithString(badgeText: String?){
        badgeLabel.clipsToBounds = true
        badgeLabel.text = badgeText
        badgeLabel.font = UIFont.systemFont(ofSize: 12)
        badgeLabel.textAlignment = .center
        badgeLabel.sizeToFit()
        let badgeSize = badgeLabel.bounds.size
        
        let height = max(20, CGFloat(badgeSize.height) + innerVerticalMargin)
        let width = max(height, CGFloat(badgeSize.width) + innerHorizontalMargin)
        
        var vertical: CGFloat, horizontal: CGFloat
        var x : CGFloat = 0, y : CGFloat = 0
        
        if let badgeInset = self.badgeEdgeInsets{
            
            vertical = CGFloat(badgeInset.top) - CGFloat(badgeInset.bottom)
            horizontal = CGFloat(badgeInset.left) - CGFloat(badgeInset.right)
            
        }
        else{
            
            vertical = 0.0
            horizontal = 0.0
        }
        
        //calculate badge X Y position
        calculateXYForBadge(x: &x, y: &y, badgeSize: CGSize(width: width, height: height))
        
        //add badgeEdgeInset
        x = x + horizontal
        y = y + vertical
        
        badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        
        setupBadgeStyle()
        addSubview(badgeLabel)
        
        if let text = badgeText {
            badgeLabel.isHidden = text != "" ? false : true
        } else {
            badgeLabel.isHidden = true
        }

    }
    
    /**
     Calculate badge's X Y position.
     Offset are taking into count
    **/
    fileprivate func calculateXYForBadge(x : inout CGFloat, y : inout CGFloat, badgeSize : CGSize){
        
        switch self.badgeAnchor {
            
        case .TopLeft(let topOffset, let leftOffset):
            x = -badgeSize.width/2 + leftOffset
            y = -badgeSize.height/2 + topOffset
            break
            
        case .TopRight(let topOffset, let rightOffset):
            x = self.bounds.size.width - badgeSize.width/2 + rightOffset
            y = -badgeSize.height/2 + topOffset
            break
            
        case .BottomLeft(let bottomOffset, let leftOffset):
            x = -badgeSize.width/2 + leftOffset
            y = self.bounds.size.height - badgeSize.height/2 + bottomOffset
            break
        case .BottomRight(let bottomOffset, let rightOffset):
            x = self.bounds.size.width - badgeSize.width/2 + rightOffset
            y = self.bounds.size.height - badgeSize.height/2 + bottomOffset
            break
        case .center:
            x = self.bounds.size.width/2 - badgeSize.width/2
            y = self.bounds.size.height/2 - badgeSize.height/2
            break
        }
    }
    
    fileprivate func setupBadgeStyle() {
        badgeLabel.textAlignment = .center
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.textColor = badgeTextColor
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / cornerRadiusFactor
    }
}
