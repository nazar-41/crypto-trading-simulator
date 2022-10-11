//
//  ExchangeImageView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 09/10/2022.
//

import SwiftUI

struct ExchangeImageView: View {
    @StateObject private var vm_exchangeImageView: VM_ExchangeImageView
    
    init(exchange: ExchangeModel){
        _vm_exchangeImageView = StateObject(wrappedValue: VM_ExchangeImageView(exchange: exchange))
    }
    
    var body: some View {
        ZStack{
            if let image = vm_exchangeImageView.exchangeImage{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .onAppear{
                        print("\n image size: \(image.getSizeIn(.kilobyte))")
                    }
            }else if vm_exchangeImageView.isLoading{
                ProgressView()
            }else{
                Image(systemName: "questionmark")
            }
        }
    }
}

struct ExchangeImageView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeImageView(exchange: dev.exchange)
    }
}
