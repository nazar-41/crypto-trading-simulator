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
    
    @Published var searchBarText: String = ""
    
    private let dataService = ExchangeDataService()
    private var cancellables = Set<AnyCancellable>()
    
    
    
    init(){
        addSubscribers()
    }
    
    
    private func addSubscribers(){
//        dataService.$allExchanges
//            .sink {[weak self] returnedModel in
//                guard let self = self else{return}
//
//                self.allExchanges = returnedModel
//            }
//            .store(in: &cancellables)
        
        $searchBarText
            .combineLatest(dataService.$allExchanges)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterExchanges)
            .sink { [weak self] returnedArray in
                guard let self = self else {return}
                self.allExchanges = returnedArray
            }
            .store(in: &cancellables)
    }
    
    
    private func filterExchanges(text: String, startingExchanges: [ExchangeModel])-> [ExchangeModel]{
        guard !text.isEmpty else{return startingExchanges}
        
        let lowercasedText = text.lowercased()
        
        
        let filtered = startingExchanges.filter { exchange in
            return exchange.id.lowercased().contains(lowercasedText) ||
            exchange.name.lowercased().contains(lowercasedText)
        }
        
        return filtered
    }
}
