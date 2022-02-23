//
//  UTUtility.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 13/02/22.
//

import Foundation
import UIKit

class UTUtility {
    
    class func getColorFor(_ val: Double) -> UIColor {
        if val < 0 {
            return UIColor.lossRedColor
        } else if val > 0 {
            return UIColor.profitGreenColor
        } else {
            return .darkGray
        }
    }
}
