//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by 鈴木航太 on 2024/02/22.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard()  {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
