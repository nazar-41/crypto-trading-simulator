//
//  MarketDataModel.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 10/10/2022.
//


//MARK: returned data
/*
 
 
 URL: https://api.coingecko.com/api/v3/global

 
 {
   "data": {
     "active_cryptocurrencies": 13170,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 590,
     "total_market_cap": {
       "btc": 50525998.33194433,
       "eth": 743573526.282519,
       "usd": 976913962845.9963
     },
     "total_volume": {
       "btc": 2059546.1820321502,
       "eth": 30309624.107855063,
       "usd": 39821072097.0814
     },
     "market_cap_percentage": {
       "btc": 37.95085823742517,
       "eth": 16.246531420201848,
       "usdt": 7.00328030830201,
       "usdc": 4.7171982092845015,
       "bnb": 4.590426618617069,
       "xrp": 2.638239973612279,
       "busd": 2.2233866767714283,
       "ada": 1.4431544523930286,
       "sol": 1.1966181550276824,
       "doge": 0.8504144887947288
     },
     "market_cap_change_percentage_24h_usd": -0.420371648064717,
     "updated_at": 1665396737
   }
 }
 */


struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - DataClass
struct MarketDataModel: Codable {
    let activeCryptocurrencies: Int
    let markets: Int
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double

    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case markets
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: Double{
        if let item = totalMarketCap.first(where: {$0.key == "usd"}){
            return item.value
        }
        
        return 0
    }
    
    var volume: Double{
        if let item = totalVolume.first(where: {$0.key == "usd"}){
            return item.value
        }
        
        return 0
    }
    
    var bitcoinDominance: Double{
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return item.value
        }
        
        return 0
    }
}
