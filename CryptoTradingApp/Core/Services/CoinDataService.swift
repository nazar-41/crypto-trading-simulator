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
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else{
            print("invalid url")
            return
        }
        
        
       coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output)-> Data in
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else{
                    print("\nerror: bad response\n")
                    throw URLError(.badServerResponse)
                }
                
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { complition in
                switch complition{
                case .finished:
                    break
                case .failure(let error):
                    print("\nerror: \(error)\n")
                }
            } receiveValue: {[weak self] returnedModel in
                guard let self = self else{return}
                
                print("\nreturned model: \(returnedModel)\n")
                
                self.allCoins = returnedModel
                self.coinSubscription?.cancel()
            }


    }
}
