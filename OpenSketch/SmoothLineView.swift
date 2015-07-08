//
//  SmoothLineView.swift
//  OpenSketch
//
//  Created by Andrew on 2015-07-06.
//  Copyright © 2015 Cashew Studio. All rights reserved.
//

import UIKit
import QuartzCore

    let defaultColor : UIColor = UIColor.blackColor()
    let defaultBackgroundColor : UIColor = UIColor.clearColor()
    let defaultWidth : CGFloat = 5.0

    let kPointMinDistance : CGFloat = 5.0
    let kPointMinDistanceSquared : CGFloat = 25.0

    var currentPoint: CGPoint = CGPoint()
    var previousPoint : CGPoint = CGPoint()
    var previousPreviousPoint : CGPoint = CGPoint()



class SmoothLineView: UIView {
    
    var path : CGMutablePathRef
    var lineColor : UIColor
    var lineWidth : CGFloat
    var empty : Bool

    
    func getMidPoint(p1 : CGPoint, p2 : CGPoint) -> CGPoint {
        return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
    }
    
    required init(coder aDecoder: NSCoder) {
        self.path = CGPathCreateMutable()
        self.lineWidth = defaultWidth
        self.lineColor = defaultColor
        self.empty = true
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        
        self.path = CGPathCreateMutable()
        self.lineWidth = defaultWidth
        self.lineColor = defaultColor
        self.empty = true
        super.init(frame: frame)
        self.backgroundColor = defaultBackgroundColor

    }
    
    override func drawRect(rect: CGRect) {
        self.backgroundColor?.set()
        // clear rect
        UIRectFill(rect)
        
        // get the graphics context and draw the path
        let context : CGContextRef = UIGraphicsGetCurrentContext()
        CGContextAddPath(context, self.path)
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextSetLineWidth(context, self.lineWidth)
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor)
        CGContextStrokePath(context)
        
        
        self.empty = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            previousPoint = touch.previousLocationInView(self)
            previousPreviousPoint = touch.previousLocationInView(self)
            currentPoint = touch.locationInView(self)
        }
        self.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
         if let touch = touches.first as UITouch! {
            let point : CGPoint = touch.locationInView(self)
            
            // if the finger has moved less than the min dist ...
            
            let dx : CGFloat = point.x - currentPoint.x
            let dy : CGFloat = point.y - currentPoint.y
            
            
            if ((dx * dx + dy * dy) < kPointMinDistanceSquared) {
                // ... then ignore this movement
                return
            }
            
            // update points: previousPrevious -> mid1 -> previous -> mid2 -> current
            
            previousPreviousPoint = previousPoint
            previousPoint = touch.previousLocationInView(self)
            currentPoint = touch.locationInView(self)
            
            let mid1 : CGPoint = getMidPoint(previousPreviousPoint, p2: previousPreviousPoint)
            let mid2 : CGPoint = getMidPoint(currentPoint, p2: previousPoint)
            
            // to represent the finger movement, create a new path segment,
            // a quadratic bezier path from mid1 to mid2, using previous as a control point
            
            let subpath : CGMutablePathRef = CGPathCreateMutable()
            CGPathMoveToPoint(subpath, nil, mid1.x, mid1.y)
            CGPathAddQuadCurveToPoint(subpath, nil, previousPoint.x, previousPoint.y, mid2.x, mid2.y)
            
            // compute the rect containing the new segment plus padding for drawn line
            
            let bounds : CGRect = CGPathGetBoundingBox(subpath)
            let drawBox : CGRect = CGRectInset(bounds, -2.0 * self.lineWidth, -2.0 * self.lineWidth)
            
            // append the quad curve to the accumulated path so far.
            
            CGPathAddPath(path, nil, subpath)
            self.setNeedsDisplayInRect(drawBox)
            }
        
        }
    func clear() {
        self.path = CGPathCreateMutable()
        
   
}

}

    