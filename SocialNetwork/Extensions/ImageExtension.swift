//
//  ImageExtension.swift
//  SocialNetwork
//
//  Created by rayner on 05/06/21.
//

import UIKit

//@IBDesignable
extension UIImageView {
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
