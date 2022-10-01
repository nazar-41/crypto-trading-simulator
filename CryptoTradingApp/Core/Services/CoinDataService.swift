//
//  CoinDataService.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 27/09/2022.
//

import Foundation
import Combine

class CoinDataService{
    @Published var allCoins: [CoinModel] = []

    var coinSubscription: AnyCancellable?
    
    
    init(){
        getCoins()
    }
    
    
    private func getCoins(){
        guard let url = URL(string: API.coin_list_api) else{
            print("invalid url: coindataservice")
            return
        }
        
        
        coinSubscription = NetworkingManger.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleComlition, receiveValue: {[weak self] returnedModel in
                guard let self = self else{return}
                
                print("\nreturned model")
                
                self.allCoins = returnedModel
                self.coinSubscription?.cancel()
            })


    }
}
