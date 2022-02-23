//
//  UIView_Ext.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 13/02/22.
//

import Foundation
import UIKit

extension UIView {
    //Function: addBorder
    func roundedCorners(radius: CGFloat, borderColor: UIColor? = nil) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        if let bColor = borderColor {
            self.layer.borderWidth = 1
            self.layer.borderColor = bColor.cgColor
        }
    }
}
