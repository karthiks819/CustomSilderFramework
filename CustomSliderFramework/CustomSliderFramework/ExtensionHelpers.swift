//
//  ExtensionHelpers.swift
//  CustomSliderFramework
//
//  Created by Karthiks on 02/04/23.
//

import Foundation
import UIKit

public extension UIView {
    func getSubviews<T: UIView>(_ type: T.Type) -> [T] {
        return subviews.filter { $0.isMember(of: type) } as? [T] ?? []
    }
}

public extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}
