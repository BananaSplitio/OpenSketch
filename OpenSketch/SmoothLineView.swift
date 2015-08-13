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
    var lineColor : UIColor = UIColor.blackColor()
    var lineWidth : CGFloat = 10.0
    var lineOpacity : CGFloat = 0.7

    let defaultWidth : CGFloat = 10.0

    let kPointMinDistance : CGFloat = 5.0
    let kPointMinDistanceSquared : CGFloat = 25.0

    var currentPoint: CGPoint = CGPoint()
    var previousPoint : CGPoint = CGPoint()
    var previousPreviousPoint : CGPoint = CGPoint()




class SmoothLineView: UIView {
    
    var path : CGMutablePathRef
    var empty : Bool
    var pointCount: Int = Int()
    var pointArray = [Int]()
    var pathArray = [line]()
    
    struct line {
        var structLineColor : UIColor
        var structLineWidth : CGFloat
        var structPath : CGMutablePathRef
        var structOpacity : CGFloat
        
        init(newPath : CGMutablePathRef) {
            structLineColor = lineColor
            structLineWidth = lineWidth
            structPath = newPath
            structOpacity = lineOpacity
        }
    }

    
    func getMidPoint(p1 : CGPoint, p2 : CGPoint) -> CGPoint {
        return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.path = CGPathCreateMutable()
        self.empty = true
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        
        self.path = CGPathCreateMutable()
        self.empty = true
        super.init(frame: frame)
        self.backgroundColor = defaultBackgroundColor

    }
    
    override func drawRect(rect: CGRect) {
        self.backgroundColor?.set()
        UIRectFill(rect)
        
        let context : CGContextRef = UIGraphicsGetCurrentContext()
        for line in pathArray {
            CGContextAddPath(context, line.structPath)
            CGContextSetLineWidth(context, line.structLineWidth)
            CGContextSetStrokeColorWithColor(context, line.structLineColor.CGColor)
            CGContextSetAlpha(context, lineOpacity)

        }
        CGContextSetLineCap(context, CGLineCap.Round)
        CGContextStrokePath(context)
        
        self.empty = false
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first as UITouch! {
            previousPoint = touch.previousLocationInView(self)
            previousPreviousPoint = touch.previousLocationInView(self)
            currentPoint = touch.locationInView(self)
            pointCount = 0
        }
        self.touchesMoved(touches, withEvent: event)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
         if let touch = touches.first as UITouch! {
            
            previousPreviousPoint = previousPoint
            previousPoint = touch.previousLocationInView(self)
            currentPoint = touch.locationInView(self)
            
            let mid1 : CGPoint = getMidPoint(previousPoint, p2: previousPreviousPoint)
            let mid2 : CGPoint = getMidPoint(currentPoint, p2: previousPoint)
            
            let subpath : CGMutablePathRef = CGPathCreateMutable()
            CGPathMoveToPoint(subpath, nil, mid1.x, mid1.y)
            CGPathAddQuadCurveToPoint(subpath, nil, previousPoint.x, previousPoint.y, mid2.x, mid2.y)
            
            let bounds : CGRect = CGPathGetBoundingBox(subpath)
            let drawBox : CGRect = CGRectInset(bounds, -2.0 * lineWidth, -2.0 * lineWidth)
            let newLine = line(newPath: subpath)
            pathArray.append(newLine)
            self.setNeedsDisplayInRect(drawBox)
            print("\(pathArray.count)")
            pointCount++
//            print("\(pointCount)")
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pointArray.append(pointCount)
        print("\(pointArray)")
    }
}

    