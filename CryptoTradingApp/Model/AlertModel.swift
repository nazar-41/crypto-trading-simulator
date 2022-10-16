//
//  AlertModel.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 16/10/2022.
//

import Foundation


struct AlertModel: Identifiable{
    let id = UUID().uuidString
    
    let title: String
    let message: String
}
