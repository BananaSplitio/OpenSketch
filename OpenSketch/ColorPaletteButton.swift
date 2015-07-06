//
//  colorPaletteButton.swift
//  OpenSketch
//
//  Created by Andrew on 2015-07-06.
//  Copyright © 2015 Banana Split. All rights reserved.
//

import UIKit

class ColorPaletteButton: UIButton {

}

class RedButton: ColorPaletteButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.redColor().setFill()
        path.fill()
    }
}

class BlueButton: ColorPaletteButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.blueColor().setFill()
        path.fill()
    }
}

class GreenButton: ColorPaletteButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.greenColor().setFill()
        path.fill()
    }
}

class YellowButton: ColorPaletteButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.yellowColor().setFill()
        path.fill()
    }
}

class PurpleButton: ColorPaletteButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.purpleColor().setFill()
        path.fill()
    }
}

class OrangeButton: ColorPaletteButton {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor.orangeColor().setFill()
        path.fill()
    }
}


