//
//  VM_ExchangeImageView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 09/10/2022.
//

import SwiftUI
import Combine



class VM_ExchangeImageView: ObservableObject{
    @Published var exchangeImage: UIImage?
    @Published var isLoading: Bool = false
    
    private let exchange: ExchangeModel
    private let exchangeService: ExchangeImageService
    
    
    private var cancellables = Set<AnyCancellable>()
    
    init(exchange: ExchangeModel){
        self.exchange = exchange
        self.exchangeService = ExchangeImageService(exchange: exchange)
        self.addSubscribers()
        self.isLoading = true
    }
    
    
    
    private func addSubscribers(){
        exchangeService.$image
            .sink {[weak self] _ in
                guard let self = self else {return}
                self.isLoading = false
            } receiveValue: {[weak self] returnedImage in
                guard let self = self else {return}
                self.exchangeImage = returnedImage
            }
            .store(in: &cancellables)

    }
    
}
