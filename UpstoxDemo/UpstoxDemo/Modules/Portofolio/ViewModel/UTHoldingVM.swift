//
//  UTHoldingVM.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 12/02/22.
//

import Foundation

class UTHoldingVM {
    
    var observerBlock:((_ observerType: ObserverTypeEnum) -> Void)?
    private var holdingList: [UTHolding] = [] {
        didSet {
            observerBlock?(.dataLoaded)
        }
    }

    var dataSource: [UTHolding] {
        return holdingList
    }
    
    //MARK: - API CALL
    func fetchHoldingsData() {
        self.observerBlock?(.dataLoading)
        let urlStr = UTAPIEndpoints().holding
        NetworkManager().makeServerRequest(responseType: UTResultData.self, urlStr: urlStr) {[weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let response):
                self.holdingList = response.data
            case .failure(_):
                self.observerBlock?(.dataFailed)
            }
        }
    }
}

extension UTHoldingVM {
    
    func calculateBottomSheetValues() -> UTHoldingTotal {
        var currVal: Double = 0.0
        var totalInvstmnt: Double = 0.0
        var todayPL: Double = 0.0
        var totalPL: Double = 0.0
        
        for holding in holdingList {
            let qty = Double(holding.quantity ?? 0)
            
            guard let ltp = holding.ltp else { return UTHoldingTotal() }
            
            currVal += qty * ltp
            
            guard let avgPrice = Double(holding.avg_price ?? "0") else { return UTHoldingTotal() }
            
            totalInvstmnt += qty * avgPrice
            
            guard let close = holding.close else {
                return UTHoldingTotal()
            }
            
            todayPL += (close - ltp) * qty
        }
        
        totalPL = currVal - totalInvstmnt
        
        return UTHoldingTotal(currVal: currVal, totalInv: totalInvstmnt, todayPL: todayPL, totalPL: totalPL)
    }
}
