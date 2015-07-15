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
    let defaultBackgroundColor : UIColor = UIColor.whiteColor()
    let defaultWidth : CGFloat = 10.0

    let kPointMinDistance : CGFloat = 5.0
    let kPointMinDistanceSquared : CGFloat = 25.0

    var currentPoint: CGPoint = CGPoint()
    var previousPoint : CGPoint = CGPoint()
    var previousPreviousPoint : CGPoint = CGPoint()
    var imageArray = [UIImage]()





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
        self.backgroundColor = UIColor.whiteColor()

    }
    
    override func drawRect(rect: CGRect) {
        self.backgroundColor?.set()
        UIRectFill(rect)
        
        let context : CGContextRef = UIGraphicsGetCurrentContext()
        CGContextAddPath(context, self.path)
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextSetLineWidth(context, self.lineWidth)
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor)
        CGContextSetAlpha(context, 0.7)
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
            
            let mid1 : CGPoint = getMidPoint(previousPoint, p2: previousPreviousPoint)
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
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, opaque, 0.0)
        drawViewHierarchyInRect(self.bounds, afterScreenUpdates: false)
        let snapshotImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        switch imageArray.count {
        case 0, 1:
            imageArray.append(snapshotImage)
            UIGraphicsEndImageContext()
        default:
            let indexNumber = (imageArray.count - 1)
            let previousSnapshotImage : UIImage = imageArray[indexNumber]
            let blendedImage = addImage(snapshotImage, toImage: previousSnapshotImage)
            imageArray.append(blendedImage)
        }
        print("Hello")
    }

}

func addImage(image: UIImage, toImage: UIImage) -> UIImage {
    UIGraphicsBeginImageContext(image.size)
    image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height))
    image.drawInRect(CGRectMake(0, 0, image.size.width, image.size.height), blendMode: kCGBlendModeNormal, alpha: 0.0)
    let newImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
}
    