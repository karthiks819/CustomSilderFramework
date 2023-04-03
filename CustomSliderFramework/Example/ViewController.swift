//
//  ViewController.swift
//  Example
//
//  Created by Karthiks on 02/04/23.
//

import UIKit
import CustomSliderFramework

class ViewController: UIViewController {
    var arr:[String] = ["12.0", "12.0", "12.0", "12.0"]
    @IBOutlet weak var markSlider: CustomSlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        markSlider.minimumValue = 0
        markSlider.maximumValue = Float(arr.count - 1)
        markSlider.markValues = arr
        markSlider.drawMarks(in: self.markSlider.bounds)
    }


}

