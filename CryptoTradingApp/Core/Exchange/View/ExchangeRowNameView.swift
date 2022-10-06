//
//  ExchangeRowView.swift
//  CryptoTradingApp
//
//  Created by Belli's MacBook on 04/10/2022.
//

import SwiftUI

struct ExchangeRowNameView: View {
    let name: String
    let image: UIImage?
    let rank: Int
    
    var body: some View {
        HStack{
            if let image = image{
                Image(uiImage: image)
            }else{
                Circle()
             //   ProgressView()
                    .frame(width: 30, height: 30)
            }
            
            VStack(alignment: .leading, spacing: 0){
                Text(name)
                    .lineLimit(2)
                    .font(.system(size: 15, weight: .medium))
                
                ZStack{
                    
                    Color.gray.opacity(0.3).cornerRadius(5)
                        .frame(width: 20, height: 20)
                    
                    Text("\(rank)")
                        .font(.system(size: 12, weight: .medium))
                }
            }
        }
    }
}

struct ExchangeRowView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRowNameView(name: "Binance", image: nil, rank: 1)
    }
}
