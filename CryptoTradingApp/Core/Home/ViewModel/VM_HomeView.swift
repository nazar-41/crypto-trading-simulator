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
        dataService.$allCoins
            .sink {[weak self] receivedCoins in
                guard let self = self else{return}
                
                self.allCoins = receivedCoins
            }
            .store(in: &cancellables)
    }
}
