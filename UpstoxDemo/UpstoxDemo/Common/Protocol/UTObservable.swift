//
//  UTObservable.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 13/02/22.
//

import Foundation

enum ObserverTypeEnum {
      case dataLoading
      case dataLoaded
      case dataFailed
      case noNetwork
}

typealias ObserverBlock = ((_ observerType: ObserverTypeEnum)->Void)?

protocol UTObservableProtocol {
    var observerBlock: ObserverBlock { get }
}

class UTObservableType: NSObject, UTObservableProtocol {
    var observerBlock: ObserverBlock = nil
    
    override init() {
        super.init()
    }
}

