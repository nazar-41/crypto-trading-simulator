//
//  ExchangeDataService.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 07/10/2022.
//

import Foundation
import Combine

class ExchangeDataService{
    @Published var allExchanges: [ExchangeModel] = []
    
    var exchangeSubscription: AnyCancellable?
    
    
    
    init(){
        getExchanges()
    }
    
    private func getExchanges(){
        guard let url = URL(string: API.exchange_list_api) else{
            print("invalid exchange list url")
            return
        }
        
        exchangeSubscription = NetworkingManger.download(url: url)
            .decode(type: [ExchangeModel].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManger.handleComlition, receiveValue: {[weak self] returnedModel in
                guard let self = self else{return}
                
                print("\nreturned exhange list")
                print("\n \(returnedModel) \n")
                
                self.allExchanges = returnedModel
                self.exchangeSubscription?.cancel()
            })
        
    }
}
