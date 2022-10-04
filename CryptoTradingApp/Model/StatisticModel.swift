//
//  StatisticModel.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 03/10/2022.
//

import Foundation

struct StatisticModel: Identifiable{
    let id = UUID().uuidString
    let title: String
    let value: String
    var percentage: Double? = nil
    
//    init(title: String, value: String, percentage: Double? = nil) {
//        self.title = title
//        self.value = value
//        self.percentage = percentage
//    }
}
