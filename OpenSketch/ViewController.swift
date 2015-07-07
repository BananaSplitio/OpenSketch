//
//  ViewController.swift
//  OpenSketch
//
//  Created by Andrew on 2015-07-06.
//  Copyright © 2015 Banana Split. All rights reserved.
//

import UIKit
import CoreMotion


class ViewController: UIViewController {
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let smoothLineView : SmoothLineView = SmoothLineView(frame: self.view.bounds)
        self.view.addSubview(smoothLineView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
