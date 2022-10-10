//
//  MarketDataService.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 10/10/2022.
//

import Combine
import Foundation


class MarketDataService{
    @Published var marketData: MarketDataModel?
    
    var marketDataSubscription: AnyCancellable?
    
    init(){
        getMarketData()
    }
    
    private func getMarketData(){
        guard let url = URL(string: API.market_data_api) else{
            print("invalid market data api")
            return
        }
        
        marketDataSubscription = NetworkingManger.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleComlition, receiveValue: {[weak self] returnedModel in
                guard let self = self else{return}
                
                self.marketData = returnedModel.data
                print("\n returned global market data")
                self.marketDataSubscription?.cancel()
            })
        
    }
}
