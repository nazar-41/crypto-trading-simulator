//
//  CoinImageService.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 01/10/2022.
//

import SwiftUI
import Combine


class CoinImageService{
    @Published var image: UIImage?
    
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    
    
    init(coin: CoinModel){
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage(){
        guard let url = URL(string: coin.image) else{
            print("invalid coin image url")
            return
        }
        
       imageSubscription = NetworkingManger.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManger.handleComlition, receiveValue: {[weak self] returnedImage in
                guard let self = self else{return}
                
                self.image = returnedImage
                self.imageSubscription?.cancel()
            })
            
    }
}
