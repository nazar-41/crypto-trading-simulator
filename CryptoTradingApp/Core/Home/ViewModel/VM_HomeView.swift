//
//  VM_HomeView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 26/09/2022.
//

import Foundation
import Combine


class VM_HomeView: ObservableObject{
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchBarText: String = ""
    
    @Published var btcPrice: Double?
    
    @Published var globalMarketData: MarketDataModel?
    
    private let coinDataService = CoinDataService()
    private let globalMarketDataService = MarketDataService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }

    func addSubscribers(){
//        dataService.$allCoins
//            .sink {[weak self] receivedCoins in
//                guard let self = self else{return}
//
//                self.allCoins = receivedCoins
//            }
//            .store(in: &cancellables)
        
        $searchBarText
            .combineLatest(coinDataService.$allCoins)
            //pause for 0.5 seconds
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedArray in
                guard let self = self else {return}
                self.allCoins = returnedArray
                
                self.getBtcPrice()
            }
            .store(in: &cancellables)
        
        globalMarketDataService.$marketData
            .sink {[weak self] receivedMarketData in
                guard let self = self else{return}
                self.globalMarketData = receivedMarketData
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, startingCoins: [CoinModel])-> [CoinModel]{
        guard !text.isEmpty else { return startingCoins}
        
        let lowercasedText = text.lowercased()
        
        let filteredArray = startingCoins.filter { coin in
            return coin.id.lowercased().contains(lowercasedText) || coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText)
        }
        
        return filteredArray
    }
    
    private func getBtcPrice(){
        if let btcModel = allCoins.first(where: {$0.id == "bitcoin"}){
            self.btcPrice = btcModel.currentPrice
            print("btc price is: \(String(describing: self.btcPrice))")
        }else{
            print("invalid btc price")
        }
        
//        if let btcPrice = allCoins.filter({$0.id == "bitcoin"}).first{
//            self.btcPrice = btcPrice.currentPrice
//            print("btc price is: \(self.btcPrice)")
//        }else{
//            print("invalid btc price")
//        }
    }
}
