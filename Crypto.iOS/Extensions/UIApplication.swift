//
//  UIApplication.swift
//  Crypto.iOS
//
//  Created by Pratik Khopkar on 12/07/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
