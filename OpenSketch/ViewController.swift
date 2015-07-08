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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smoothLineView = SmoothLineView(frame: mainDrawingCanvas.bounds)
        self.view.addSubview(smoothLineView)
        self.view.bringSubviewToFront(deleteCurrentCanvasButton)
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteCurrentCanvas(sender: AnyObject) {
        smoothLineView.path = CGPathCreateMutable()
        if CGPathIsEmpty(smoothLineView.path) {
            smoothLineView.backgroundColor = UIColor.whiteColor()
            smoothLineView.backgroundColor = UIColor.clearColor()
        }
    }
   
}
