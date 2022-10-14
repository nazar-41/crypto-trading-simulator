//
//  VM_TradeView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 12/10/2022.
//

import Foundation


class VM_TradeView: ObservableObject{
    
    @Published var buyAmount: String = ""
    @Published var sellAmount: String = ""
    
    private let coinDataService = CoinDataService()
    

    
    func getRandomCoinPriceArray(price: Double)-> [Double]{
        var coinArr: [Double] = []
        
        let startPrice = price * 0.99
        let endPrice = price * 1.01
        
        
        for _ in 0..<5{
            let rand = Double.random(in: startPrice...endPrice)
            
            coinArr.append(rand)
        }
        
        return coinArr.sorted(by: {$0 > $1})
    }
    
}
