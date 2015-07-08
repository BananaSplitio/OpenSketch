//
//  ViewController.swift
//  OpenSketch
//
//  Created by Andrew on 2015-07-06.
//  Copyright © 2015 Banana Split. All rights reserved.
//

import UIKit
import CoreMotion

var smoothLineView : SmoothLineView = SmoothLineView()

class ViewController: UIViewController {
    
      @IBOutlet weak var mainDrawingCanvas: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smoothLineView = SmoothLineView(frame: mainDrawingCanvas.bounds)
        self.view.addSubview(smoothLineView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteCurrentCanvas(sender: AnyObject) {
        self.view.setNeedsDisplay()
    
    }
   
}
