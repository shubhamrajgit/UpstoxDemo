//
//  UTHoldingCellVM.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 13/02/22.
//

import Foundation
import UIKit

class UTHoldingCellVM {
    
    private var holdingModel: UTHolding?
    
    init(model: UTHolding? = nil) {
        if let model = model {
            holdingModel = model
        }
    }
    
    var symbol: String {
        return holdingModel?.symbol ?? ""
    }
    
    var quantity: String {
        return "\(holdingModel?.quantity ?? 0)"
    }
    
    var ltp: String {
        return "\(holdingModel?.ltp ?? 0)".addRupee()
    }
    
    func getProfitLoss() -> (result: String, txtColor: UIColor) {
        if let holdModel = holdingModel {
            guard let qty = holdModel.quantity, let ltp = holdModel.ltp, let avgPrice = Double(holdModel.avg_price ?? "") else {
                return ("--", .black)
            }
            let currntVal = Double(qty) * ltp
            let totalInvst = Double(qty) * avgPrice
            let resultData = currntVal - totalInvst
            let color = UTUtility.getColorFor(resultData)
            let result = String(format: "%.2f", resultData)
            
            return (result.addRupee(), color)
        }
        return ("--", .black)
    }
    
    
}
