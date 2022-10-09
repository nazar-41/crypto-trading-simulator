//
//  ExchangeImageService.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 09/10/2022.
//

import Combine
import SwiftUI


class ExchangeImageService{
    @Published var image: UIImage?
    
    
    private var imageSubscription: AnyCancellable?
    private let exchange: ExchangeModel
    
//    private let fo
//    private let imageName: String?
    
    
    init(exchange: ExchangeModel){
        self.exchange = exchange
       // self.imageName = exchange.id
        
        getImage()
    }
    
    
    private func getImage(){
        guard let url = URL(string: exchange.image ?? "")else{
            print("invalid exchange image")
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
