//
//  UIView+layer.swift
//  Vehicle Maintenance
//
//  Created by Sher on 2020-03-26.
//  Copyright © 2020 Sher Khan. All rights reserved.
//

import UIKit

// MARK: - UIView Shadow
extension UIView {
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            guard let color = layer.shadowColor else {
                return .clear
            }
            return UIColor(cgColor: color)
        }
        
        set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    
}


// MARK: - UIView Border
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            guard let color = layer.borderColor else {
                return .clear
            }
            return UIColor(cgColor: color)
        }
        
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}


// MARK: - Shadow helper All-in-One
extension UIView {
    
    func setShadowWith(color: UIColor, opacity: Float, offsetWidth: CGFloat, offsetHeight: CGFloat, radius: CGFloat) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
        self.layer.shadowRadius = radius
    }
}
