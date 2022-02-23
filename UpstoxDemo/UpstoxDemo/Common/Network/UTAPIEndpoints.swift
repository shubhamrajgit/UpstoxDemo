//
//  UTAPIEndpoints.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 12/02/22.
//

import Foundation

private enum UTEnvironment {
    case staging
    case production
    
    func baseUrl() -> String {
        return "\(urlProtocol())://\(domain())/\(route())"
    }
    
    func urlProtocol() -> String {
        return "https"
    }
    
    func domain() -> String {
        return "run.mocky.io"
    }
    
    func route() -> String {
        return "v3"
    }
}

struct UTAPIEndpoints {
    private let baseUrl = UTEnvironment.staging.baseUrl()
    var holding: String { return "\(baseUrl)/6d0ad460-f600-47a7-b973-4a779ebbaeaf" }
}
