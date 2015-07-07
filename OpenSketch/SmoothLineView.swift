//
//  SmoothLineView.swift
//  OpenSketch
//
//  Created by Andrew on 2015-07-06.
//  Copyright © 2015 Cashew Studio. All rights reserved.
//

import UIKit
import QuartzCore

class SmoothLineView: UIView {
    
    
    var lastPoint = CGPoint.zeroPoint
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var brushWidth: CGFloat = 5.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var currentPoint : CGPoint = (0.0, 0.0)
    var previousPoint : CGPoint = (0.0, 0.0)
    var previousPreviousPoint : CGPoint = (0.0, 0.0)
    let kPointMinDistance : CGFloat = 5.0
    let kPointMinDistanceSquared : CGFloat = 25.0
    let path : CGMutablePathRef
    let lineWidth : CGFloat = 5.0
    let lineColor = UIColor.blackColor()
    
    func getMidPoint(p1 : CGPoint, p2 : CGPoint) -> CGPoint {
        return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touch = touches.first as UITouch! {
            self.previousPoint = touch.previousLocationInView(self)
            self.previousPreviousPoint = touch.previousLocationInView(self)
            self.currentPoint = touch.locationInView(self)
        }
        self.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        swiped = true
        if let touch = touches.first as UITouch! {
            let point : CGPoint = touch.locationInView(self)
            
            // if the finger has moved less than the min dist ...
            
            let dx : CGFloat = point.x - self.currentPoint.x
            let dy : CGFloat = point.y - self.currentPoint.y
            
            
            if ((dx * dx + dy * dy) < kPointMinDistanceSquared) {
                // ... then ignore this movement
                return;
            }
            
            // update points: previousPrevious -> mid1 -> previous -> mid2 -> current

            self.previousPreviousPoint = self.previousPoint
            self.previousPoint = touch.previousLocationInView(self)
            self.currentPoint = touch.locationInView(self)
            
            let mid1 : CGPoint = getMidPoint(self.previousPreviousPoint, p2: self.previousPreviousPoint)
            let mid2 : CGPoint = getMidPoint(self.currentPoint, p2: self.previousPoint)
            
            // to represent the finger movement, create a new path segment,
            // a quadratic bezier path from mid1 to mid2, using previous as a control point
            
            let subpath : CGMutablePathRef = CGPathCreateMutable()
            CGPathMoveToPoint(subpath, nil, mid1.x, mid1.y)
            CGPathAddQuadCurveToPoint(subpath, nil, self.previousPoint.x, self.previousPoint.y, mid2.x, mid2.y)
            
            // compute the rect containing the new segment plus padding for drawn line
            
            let bounds : CGRect = CGPathGetBoundingBox(subpath)
            let drawBox : CGRect = CGRectInset(bounds, -2.0 * self.lineWidth, -2.0 * self.lineWidth)
            
            // append the quad curve to the accumulated path so far.
            
            CGPathAddPath(path, nil, subpath)
            self.setNeedsDisplayInRect(drawBox)
        


            
            

            
        }
    }
    
    

    
    






}
