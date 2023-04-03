//
//  ViewController.swift
//  Example
//
//  Created by Karthiks on 02/04/23.
//

import UIKit
import CustomSliderFramework

class ViewController: UIViewController {
    var arr = ["12.0", "12.0", "12.0", "12.0"]
    @IBOutlet weak var markSlider: CustomSlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapGestureForSlider()
        markSlider.minimumValue = 0
        markSlider.maximumValue = Float(arr.count - 1)
        markSlider.markValues = arr
        DispatchQueue.main.async {
            self.markSlider.drawMarks(in: self.markSlider.bounds)
        }
        
       
    }

    public func addTapGestureForSlider() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.markSlider.addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.markSlider)
        let percent = self.markSlider.minimumValue + Float(location.x / self.markSlider.bounds.width) * self.markSlider.maximumValue
        self.markSlider.setValue(percent, animated: false)
        self.markSlider.sendActions(for: .valueChanged)
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        markSlider.setMarkerColors()
        // instead of Int(val) you may want to round(val) for a better UI
        let rounded = round(sender.value/1) * 1
        markSlider.setValue(rounded, animated: false)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        DispatchQueue.main.async {
            self.markSlider.drawMarks(in: self.markSlider.bounds)
        }
    }

}

