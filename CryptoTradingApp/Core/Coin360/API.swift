//
//  API.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 01/10/2022.
//

import Foundation


class API{
    
    static let coin_list_api: String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
    
    static let exchange_list_api: String = "https://api.coingecko.com/api/v3/exchanges?per_page=250&page=1"
    
    
}
