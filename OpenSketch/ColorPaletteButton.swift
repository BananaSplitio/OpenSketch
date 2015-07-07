//
//  colorPaletteButton.swift
//  OpenSketch
//
//  Created by Andrew on 2015-07-06.
//  Copyright © 2015 Banana Split. All rights reserved.
//

import UIKit

class ColorPaletteButton: UIButton {
    
    var fillColor = UIColor.whiteColor().CGColor
    
    override func drawRect(rect:CGRect)
        
    {
        // obtain context
        let context = UIGraphicsGetCurrentContext()
        
        // decide on radius
        let rad = CGRectGetWidth(rect)/2-2
        
        let endAngle = CGFloat(2*M_PI)
        
        // add the circle to the context
        CGContextAddArc(context, CGRectGetMidX(rect), CGRectGetMidY(rect), rad, 0, endAngle, 1)
        
        // set fill color
        CGContextSetFillColorWithColor(context,fillColor)
        
        // set stroke color
        CGContextSetStrokeColorWithColor(context,UIColor.blackColor().CGColor)
        
        // set line width
        CGContextSetLineWidth(context, 3.0)
        // use to fill and stroke path (see http://stackoverflow.com/questions/13526046/cant-stroke-path-after-filling-it )
        
        // draw the path
        CGContextDrawPath(context, kCGPathFillStroke);
    }

    
}

class RedButton: ColorPaletteButton {
    
    override func drawRect(rect: CGRect) {
        fillColor = UIColor.redColor().CGColor
        super.drawRect(rect)
    }
}

class BlueButton: ColorPaletteButton {
    
    override func drawRect(rect: CGRect) {
        fillColor = UIColor.blueColor().CGColor
        super.drawRect(rect)
    }
}

class GreenButton: ColorPaletteButton {
    
    override func drawRect(rect: CGRect) {
        fillColor = UIColor.greenColor().CGColor
        super.drawRect(rect)
    }
}

class YellowButton: ColorPaletteButton {
    
    override func drawRect(rect: CGRect) {
        fillColor = UIColor.yellowColor().CGColor
        super.drawRect(rect)
    }
}

class PurpleButton: ColorPaletteButton {
    
    override func drawRect(rect: CGRect) {
        fillColor = UIColor.purpleColor().CGColor
        super.drawRect(rect)
    }
}

class OrangeButton: ColorPaletteButton {
    
    override func drawRect(rect: CGRect) {
        fillColor = UIColor.orangeColor().CGColor
        super.drawRect(rect)
    }
}
