//
//  VM_CoinImageView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 01/10/2022.
//

import SwiftUI
import Combine

class VM_CionImageView: ObservableObject{
    @Published var coinImage: UIImage?
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let coinService: CoinImageService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: CoinModel){
        self.coin = coin
        self.coinService = CoinImageService(coin: coin)
        self.addImageSubscribers()
        self.isLoading = true
    }
    
    private func addImageSubscribers(){
        coinService.$image
            .sink {[weak self] _ in
                guard let self = self else{return}
                self.isLoading = false
            } receiveValue: {[weak self] returnedImage in
                guard let self = self else{return}
                self.coinImage = returnedImage
            }
            .store(in: &cancellables)

    }
}
