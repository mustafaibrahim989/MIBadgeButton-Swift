//
//  MIBadgeLabel.swift
//  MIBadgeButton
//
//  Created by Yosemite on 8/27/14.
//  Copyright (c) 2014 Youxel Technology. All rights reserved.
//

import UIKit

class MIBadgeLabel: UILabel {

    override func drawRect(rect: CGRect)
    {
        // Drawing code
        let ctx: CGContextRef = UIGraphicsGetCurrentContext()
        let borderPath: UIBezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners:UIRectCorner.AllCorners, cornerRadii: CGSizeMake(10.0, 10.0))

        CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
        CGContextSaveGState(ctx)
        CGContextAddPath(ctx, borderPath.CGPath)
        CGContextSetLineWidth(ctx, 4.0)
        CGContextSetStrokeColorWithColor(ctx, UIColor.clearColor().CGColor)
        CGContextDrawPath(ctx, kCGPathStroke)
        CGContextRestoreGState(ctx)
        
        CGContextSaveGState(ctx)
//        CGContextSetFillColorWithColor(ctx, UIColor.whiteColor().CGColor)
        var textFrame: CGRect  = rect
        let labelString: NSString = self.text! as NSString
        let textSize: CGSize  = labelString.sizeWithAttributes([NSFontAttributeName : UIFont.systemFontOfSize(13.0)])
        textFrame.size.height = textSize.height
        
        textFrame.origin.y = rect.origin.y + ceil((rect.size.height - textFrame.size.height) / 2.0)
        
        var paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle();
        paragraphStyle.alignment = .Center
        
        var attributes: NSMutableDictionary = [NSFontAttributeName: UIFont.systemFontOfSize(13.0), NSForegroundColorAttributeName : UIColor.whiteColor(), NSParagraphStyleAttributeName:paragraphStyle]
        
        labelString.drawInRect(textFrame, withAttributes: attributes as [NSObject : AnyObject])
    }
    

}
