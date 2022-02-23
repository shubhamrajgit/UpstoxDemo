//
//  String_Ext.swift
//  UpstoxDemo
//
//  Created by Shubham Raj on 13/02/22.
//

import Foundation

extension String {
    func addRupee() -> String {
        if self.isEmpty {
            return ""
        }
        return "\(UTConstants.kRupee)" + " " + self
    }
}
