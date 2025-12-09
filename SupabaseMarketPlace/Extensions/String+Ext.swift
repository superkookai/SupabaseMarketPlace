//
//  String+Ext.swift
//  SupabaseMarketPlace
//
//  Created by Weerawut Chaiyasomboon on 09/12/2568.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let regEx = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regEx).evaluate(with: self)
    }
}
