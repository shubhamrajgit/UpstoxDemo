//
//  UTAlertable.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 13/02/22.
//

import Foundation
import UIKit

public protocol UTAlertable {}
public extension UTAlertable where Self: UIViewController {
    
    func showAlert(title: String = "", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
