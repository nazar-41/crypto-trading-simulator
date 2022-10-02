//
//  CoinImageView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 01/10/2022.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject private var vm_coinimageview: VM_CionImageView
    
    init(coin: CoinModel){
        _vm_coinimageview = StateObject(wrappedValue: VM_CionImageView(coin: coin))
    }
    
    var body: some View {
        ZStack{
            if let image = vm_coinimageview.coinImage{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }else if vm_coinimageview.isLoading{
                ProgressView()
            }else{
                Image(systemName: "questionmark")
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
