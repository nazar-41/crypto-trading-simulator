//
//  ExchangeModel.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 06/10/2022.
//

import Foundation

struct ExchangeModel: Identifiable, Codable{
    let id: String?
    let name: String?
    let yearEstablished: Int?
    let country: String?
    let description: String?
    let url: String?
    let image: String?
    let hasTradingIncentive: Bool?
    let trustScore: Int?
    let trustScoreRank: Int?
    let tradeVolume24hBTC: Double?
    let tradeVolume24hBTCNormalized: Double?
    
    
    enum CodingKeys: String, CodingKey{
        case id, name
        case yearEstablished = "year_established"
        case country, description, url, image
        case hasTradingIncentive = "has_trading_incentive"
        case trustScore = "trust_score"
        case trustScoreRank = "trust_score_rank"
        case tradeVolume24hBTC = "trade_volume_24h_btc"
        case tradeVolume24hBTCNormalized = "trade_volume_24h_btc_normalized"
    }
    
    
    func tradeVolume24hUSD(btcPrice: Double)-> Int{
        return Int(btcPrice * (tradeVolume24hBTC ?? 0))

    }
}


/*
 
 {
 "id": "binance",
 "name": "Binance",
 "year_established": 2017,
 "country": "Cayman Islands",
 "description": "",
 "url": "https://www.binance.com/",
 "image": "https://assets.coingecko.com/markets/images/52/small/binance.jpg?1519353250",
 "has_trading_incentive": false,
 "trust_score": 10,
 "trust_score_rank": 1,
 "trade_volume_24h_btc": 603955.4708359635,
 "trade_volume_24h_btc_normalized": 603955.4708359635
 },
 
 
 */
