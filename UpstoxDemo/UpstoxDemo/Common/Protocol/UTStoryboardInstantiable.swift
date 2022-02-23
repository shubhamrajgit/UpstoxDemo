//
//  UTStoryboardInstantiable.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 12/02/22.
//

import UIKit

public protocol UTStoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ bundle: Bundle?) -> T
}

public extension UTStoryboardInstantiable where Self: UIViewController {
    static var defaultFileName: String {
        return "Main"
    }
    
    static func instantiateViewController(_ bundle: Bundle? = nil) -> Self {
        let fileName = defaultFileName
        let storyboard = UIStoryboard(name: fileName, bundle: bundle)
        guard let vc = storyboard.instantiateViewController(identifier: String(describing: self)) as? Self else {
            
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(fileName)")
        }
        return vc
    }
}
