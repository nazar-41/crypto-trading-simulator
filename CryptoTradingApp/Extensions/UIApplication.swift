//
//  UIApplication.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 02/10/2022.
//

import SwiftUI



extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
