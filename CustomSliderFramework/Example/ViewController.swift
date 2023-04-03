//
//  ViewController.swift
//  Example
//
//  Created by Karthiks on 02/04/23.
//

import UIKit
import CustomSliderFramework

class ViewController: UIViewController {
    var arr = ["1", "2", "3", "4", "5", "6"]
    
//    @IBOutlet weak var imageSlider: CustomSlider!
    @IBOutlet weak var markSlider: CustomSlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Mark type slider
        self.addTapGestureForSlider()
        markSlider.minimumValue = 0
        markSlider.maximumValue = Float(arr.count - 1)
        markSlider.maximumTrackTintColor = .darkGray
        markSlider.markValues = arr
        markSlider.minimumMarkTintColor = .red
        markSlider.maximumMarkTintColor = .green
        markSlider.markStyle = .shape(width: 4, height: 8, cornerRadius: 2)
        markSlider.toShowMarkOnSelectedValue = false
        DispatchQueue.main.async {
            self.markSlider.drawMarks(in: self.markSlider.bounds)
        }
        
        
        
//        //Image type with marker slider
//        imageSlider.minimumValue = 0
//        imageSlider.maximumValue = Float(arr.count - 1)
//        imageSlider.maximumTrackTintColor = .darkGray
//        imageSlider.setThumbImage(UIImage(named: "slider"), for: .normal)
//        imageSlider.markValues = arr
//        DispatchQueue.main.async {
//            self.imageSlider.drawMarks(in: self.markSlider.bounds)
//        }
       
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
        DispatchQueue.main.async {
            self.markSlider.drawMarks(in: self.markSlider.bounds)
        }
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

