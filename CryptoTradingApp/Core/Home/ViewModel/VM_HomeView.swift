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
    
    private let dataService = CoinDataService()
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
            .combineLatest(dataService.$allCoins)
            .map{(text, startingCoins) -> [CoinModel] in
                guard !text.isEmpty else { return startingCoins}
                
                let lowercasedText = text.lowercased()
                
                let filteredArray = startingCoins.filter { coin in
                    return coin.id.lowercased().contains(lowercasedText) || coin.name.lowercased().contains(lowercasedText) || coin.symbol.lowercased().contains(lowercasedText)
                }
                
                return filteredArray
            }
            .sink { [weak self] returnedArray in
                self?.allCoins = returnedArray
            }
            .store(in: &cancellables)
    }
}
