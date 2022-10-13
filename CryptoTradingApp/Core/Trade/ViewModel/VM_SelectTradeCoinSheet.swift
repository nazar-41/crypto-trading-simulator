//
//  VM_SelectTradeCoinSheet.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 13/10/2022.
//

import Foundation
import Combine


class VM_SelectTradeCoinSheet: ObservableObject{
    @Published var searchBarText: String = ""
    
    
    @Published var allCoins: [CoinModel]?
    
 
    private let coinDataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    private func addSubscribers(){
        $searchBarText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                guard let self = self else {return}
                self.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    
    
    private func filterCoins(text: String, startingCoins: [CoinModel])-> [CoinModel]{
        guard !text.isEmpty else {return startingCoins}
        
        let lowercasedText = text.lowercased()
        
        let filteredCoins = startingCoins.filter { coin in
            return coin.id.lowercased().contains(lowercasedText) || coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText)
        }
        
        return filteredCoins
    }
}
