//
//  String.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import Foundation

extension String {
    var removingHTMLOccurancies: String {
        return self.replacingOccurrences(of: "<[ˆ>]+>", with: "", options: .regularExpression, range: nil)
    }
}
