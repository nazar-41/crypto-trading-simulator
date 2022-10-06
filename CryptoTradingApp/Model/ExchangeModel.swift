//
//  ExchangeModel.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 06/10/2022.
//

import Foundation
import SwiftUI

struct ExchangeModel: Identifiable{
    let id = UUID().uuidString
    let rank: Int
    let score: Double
    let name: String
    let volume24hUSD: Double
    let volume24Percentage: Double
    let weeklyVisits: Int
    let coins: Int
    let image: UIImage?
    
}
