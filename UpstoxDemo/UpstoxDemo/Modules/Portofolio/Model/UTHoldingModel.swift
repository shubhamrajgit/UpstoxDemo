//
//  UTHoldingModel.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 12/02/22.
//

import Foundation

struct UTResultData: Codable {
//    var resultCount: Int?
    var data: [UTHolding]
    
}

struct UTHolding: Codable {
    var avg_price: String?
    var quantity: Int?
    var symbol: String?
    var ltp: Double?
    var close: Double?
}

struct UTHoldingTotal {
    var currVal: Double = 0
    var totalInv: Double = 0
    var todayPL: Double = 0
    var totalPL: Double = 0
}
