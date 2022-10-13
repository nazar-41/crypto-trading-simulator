//
//  VM_TradeView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 12/10/2022.
//

import Foundation


class VM_TradeView: ObservableObject{
    @Published var showCoinList: Bool = false
    
    @Published var buyAmount: String = ""
    @Published var sellAmount: String = ""
    
    
}
