//
//  Integer.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 11/10/2022.
//

import Foundation


extension Int{
    private var currencyFormatter: NumberFormatter{
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        
        return formatter
    }
    
    func asCurrency()-> String{
        let nsNumber = NSNumber(value: self)
        return currencyFormatter.string(from: nsNumber) ?? "$0"
    }
}
