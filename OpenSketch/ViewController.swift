//
//  ViewController.swift
//  OpenSketch
//
//  Created by Andrew on 2015-07-06.
//  Copyright © 2015 Banana Split. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var smoothLineView : SmoothLineView = SmoothLineView()

    
    @IBOutlet weak var mainDrawingCanvas: UIImageView!
    @IBOutlet weak var deleteCurrentCanvasButton: UIButton!
    @IBOutlet weak var blueColorButton: BlueButton!
    @IBOutlet weak var redColorButton: RedButton!
    @IBOutlet weak var greenColorButton: GreenButton!
    @IBOutlet weak var yellowColorButton: YellowButton!
    @IBOutlet weak var orangeColorButton: OrangeButton!
    @IBOutlet weak var purpleColorButton: PurpleButton!
    @IBOutlet weak var lineWidthSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smoothLineView = SmoothLineView(frame: mainDrawingCanvas.bounds)
        self.view.addSubview(smoothLineView)
        self.view.bringSubviewToFront(deleteCurrentCanvasButton)
        self.view.bringSubviewToFront(blueColorButton)
        self.view.bringSubviewToFront(redColorButton)
        self.view.bringSubviewToFront(greenColorButton)
        self.view.bringSubviewToFront(yellowColorButton)
        self.view.bringSubviewToFront(orangeColorButton)
        self.view.bringSubviewToFront(purpleColorButton)
        self.view.bringSubviewToFront(lineWidthSlider)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteCurrentCanvas(sender: AnyObject) {
        mainDrawingCanvas.image = nil 
        smoothLineView.path = CGPathCreateMutable()
        if CGPathIsEmpty(smoothLineView.path) {
            smoothLineView.backgroundColor = UIColor.whiteColor()
            smoothLineView.backgroundColor = UIColor.clearColor()
        }
    }
   
    @IBAction func blueColorStroke(sender: AnyObject) {
        changeStrokeColor(UIColor.blueColor())
        
    }
    @IBAction func redColorStroke(sender: AnyObject) {
        changeStrokeColor(UIColor.redColor())
    }
    @IBAction func greenColorStroke(sender: AnyObject) {
        changeStrokeColor(UIColor.greenColor())
    }
    @IBAction func yellowColorStroke(sender: AnyObject) {
        changeStrokeColor(UIColor.yellowColor())
    }
    @IBAction func orangeColorStroke(sender: AnyObject) {
        changeStrokeColor(UIColor.orangeColor())
    }
    @IBAction func purpleColorButton(sender: AnyObject) {
        changeStrokeColor(UIColor.purpleColor())
    }
    @IBAction func valueDidChange(sender: AnyObject) {
        let newValue : Float = sender.value
        changeStrokeWidth(CGFloat(newValue))
    }
    
    func changeStrokeColor(color: UIColor) {
    addViewToImageView()
    smoothLineView.lineColor = color
    
    }
    
    func changeStrokeWidth(width: CGFloat) {
        smoothLineView.lineWidth = width
        addViewToImageView()
    }
    
    func addViewToImageView() {
        UIGraphicsBeginImageContextWithOptions(mainDrawingCanvas.bounds.size, view.opaque, 0.0)
        view.drawViewHierarchyInRect(mainDrawingCanvas.bounds, afterScreenUpdates: false)
        let snapshotImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        mainDrawingCanvas.image = snapshotImage
        smoothLineView.path = CGPathCreateMutable()
        if CGPathIsEmpty(smoothLineView.path) {
            smoothLineView.backgroundColor = UIColor.whiteColor()
            smoothLineView.backgroundColor = UIColor.clearColor()
        }

    }
    
    
}
