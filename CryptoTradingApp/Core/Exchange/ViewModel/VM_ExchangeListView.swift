//
//  VM_ExchangeListView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 07/10/2022.
//

import Foundation
import Combine


class VM_ExchangeListView: ObservableObject{
    @Published var allExchanges: [ExchangeModel] = []
    
    private let dataService = ExchangeDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        addSubscribers()
    }
    
    
    private func addSubscribers(){
        dataService.$allExchanges
            .sink {[weak self] returnedModel in
                guard let self = self else{return}
                
                self.allExchanges = returnedModel
            }
            .store(in: &cancellables)
    }
}
