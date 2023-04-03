//
//  CustomSlider.swift
//  CustomSliderFramework
//
//  Created by Karthiks on 02/04/23.
//

import Foundation
import UIKit

public enum MarkStyle {
    case shape(width: CGFloat, height: CGFloat, cornerRadius: CGFloat)
    case image(image: UIImage)
}

open class CustomSlider: UISlider {
    open var markValues: [String] = []
    
     var markViews = [UIView]()
    
    open var isStayToMark: Bool = true
    
    open  var markStyle: MarkStyle = .shape(width: 1, height: 4, cornerRadius: 1)
    
    open var minimumMarkTintColor: UIColor = .white
    
    open var maximumMarkTintColor: UIColor = .white
    
    open var toShowMarkOnSelectedValue = true
    
    private var markContentView: UIView!
    
    open var markLabelFont: UIFont?
    
    private var validMarkValues: [String] {
        return markValues
    }
    
    public func setMarkerColors() {
        for i in markViews {
            i.backgroundColor = Float(i.tag) > value ? maximumMarkTintColor : minimumMarkTintColor
            if !toShowMarkOnSelectedValue &&  Float(i.tag) == value  {
                i.backgroundColor = .clear
            }
        }
    }
    
    public func drawMarks(in rect: CGRect) {
        if markContentView != nil {
            markContentView.removeFromSuperview()
            self.markViews.removeAll()
        }
        markContentView = UIView(frame: rect)
        markContentView.backgroundColor = .clear
        markContentView.isUserInteractionEnabled = false
        let trackViews = getSubviews(UIView.self)
        if let minimumTrackView = trackViews.last {
            insertSubview(markContentView, aboveSubview: minimumTrackView)
        } else {
            addSubview(markContentView)
        }
        let trackFrame = trackRect(forBounds: rect)
        let _markValues = validMarkValues
        for i in 0 ..< _markValues.count {
            let markValue = _markValues[i]
            let thumbFrame = thumbRect(forBounds: rect, trackRect: trackFrame, value: Float(i))
            switch markStyle {
            case .shape(let width, let height, let cornerRadius):
                let markRect = CGRect(x: thumbFrame.midX - width / 2, y: thumbFrame.midY - height / 2, width: width, height: height)
                let markView = UIView(frame: markRect)
                markView.layer.masksToBounds = true
                markView.tag = i
                markView.layer.cornerRadius = cornerRadius
                markView.backgroundColor = Float(i) > value ? maximumMarkTintColor : minimumMarkTintColor
                if !toShowMarkOnSelectedValue && Float(markView.tag) == value  {
                    markView.backgroundColor = .clear
                }
                markContentView.addSubview(markView)
                markViews.append(markView)
                
                
                let widdddd = "\(markValue)".widthOfString(usingFont: UIFont.systemFont(ofSize: 12))
                let markRect1 = CGRect(x: (thumbFrame.midX - width / 2) - (widdddd/2 - 2), y: (thumbFrame.midY - height / 2) + 20, width: widdddd, height: 20)
                let markLabel = UILabel(frame: markRect1)
                markLabel.layer.masksToBounds = true
                markLabel.textColor = .white
                markLabel.layer.cornerRadius = cornerRadius
                markLabel.backgroundColor = .clear
                if let font = self.markLabelFont {
                    markLabel.font = font
                }else {
                    markLabel.font = UIFont.systemFont(ofSize: 15)
                }
                
                markLabel.adjustsFontSizeToFitWidth = true
                markLabel.text = "\(markValue)"
                markContentView.addSubview(markLabel)
            case .image(let image):
                let imageWidth = image.size.width
                let imageHeight = image.size.height
                let markRect = CGRect(x: thumbFrame.midX - imageWidth / 2, y: thumbFrame.midY - imageHeight / 2, width: imageWidth, height: imageHeight)
                let markView = UIImageView(frame: markRect)
                markView.image = image
                markView.tintColor = Float(i) > value ? maximumMarkTintColor : minimumMarkTintColor
                markContentView.addSubview(markView)
            }
        }
    }
    
    func printHello() {
        print("hello")
    }
}

extension CustomSlider {
    public func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        self.setMarkerColors()
        let location = sender.location(in: self)
        let percent = minimumValue + Float(location.x / bounds.width) * maximumValue
        setValue(percent, animated: false)
        sendActions(for: .valueChanged)
    }
}

