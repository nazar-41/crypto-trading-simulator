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
    private let fileManager = LocalFileManger.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    
    init(coin: CoinModel){
        self.coin = coin
        self.imageName = coin.id
        
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let image = fileManager.getImage(folderName: folderName, imageName: imageName){
            self.image = image
            print("got image from fileManager")
        }else{
            downloadCoinImage()
            print("downloaded image")
        }
    }
    
    private func downloadCoinImage(){
        print("downloading image now")
        
        guard let url = URL(string: coin.image) else{
            print("invalid coin image url")
            return
        }
        
       imageSubscription = NetworkingManger.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManger.handleComlition, receiveValue: {[weak self] returnedImage in
                guard let self = self,
                      let downloadedImage = returnedImage else{return}
                
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, folderName: self.folderName, imageName: self.imageName)
            })
            
    }
}
