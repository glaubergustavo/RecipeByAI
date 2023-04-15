//
//  Extension.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 08/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import Foundation
import UIKit
import Charts

extension UIColor {
    static func yellowColor() -> UIColor {
        return UIColor.init(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIView {
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    func configViewAppearance() {
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.orange.withAlphaComponent(0.50).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        
    }
    
    func shadowAnimation(transform: CGAffineTransform, size: CGSize) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = transform
            self.layer.shadowOpacity = 1
            self.layer.shadowOffset = size
            self.layer.shadowRadius = 4
        })
    }
}

